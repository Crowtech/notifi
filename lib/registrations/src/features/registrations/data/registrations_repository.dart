import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:notifi/credentials.dart';
import 'package:notifi/models/nestfilter.dart';
import 'package:notifi/models/organization.dart';
import 'package:notifi/models/person.dart';
import 'package:notifi/organizations/src/features/organizations/presentation/organizations/selected_organizations.dart';
import 'package:notifi/organizations/src/utils/dio_provider.dart';
import 'package:notifi/persons/src/utils/cancel_token_ref.dart';
import 'package:notifi/state/nest_auth2.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:logger/logger.dart' as logger;

import '../../../../../models/registration.dart';
import '../domain/registrations_response.dart';

part 'registrations_repository.g.dart';

var log = logger.Logger(
  printer: logger.PrettyPrinter(),
  level: logger.Level.info,
);

var logNoStack = logger.Logger(
  printer: logger.PrettyPrinter(methodCount: 0),
  level: logger.Level.info,
);

/// Metadata used when fetching registrations with the paginated search API.
typedef NestQueryData = ({String query, int page});

class RegistrationsRepository {
  const RegistrationsRepository(
      {required this.client,
      required this.token,
      required this.currentUser,
      required this.selectedOrganizations});
  final Dio client;
  final String token;
  final Person currentUser;
  final List<Organization> selectedOrganizations;

  Future<RegistrationsResponse> searchRegistrations(
      {required NestQueryData queryData, CancelToken? cancelToken}) async {
    NestFilter nf = NestFilter(offset: queryData.page);
    var data = jsonEncode(nf);
    logNoStack.i(
        "REGISTRATIONS_REPOSITORY: search currentUserId=${currentUser.id} token=${token.substring(0, 10)}");

    final uri = Uri(
      scheme: 'https',
      host: defaultAPIBaseUrl.substring("https://".length),
      path: "$defaultApiPrefixPath/registrations/fetch/${currentUser.id}",
      // queryParameters: {
      //   'api_key': token,
      //   'include_adult': 'false',
      //   'page': '${queryData.page}',
      //   'query': queryData.query,
      // },
    );
    Options options = Options(headers: {
      "accept": 'application/json',
      "Authorization": 'Bearer $token'
    });

    final response = await client.postUri(uri,
        options: options, data: data, cancelToken: cancelToken);

    logNoStack.i("REGISTRATIONS_REPOSITORY ######: ${response.data}");

    return RegistrationsResponse.fromJson(response.data);
  }

  Future<RegistrationsResponse> nowPlayingRegistrations(
      {required int page, CancelToken? cancelToken}) async {
    NestFilter nf = NestFilter(offset: page);
    var data = jsonEncode(nf);
    logNoStack.i(
        "REGISTRATIONS_REPOSITORY: now Playing currentUserId=${currentUser.id} token=${token.substring(0, 10)}");

   
    final uri = Uri(
      scheme: 'https',
      host: defaultAPIBaseUrl.substring("https://".length),
      path: "$defaultApiPrefixPath/registrations/get/",
      // queryParameters: {
      //   'api_key': token,
      //   'include_adult': 'false',
      //   'language': 'en-US',
      //   'page': '$page',
      // },
    );
    Options options = Options(headers: {
      "Content-Type": 'application/json',
      "accept": 'application/json',
      "Authorization": 'Bearer $token'
    });

    logNoStack.i("REGISTRATIONS_REPOSITORY: now Playing uri=${uri.toString()}");
    final response = await client.postUri(uri,
        options: options, data: data, cancelToken: cancelToken);

    logNoStack
        .i("REGISTRATIONS_REPOSITORY: !fetching for list , responseData=${response.data}");
    RegistrationsResponse rr =  RegistrationsResponse.fromJson(response.data);
    logNoStack.i("REGISTRATIONS_REPOSITORY AFTER JSON ${rr.items}");
    return rr;
  }

  Future<Registration> registration({required int registrationId, CancelToken? cancelToken}) async {
    logNoStack.i(
        "REGISTRATIONS_REPOSITORY: registration currentUserId=${currentUser.id} token=${token.substring(0, 10)}");
    final url = Uri(
      scheme: 'https',
      host: defaultAPIBaseUrl.substring("https://".length),
      path: "$defaultApiPrefixPath/registrations/get/$registrationId}",
      // queryParameters: {
      //   'api_key': token,
      //   'include_adult': 'false',
      // },
    ).toString();

    Options options = Options(headers: {
      "accept": 'application/json',
      "Authorization": 'Bearer $token'
    });

    final response =
        await client.get(url, options: options, cancelToken: cancelToken);
        logNoStack.i("REGISTRATIONS_REPOSITORY: @@@@@ ${response.data}");
    return Registration.fromJson(response.data);
  }
}

@riverpod
RegistrationsRepository registrationsRepository(RegistrationsRepositoryRef ref) =>
    RegistrationsRepository(
      client: ref.watch(dioProvider),
      token: ref.read(nestAuthProvider.notifier).token!,
      currentUser: ref.read(nestAuthProvider.notifier).currentUser,
      selectedOrganizations: ref.read(selectedOrganizationsProvider),
    );

class AbortedException implements Exception {}

/// Provider to fetch a registration by ID
@riverpod
Future<Registration> registration(
  RegistrationRef ref, {
  required int registrationId,
}) {
  final cancelToken = ref.cancelToken();
  return ref
      .watch(registrationsRepositoryProvider)
      .registration(registrationId: registrationId, cancelToken: cancelToken);
}

/// Provider to fetch paginated registrations data
@riverpod
Future<RegistrationsResponse> fetchRegistrations(
  FetchRegistrationsRef ref, {
  required NestQueryData queryData,
}) async {
  final registrationsRepo = ref.watch(registrationsRepositoryProvider);
  // See this for how the timeout is implemented:
  // https://codewithandrea.com/articles/flutter-riverpod-data-caching-providers-lifecycle/#caching-with-timeout
  // Cancel the page request if the UI no longer needs it.
  // This happens if the user scrolls very fast or if we type a different search
  // term.
  final cancelToken = CancelToken();
  // When a page is no-longer used, keep it in the cache.
  final link = ref.keepAlive();
  // a timer to be used by the callbacks below
  Timer? timer;
  // When the provider is destroyed, cancel the http request and the timer
  ref.onDispose(() {
    cancelToken.cancel();
    timer?.cancel();
  });
  // When the last listener is removed, start a timer to dispose the cached data
  ref.onCancel(() {
    // start a 30 second timer
    timer = Timer(const Duration(seconds: 30), () {
      // dispose on timeout
      link.close();
    });
  });
  // If the provider is listened again after it was paused, cancel the timer
  ref.onResume(() {
    timer?.cancel();
  });

  if (queryData.query.isEmpty) {
    // use non-search endpoint
    return registrationsRepo.nowPlayingRegistrations(
      page: queryData.page,
      cancelToken: cancelToken,
    );
  } else {
    // use search endpoint
    return registrationsRepo.searchRegistrations(
      queryData: queryData,
      cancelToken: cancelToken,
    );
  }
}

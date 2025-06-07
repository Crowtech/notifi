import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:notifi/credentials.dart';
import 'package:notifi/models/nestfilter.dart';
import 'package:notifi/models/organization.dart';
import 'package:notifi/models/person.dart';
import 'package:notifi/organizations/src/features/organizations/presentation/organizations/selected_organizations.dart';
import 'package:notifi/state/nest_auth2.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:notifi/persons/src/utils/cancel_token_ref.dart';
import 'package:notifi/persons/src/utils/dio_provider.dart';
import 'package:logger/logger.dart' as logger;

import '../domain/nperson.dart';
import '../domain/nperson_response.dart';

part 'persons_repository.g.dart';

var log = logger.Logger(
  printer: logger.PrettyPrinter(),
  level: logger.Level.info,
);

var logNoStack = logger.Logger(
  printer: logger.PrettyPrinter(methodCount: 0),
  level: logger.Level.info,
);

/// Metadata used when fetching persons with the paginated search API.
typedef NestQueryData = ({String query, int page});

class PersonsRepository {
  const PersonsRepository(
      {required this.client,
      required this.token,
      required this.currentUser,
      required this.selectedOrganizations});
  final Dio client;
  final String token;
  final Person currentUser;
  final List<Organization> selectedOrganizations;

  Future<NPersonsResponse> searchPersons(
      {required NestQueryData queryData, CancelToken? cancelToken}) async {
    NestFilter nf = NestFilter(offset: queryData.page);
    var data = jsonEncode(nf);
    logNoStack.i(
        "PERSONS_REPOSITORY: search currentUserId=${currentUser.id} token=${token.substring(0, 10)}");


    if (currentUser.orgid != null) {
      currentUser.orgid!;
    }
    //   if (!(selectedOrganizations.isEmpty)) {
    //   sourceOrgId = selectedOrganizations.first.id!;
    // }

    String host = defaultAPIBaseUrl.substring("https://".length);
    String path = "$defaultApiPrefixPath/resources/targets/0";
    final uri = Uri(
      scheme: 'https',
      host: host,
      path: path,
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

  logNoStack.i("host: $host$path $data");
    final response = await client.postUri(uri,
        options: options, data: data, cancelToken: cancelToken);

    return NPersonsResponse.fromJson(response.data);
  }

  Future<NPersonsResponse> nowPlayingPersons(
      {required int page, CancelToken? cancelToken}) async {
        var data = null;
    NestFilter nf = NestFilter(offset: page);
    
    logNoStack.i(
        "PERSONS_REPOSITORY: now Playing currentUserId=${currentUser.id} token=${token.substring(0, 10)}");

    int sourceOrgId = 10251;
    // if (currentUser != null) {
    //   if (currentUser.orgid != null) {
    //     currentUser.orgid!;
    //   }
    // }

    if (!(selectedOrganizations.isEmpty)) {
      String listOfOrgs = "";
      List<int> orgList = [];
      for (Organization o in selectedOrganizations) {
        listOfOrgs += "${o.id}:${o.name}\n";
        orgList.add(o.id!);
      }
      nf.orgIdList = orgList;
      data = jsonEncode(nf);
      logNoStack.i("nf person: ${nf}");
      logNoStack.i(listOfOrgs);
     // sourceOrgId = selectedOrganizations.first.id!;
    }
    final uri = Uri(
      scheme: 'https',
      host: defaultAPIBaseUrl.substring("https://".length),
      path: "$defaultApiPrefixPath/resources/targets/0",
      //path: "$defaultApiPrefixPath/resources/targets/0', //$sourceOrgId",
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

    logNoStack.i("PERSONS_REPOSITORY: now Playing uri=${uri.toString()}");
    final response = await client.postUri(uri,
        options: options, data: data, cancelToken: cancelToken);

    logNoStack
        .i("PERSONS_REPOSITORY: now Playing , responseData=${response.data}");
    return NPersonsResponse.fromJson(response.data);
  }

  Future<NPerson> person({required int orgId, CancelToken? cancelToken}) async {
    logNoStack.i(
        "PERSONS_REPOSITORY: person currentUserId=${currentUser.id} token=${token.substring(0, 10)}");
    final url = Uri(
      scheme: 'https',
      host: defaultAPIBaseUrl.substring("https://".length),
      path: "$defaultApiPrefixPath/persons/get/$orgId}",
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
    return NPerson.fromJson(response.data);
  }
}

@riverpod
PersonsRepository personsRepository(PersonsRepositoryRef ref) =>
    PersonsRepository(
      client: ref.watch(dioProvider),
      token: ref.read(nestAuthProvider.notifier).token!,
      currentUser: ref.read(nestAuthProvider.notifier).currentUser,
      selectedOrganizations: ref.read(selectedOrganizationsProvider),
    );

class AbortedException implements Exception {}

/// Provider to fetch a person by ID
@riverpod
Future<NPerson> person(
  PersonRef ref, {
  required int personId,
}) {
  final cancelToken = ref.cancelToken();
  return ref
      .watch(personsRepositoryProvider)
      .person(orgId: personId, cancelToken: cancelToken);
}

/// Provider to fetch paginated persons data
@riverpod
Future<NPersonsResponse> fetchPersons(
  FetchPersonsRef ref, {
  required NestQueryData queryData,
}) async {
  final personsRepo = ref.watch(personsRepositoryProvider);
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
    return personsRepo.nowPlayingPersons(
      page: queryData.page,
      cancelToken: cancelToken,
    );
  } else {
    // use search endpoint
    return personsRepo.searchPersons(
      queryData: queryData,
      cancelToken: cancelToken,
    );
  }
}

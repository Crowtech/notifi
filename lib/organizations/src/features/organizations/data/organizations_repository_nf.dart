import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:notifi/credentials.dart';
import 'package:notifi/models/nestfilter.dart';
import 'package:notifi/models/organization.dart';
import 'package:notifi/models/person.dart';
import 'package:notifi/persons/src/utils/cancel_token_ref.dart';
import 'package:notifi/state/nest_auth2.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';


import 'package:notifi/organizations/src/utils/dio_provider.dart';
import 'package:logger/logger.dart' as logger;

import '../domain/organization_response.dart';

part 'organizations_repository_nf.g.dart';

var log = logger.Logger(
  printer: logger.PrettyPrinter(),
  level: logger.Level.info,
);

var logNoStack = logger.Logger(
  printer: logger.PrettyPrinter(methodCount: 0),
  level: logger.Level.info,
);

/// Metadata used when fetching organizations with the paginated search API.
//typedef NestQueryData = ({String query, int page});

class OrganizationsRepositoryNestFilter {
  const OrganizationsRepositoryNestFilter(
      {required this.client, required this.token, required this.currentUser});
  final Dio client;
  final String token;
  final Person currentUser;

  Future<OrganizationsResponse> searchOrganizations(
      {required NestFilter nestFilter, CancelToken? cancelToken}) async {
  
    var data = jsonEncode(nestFilter);
    logNoStack.i(
        "ORGANIZATIONS_REPOSITORY_NF: search currentUserId=${currentUser.id} token=${token.substring(0, 10)} nestfilter=$nestFilter");
    final uri = Uri(
      scheme: defaultAPIBaseUrl.substring(0,defaultAPIBaseUrl.indexOf(":")),
      host: defaultAPIBaseUrl.substring("https://".length),
      path: "$defaultApiPrefixPath/resources/sources/${currentUser.id}",
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
    logNoStack.i("ORGANIZATIONS_REPOSITORY_NF: response ${response.data}");
    return OrganizationsResponse.fromJson(response.data);
  }

  Future<OrganizationsResponse> allOrganizations(
      {required NestFilter nestFilter, CancelToken? cancelToken}) async {
    var data = jsonEncode(nestFilter);
    logNoStack.i(
        "ORGANIZATIONS_REPOSITORY_NF: all Orgs currentUserId=${currentUser.id} token=${token.substring(0, 10)} $nestFilter");
//     logNoStack.i("ORGANIZATIONS_REPOSITORY_NF: all Orgs: scheme:${defaultAPIBaseUrl.substring(0,defaultAPIBaseUrl.indexOf(":"))}");
//     logNoStack.i("ORGANIZATIONS_REPOSITORY_NF: all Orgs: host:${defaultAPIBaseUrl.substring(defaultAPIBaseUrl.indexOf(":")+3)}");
// logNoStack.i("ORGANIZATIONS_REPOSITORY_NF: all Orgs: path:${defaultApiPrefixPath}/resources/sources/${currentUser.id}}");

    final uri = Uri(
      scheme: defaultAPIBaseUrl.substring(0,defaultAPIBaseUrl.indexOf(":")),
      host: defaultAPIBaseUrl.substring(defaultAPIBaseUrl.indexOf(":")+3),
      path: "$defaultApiPrefixPath/resources/sources/${currentUser.id}",
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

    logNoStack.i("ORGANIZATIONS_REPOSITORY_NF: all Orgs uri=${uri.toString()} about to call api");
    final response = await client.postUri(uri,
        options: options, data: data, cancelToken: cancelToken);

    logNoStack
        .d("ORGANIZATIONS_REPOSITORY_NF: all Orgs back from api, responseData=${response.data}");

    OrganizationsResponse or = OrganizationsResponse.fromJson(response.data);
    logNoStack.i("ORGANIZATIONS_REPOSITORY_NF: all Orgs back from api ${or.results}");
    return or;
  }

  Future<Organization> organization(
      {required int orgId, CancelToken? cancelToken}) async {
    logNoStack.i(
        "ORGANIZATIONS_REPOSITORY_NF: organization currentUserId=${currentUser.id} token=${token.substring(0, 10)}");
    final url = Uri(
      scheme: defaultAPIBaseUrl.substring(0,defaultAPIBaseUrl.indexOf(":")),
      host: defaultAPIBaseUrl.substring(defaultAPIBaseUrl.indexOf(":")+3),
      path: "$defaultApiPrefixPath/organizations/get/$orgId}",
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
    return Organization.fromJson(response.data);
  }
}

@riverpod
OrganizationsRepositoryNestFilter organizationsRepositoryNestFilter(OrganizationsRepositoryNestFilterRef ref) => OrganizationsRepositoryNestFilter(
      client: ref.watch(dioProvider),
      token: ref.read(nestAuthProvider.notifier).token!,
      currentUser: ref.read(nestAuthProvider.notifier).currentUser,
    );

class AbortedException implements Exception {}

/// Provider to fetch a organization by ID
@riverpod
Future<Organization> organization2(
  Organization2Ref ref, {
  required int organizationId,
}) {
  final cancelToken = ref.cancelToken();
  return ref
      .watch(organizationsRepositoryNestFilterProvider)
      .organization(orgId: organizationId, cancelToken: cancelToken);
}

/// Provider to fetch paginated organizations data
@riverpod
Future<OrganizationsResponse> fetchOrganizationsNestFilter(
  FetchOrganizationsNestFilterRef ref, {
  required NestFilter nestFilter,
}) async {
   //final organizationsRepo = ref.read(organizationsRepositoryNestFilterProvider);
  final organizationsRepo = ref.watch(organizationsRepositoryNestFilterProvider);
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
  //if (nestFilter.query.isEmpty) {
    // use non-search endpoint
    logNoStack.i("FETCH_ORG_NF: about to call allOrgs nf=$nestFilter");
    return organizationsRepo.allOrganizations(
      nestFilter: nestFilter,
      cancelToken: cancelToken,
    );
  // } else {
  //   // use search endpoint
  //   return organizationsRepo.searchOrganizations(
  //     nestFilter: nestFilter,
  //     cancelToken: cancelToken,
  //   );
  // }
}

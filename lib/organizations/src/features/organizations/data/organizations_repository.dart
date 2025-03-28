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

part 'organizations_repository.g.dart';

var log = logger.Logger(
  printer: logger.PrettyPrinter(),
  level: logger.Level.info,
);

var logNoStack = logger.Logger(
  printer: logger.PrettyPrinter(methodCount: 0),
  level: logger.Level.info,
);

// /// Metadata used when fetching organizations with the paginated search API.
// typedef NestQueryData = ({String query, int page});

// class OrganizationsRepository {
//   const OrganizationsRepository(
//       {required this.client, required this.token, required this.currentUser});
//   final Dio client;
//   final String token;
//   final Person currentUser;

//   Future<OrganizationsResponse> searchOrganizations(
//       {required NestQueryData queryData, CancelToken? cancelToken}) async {
//     NestFilter nf = NestFilter(offset: queryData.page);
//     nf.includeGPS = false;
//     var data = jsonEncode(nf);
//     logNoStack.i(
//         "ORGANIZATIONS_REPOSITORY: search currentUserId=${currentUser.id} token=${token.substring(0, 10)} netfilter=$NestFilter");
//     final uri = Uri(
//       scheme: defaultAPIBaseUrl.substring(0,defaultAPIBaseUrl.indexOf(":")),
//       host: defaultAPIBaseUrl.substring("https://".length),
//       path: "$defaultApiPrefixPath/resources/sources/${currentUser.id}",
//       // queryParameters: {
//       //   'api_key': token,
//       //   'include_adult': 'false',
//       //   'page': '${queryData.page}',
//       //   'query': queryData.query,
//       // },
//     );
//     Options options = Options(headers: {
//       "accept": 'application/json',
//       "Authorization": 'Bearer $token'
//     });

//     final response = await client.postUri(uri,
//         options: options, data: data, cancelToken: cancelToken);

//     return OrganizationsResponse.fromJson(response.data);
//   }

//   Future<OrganizationsResponse> nowPlayingOrganizations(
//       {required int page, CancelToken? cancelToken}) async {
//     NestFilter nf = NestFilter(offset: 0);
//     nf.includeGPS = false;
//     var data = jsonEncode(nf);
//     logNoStack.i(
//         "ORGANIZATIONS_REPOSITORY: now Playing currentUserId=${currentUser.id} token=${token.substring(0, 10)} $nf");
//     logNoStack.i("ORGANIZATIONS: nowPlayingOrgs: scheme:${defaultAPIBaseUrl.substring(0,defaultAPIBaseUrl.indexOf(":"))}");
//     logNoStack.i("ORGANIZATIONS: nowPlayingOrgs: host:${defaultAPIBaseUrl.substring(defaultAPIBaseUrl.indexOf(":")+3)}");
// logNoStack.i("ORGANIZATIONS: nowPlayingOrgs: path:${defaultApiPrefixPath}/resources/sources/${currentUser.id}}");

//     final uri = Uri(
//       scheme: defaultAPIBaseUrl.substring(0,defaultAPIBaseUrl.indexOf(":")),
//       host: defaultAPIBaseUrl.substring(defaultAPIBaseUrl.indexOf(":")+3),
//       path: "$defaultApiPrefixPath/resources/sources/${currentUser.id}",
//       // queryParameters: {
//       //   'api_key': token,
//       //   'include_adult': 'false',
//       //   'language': 'en-US',
//       //   'page': '$page',
//       // },
//     );
//     Options options = Options(headers: {
//       "Content-Type": 'application/json',
//       "accept": 'application/json',
//       "Authorization": 'Bearer $token'
//     });

//     logNoStack.i("ORGANIZATIONS_REPOSITORY: now Playing uri=${uri.toString()}");
//     final response = await client.postUri(uri,
//         options: options, data: data, cancelToken: cancelToken);

//     logNoStack
//         .i("ORGANIZATIONS_REPOSITORY: now Playing , responseData=${response.data}");
//     return OrganizationsResponse.fromJson(response.data);
//   }

//   Future<Organization> organization(
//       {required int orgId, CancelToken? cancelToken}) async {
//     logNoStack.i(
//         "ORGANIZATIONS_REPOSITORY: organization currentUserId=${currentUser.id} token=${token.substring(0, 10)}");
//     final url = Uri(
//       scheme: defaultAPIBaseUrl.substring(0,defaultAPIBaseUrl.indexOf(":")),
//       host: defaultAPIBaseUrl.substring(defaultAPIBaseUrl.indexOf(":")+3),
//       path: "$defaultApiPrefixPath/organizations/get/$orgId}",
//       // queryParameters: {
//       //   'api_key': token,
//       //   'include_adult': 'false',
//       // },
//     ).toString();

//     Options options = Options(headers: {
//       "accept": 'application/json',
//       "Authorization": 'Bearer $token'
//     });

//     final response =
//         await client.get(url, options: options, cancelToken: cancelToken);
//     return Organization.fromJson(response.data);
//   }
// }

// @riverpod
// OrganizationsRepository organizationsRepository(OrganizationsRepositoryRef ref) => OrganizationsRepository(
//       client: ref.watch(dioProvider),
//       token: ref.read(nestAuthProvider.notifier).token!,
//       currentUser: ref.read(nestAuthProvider.notifier).currentUser,
//     );

// class AbortedException implements Exception {}

// /// Provider to fetch a organization by ID
// @riverpod
// Future<Organization> organization(
//   OrganizationRef ref, {
//   required int organizationId,
// }) {
//   final cancelToken = ref.cancelToken();
//   return ref
//       .watch(organizationsRepositoryProvider)
//       .organization(orgId: organizationId, cancelToken: cancelToken);
// }

// /// Provider to fetch paginated organizations data
// @riverpod
// Future<OrganizationsResponse> fetchOrganizations(
//   FetchOrganizationsRef ref, {
//   required NestQueryData queryData,
// }) async {
//   final organizationsRepo = ref.watch(organizationsRepositoryProvider);
//   // See this for how the timeout is implemented:
//   // https://codewithandrea.com/articles/flutter-riverpod-data-caching-providers-lifecycle/#caching-with-timeout
//   // Cancel the page request if the UI no longer needs it.
//   // This happens if the user scrolls very fast or if we type a different search
//   // term.
//   final cancelToken = CancelToken();
//   // When a page is no-longer used, keep it in the cache.
//   final link = ref.keepAlive();
//   // a timer to be used by the callbacks below
//   Timer? timer;
//   // When the provider is destroyed, cancel the http request and the timer
//   ref.onDispose(() {
//     cancelToken.cancel();
//     timer?.cancel();
//   });
//   // When the last listener is removed, start a timer to dispose the cached data
//   ref.onCancel(() {
//     // start a 30 second timer
//     timer = Timer(const Duration(seconds: 30), () {
//       // dispose on timeout
//       link.close();
//     });
//   });
//   // If the provider is listened again after it was paused, cancel the timer
//   ref.onResume(() {
//     timer?.cancel();
//   });
//   if (queryData.query.isEmpty) {
//     // use non-search endpoint
//     return organizationsRepo.nowPlayingOrganizations(
//       page: queryData.page,
//       cancelToken: cancelToken,
//     );
//   } else {
//     // use search endpoint
//     return organizationsRepo.searchOrganizations(
//       queryData: queryData,
//       cancelToken: cancelToken,
//     );
//   }
// }

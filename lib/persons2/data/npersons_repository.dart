import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:notifi/credentials.dart';
import 'package:notifi/models/nestfilter.dart';

import 'package:notifi/organizations/src/utils/cancel_token_ref.dart';
import 'package:notifi/organizations/src/utils/dio_provider.dart';
import 'package:notifi/persons/src/features/persons/domain/nperson.dart';
import 'package:notifi/persons/src/features/persons/domain/nperson_response.dart';
import 'package:notifi/state/nest_auth2.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:logger/logger.dart' as logger;

part 'npersons_repository.g.dart';

var log = logger.Logger(
  printer: logger.PrettyPrinter(),
  level: logger.Level.info,
);

var logNoStack = logger.Logger(
  printer: logger.PrettyPrinter(methodCount: 0),
  level: logger.Level.info,
);

/// Metadata used when fetching movies with the paginated search API.
typedef Persons2QueryData = ({String query, int page});

class NPersonsRepository {
  const NPersonsRepository({required this.client, required this.token});
  final Dio client;
  final String token;

  Future<NPersonsResponse> searchMovies(
      {required Persons2QueryData queryData, CancelToken? cancelToken}) async {
    NestFilter nf = NestFilter(offset: queryData.page);
    var data = jsonEncode(nf);
    logNoStack.i("PERSONS2_REPOSITORY: search token=${token.substring(0, 10)}");

    String host = defaultAPIBaseUrl.substring("https://".length);
    String path = "$defaultApiPrefixPath/resources/targets/0";

    final uri = Uri(
      scheme: 'https',
      host: host,
      path: path,
      queryParameters: {
        // 'api_key': apiKey,
        // 'include_adult': 'false',
        // 'page': '${queryData.page}',
        // 'query': queryData.query,
      },
    );
    Options options = Options(headers: {
      "accept": 'application/json',
      "Authorization": 'Bearer $token'
    });

    final response = await client.getUri(uri,
        options: options, data: data, cancelToken: cancelToken);
    return NPersonsResponse.fromJson(response.data);
  }

  Future<NPersonsResponse> nowPlayingMovies(
      {required int page, CancelToken? cancelToken}) async {
            NestFilter nf = NestFilter(offset: page);
    var data = jsonEncode(nf);
    logNoStack.i("PERSONS2_REPOSITORY: now playiong token=${token.substring(0, 10)}");

    String host = defaultAPIBaseUrl.substring("https://".length);
    String path = "$defaultApiPrefixPath/resources/targets/0";

    final uri = Uri(
      scheme: 'https',
     host: host,
      path: path,
       queryParameters: {
        // 'api_key': apiKey,
        // 'include_adult': 'false',
        // 'language':'en-US',
        // 'page': '$page',
      },
    );
    Options options = Options(headers: {
      "accept": 'application/json',
      "Authorization": 'Bearer $token'
    });
    //https://api.themoviedb.org/3/movie/now_playing?language=en-US&page=1
    final response =
        await client.getUri(uri, options: options, data: data,cancelToken: cancelToken);
    return NPersonsResponse.fromJson(response.data);
  }

  Future<NPerson> nperson(
      {required int movieId, CancelToken? cancelToken}) async {

 String host = defaultAPIBaseUrl.substring("https://".length);
    String path = "$defaultApiPrefixPath/persons/$movieId";

    final url = Uri(
      scheme: 'https',
      host: host,
      path: path,
      queryParameters: {
        // 'api_key': apiKey,
        // 'include_adult': 'false',
      },
    ).toString();
    Options options = Options(headers: {
      "accept": 'application/json',
       "Authorization": 'Bearer $token'    });
    final response =
        await client.get(url, options: options, cancelToken: cancelToken);
    return NPerson.fromJson(response.data);
  }
}

@riverpod
NPersonsRepository npersonsRepository(NpersonsRepositoryRef ref) => NPersonsRepository(
      client: ref.watch(dioProvider),
      token: ref.read(nestAuthProvider.notifier).token!,
    );

class AbortedException implements Exception {}

/// Provider to fetch a movie by ID
@riverpod
Future<NPerson> person(
  PersonRef ref, {
  required int movieId,
}) {
  final cancelToken = ref.cancelToken();
  return ref
      .watch(npersonsRepositoryProvider)
      .nperson(movieId: movieId, cancelToken: cancelToken);
}

/// Provider to fetch paginated movies data
@riverpod
Future<NPersonsResponse> fetchNPersons(
  FetchNPersonsRef ref, {
  required Persons2QueryData queryData,
}) async {
  final persons2Repo = ref.watch(npersonsRepositoryProvider);
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
    return persons2Repo.nowPlayingMovies(
      page: queryData.page,
      cancelToken: cancelToken,
    );
  } else {
    // use search endpoint
    return persons2Repo.searchMovies(
      queryData: queryData,
      cancelToken: cancelToken,
    );
  }
}

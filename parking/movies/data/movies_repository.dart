import 'dart:async';

import 'package:dio/dio.dart';
import 'package:notifi/credentials.dart';
import '../domain/tmdb_movie.dart';
import '../domain/tmdb_movies_response.dart';
import 'package:notifi/organizations/src/utils/cancel_token_ref.dart';
import 'package:notifi/organizations/src/utils/dio_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:logger/logger.dart' as logger;


part 'movies_repository.g.dart';


var log = logger.Logger(
  printer: logger.PrettyPrinter(),
  level: logger.Level.info,
);

var logNoStack = logger.Logger(
  printer: logger.PrettyPrinter(methodCount: 0),
  level: logger.Level.info,
);


/// Metadata used when fetching movies with the paginated search API.
typedef MoviesQueryData = ({String query, int page});

class MoviesRepository {
  const MoviesRepository({required this.client, required this.apiKey});
  final Dio client;
  final String apiKey;

  Future<TMDBMoviesResponse> searchMovies(
      {required MoviesQueryData queryData, CancelToken? cancelToken}) async {
        logNoStack.i("QueryData = $queryData");
    final uri = Uri(
      scheme: 'https',
      host: 'api.themoviedb.org',
      path: '3/search/movie',
      queryParameters: {
        'api_key': apiKey,
        'include_adult': 'false',
        'page': '${queryData.page}',
        'query': queryData.query,
      },
    );
    Options options = Options(
       headers: {
    "accept": 'application/json',
    "Authorization": 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIyNTdiOTc0YzVjOTAyZTk5Yzg1NzE1OTU2YzhhMDc5MCIsIm5iZiI6MTY4MTM1OTQ0My40MzIsInN1YiI6IjY0Mzc4MjUzMzdiM2E5MDExMjAyMmVjYyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.mCOnpAvRuOUlTD6GGF7sIafKCfnrhHHVNTe4suz-ifU'
  });

    final response = await client.getUri(uri,options: options,cancelToken: cancelToken);
    return TMDBMoviesResponse.fromJson(response.data);
  }

  Future<TMDBMoviesResponse> nowPlayingMovies(
      {required int page, CancelToken? cancelToken}) async {
      
logNoStack.i("page= $page");
        
    final uri = Uri(
      scheme: 'https',
      host: 'api.themoviedb.org',
      path: '3/movie/now_playing',
      queryParameters: {
        'api_key': apiKey,
        'include_adult': 'false',
        'language':'en-US',
        'page': '$page',
      },
    );
        Options options = Options(
       headers: {
    "accept": 'application/json',
    "Authorization": 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIyNTdiOTc0YzVjOTAyZTk5Yzg1NzE1OTU2YzhhMDc5MCIsIm5iZiI6MTY4MTM1OTQ0My40MzIsInN1YiI6IjY0Mzc4MjUzMzdiM2E5MDExMjAyMmVjYyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.mCOnpAvRuOUlTD6GGF7sIafKCfnrhHHVNTe4suz-ifU'
  });
  //https://api.themoviedb.org/3/movie/now_playing?language=en-US&page=1
    final response = await client.getUri(uri, options: options, cancelToken: cancelToken);
    return TMDBMoviesResponse.fromJson(response.data);
  }

  Future<TMDBMovie> movie(
      {required int movieId, CancelToken? cancelToken}) async {
    final url = Uri(
      scheme: 'https',
      host: 'api.themoviedb.org',
      path: '3/movie/$movieId',
      queryParameters: {
        'api_key': apiKey,
        'include_adult': 'false',
      },
    ).toString();
       Options options = Options(
       headers: {
    "accept": 'application/json',
    "Authorization": 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIyNTdiOTc0YzVjOTAyZTk5Yzg1NzE1OTU2YzhhMDc5MCIsIm5iZiI6MTY4MTM1OTQ0My40MzIsInN1YiI6IjY0Mzc4MjUzMzdiM2E5MDExMjAyMmVjYyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.mCOnpAvRuOUlTD6GGF7sIafKCfnrhHHVNTe4suz-ifU'
  });
    final response = await client.get(url, options: options,cancelToken: cancelToken);
    return TMDBMovie.fromJson(response.data);
  }
}

@riverpod
MoviesRepository moviesRepository(MoviesRepositoryRef ref) => MoviesRepository(
      client: ref.watch(dioProvider),
      apiKey: TMDB_KEY,
    );

class AbortedException implements Exception {}

/// Provider to fetch a movie by ID
@riverpod
Future<TMDBMovie> movie(
  MovieRef ref, {
  required int movieId,
}) {
  final cancelToken = ref.cancelToken();
  return ref
      .watch(moviesRepositoryProvider)
      .movie(movieId: movieId, cancelToken: cancelToken);
}

/// Provider to fetch paginated movies data
@riverpod
Future<TMDBMoviesResponse> fetchMovies(
  FetchMoviesRef ref, {
  required MoviesQueryData queryData,
}) async {
  final moviesRepo = ref.watch(moviesRepositoryProvider);
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
    return moviesRepo.nowPlayingMovies(
      page: queryData.page,
      cancelToken: cancelToken,
    );
  } else {
    // use search endpoint
    return moviesRepo.searchMovies(
      queryData: queryData,
      cancelToken: cancelToken,
    );
  }
}

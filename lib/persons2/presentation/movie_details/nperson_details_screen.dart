import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notifi/movies/data/movies_repository.dart';
import 'package:notifi/movies/domain/tmdb_movie.dart';
import 'package:notifi/movies/presentation/movies/movie_list_tile.dart';
import 'package:notifi/movies/presentation/movies/movie_list_tile_shimmer.dart';
import 'package:notifi/persons/src/features/persons/domain/nperson.dart';
import 'package:notifi/persons2/data/npersons_repository.dart';
import 'package:notifi/persons2/presentation/movies/nperson_list_tile.dart';
import 'package:notifi/persons2/presentation/movies/nperson_list_tile_shimmer.dart';

class NPersonDetailsScreen extends ConsumerWidget {
  const NPersonDetailsScreen(
      {super.key, required this.movieId, required this.movie});
  final int movieId;
  final NPerson? movie;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (movie != null) {
      return Scaffold(
        appBar: AppBar(
          title: Text(movie!.name!),
        ),
        body: Column(
          children: [
            NPersonListTile(nperson: movie!),
          ],
        ),
      );
    } else {
      final movieAsync = ref.watch(personProvider(movieId: movieId));
      return movieAsync.when(
        error: (e, st) => Scaffold(
          appBar: AppBar(
            title: Text(movie?.name ?? 'Error'),
          ),
          body: Center(child: Text(e.toString())),
        ),
        loading: () => Scaffold(
          appBar: AppBar(
            title: Text(movie?.name ?? 'Loading'),
          ),
          body: const Column(
            children: [
              NPersonListTileShimmer(),
            ],
          ),
        ),
        data: (movie) => Scaffold(
          appBar: AppBar(
            title: Text(movie.name!),
          ),
          body: Column(
            children: [
              NPersonListTile(nperson: movie),
            ],
          ),
        ),
      );
    }
  }
}

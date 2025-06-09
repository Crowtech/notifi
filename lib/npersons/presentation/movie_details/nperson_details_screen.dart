import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notifi/npersons/data/npersons_repository.dart';
import 'package:notifi/npersons/presentation/movies/nperson_list_tile.dart';
import 'package:notifi/npersons/presentation/movies/nperson_list_tile_shimmer.dart';
import 'package:notifi/persons/src/features/persons/domain/nperson.dart';

class NPersonDetailsScreen extends ConsumerWidget {
  const NPersonDetailsScreen(
      {super.key, required this.movieId, required this.person});
  final int movieId;
  final NPerson? person;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (person != null) {
      return Scaffold(
        appBar: AppBar(
          title: Text(person!.name!),
        ),
        body: Column(
          children: [
            NPersonListTile(nperson: person!),
          ],
        ),
      );
    } else {
      final movieAsync = ref.watch(personProvider(movieId: movieId));
      return movieAsync.when(
        error: (e, st) => Scaffold(
          appBar: AppBar(
            title: Text(person?.name ?? 'Error'),
          ),
          body: Center(child: Text(e.toString())),
        ),
        loading: () => Scaffold(
          appBar: AppBar(
            title: Text(person?.name ?? 'Loading'),
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

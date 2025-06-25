import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notifi/models/person.dart';
import 'package:notifi/npersons/data/npersons_repository.dart';
import 'package:notifi/npersons/presentation/npersons/nperson_list_tile.dart';
import 'package:notifi/npersons/presentation/npersons/nperson_list_tile_shimmer.dart';

import 'package:notifi/i18n/strings.g.dart' as nt;

class NPersonDetailsScreen extends ConsumerWidget {
  const NPersonDetailsScreen(
      {super.key, required this.personId, required this.person});
  final int personId;
  final Person? person;

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
      final personAsync = ref.watch(personProvider(personId: personId));
      return personAsync.when(
        error: (e, st) => Scaffold(
          appBar: AppBar(
            title: Text(person?.name ?? 'Error'),
          ),
          body: Center(child: Text(e.toString())),
        ),
        loading: () => Scaffold(
          appBar: AppBar(
            title: Text(person?.name ?? nt.t.loading),
          ),
          body: const Column(
            children: [
              NPersonListTileShimmer(),
            ],
          ),
        ),
        data: (person) => Scaffold(
          appBar: AppBar(
            title: Text(person.name!),
          ),
          body: Column(
            children: [
              NPersonListTile(nperson: person),
            ],
          ),
        ),
      );
    }
  }
}

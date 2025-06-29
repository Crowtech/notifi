import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notifi/models/person.dart';

import '../../data/persons_repository.dart';
import '../persons/person_list_tile.dart';
import '../persons/person_list_tile_shimmer.dart';
import 'package:notifi/i18n/strings.g.dart' as nt;


class PersonDetailsScreen extends ConsumerWidget {
  const PersonDetailsScreen(
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
            PersonListTile(person: person!),
          ],
        ),
      );
    } else {
      final personAsync = ref.watch(personProvider(personId: personId));
      return personAsync.when(
        error: (e, st) => Scaffold(
          appBar: AppBar(
            title: Text(person?.name ?? nt.t.error),
          ),
          body: Center(child: Text(e.toString())),
        ),
        loading: () => Scaffold(
          appBar: AppBar(
            title: Text(person?.name ?? nt.t.loading),
          ),
          body: const Column(
            children: [
              PersonListTileShimmer(),
            ],
          ),
        ),
        data: (person) => Scaffold(
          appBar: AppBar(
            title: Text(person.name!),
          ),
          body: Column(
            children: [
              PersonListTile(person: person),
            ],
          ),
        ),
      );
    }
  }
}

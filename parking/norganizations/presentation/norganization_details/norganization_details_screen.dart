import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/norganizations_repository.dart';
import '../../domain/norganization.dart';
import '../norganizations/norganization_list_tile.dart';
import '../norganizations/norganization_list_tile_shimmer.dart';

import 'package:notifi/i18n/strings.g.dart' as nt;

class NOrganizationDetailsScreen extends ConsumerWidget {
  const NOrganizationDetailsScreen(
      {super.key, required this.organizationId, required this.person});
  final int organizationId;
  final NOrganization? person;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (person != null) {
      return Scaffold(
        appBar: AppBar(
          title: Text(person!.name!),
        ),
        body: Column(
          children: [
            NOrganizationListTile(norganization: person!),
          ],
        ),
      );
    } else {
      final organizationAsync = ref.watch(organizationProvider(organizationId: organizationId));
      return organizationAsync.when(
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
              NOrganizationListTileShimmer(),
            ],
          ),
        ),
        data: (person) => Scaffold(
          appBar: AppBar(
            title: Text(person.name!),
          ),
          body: Column(
            children: [
              NOrganizationListTile(norganization: person),
            ],
          ),
        ),
      );
    }
  }
}

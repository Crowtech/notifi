import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notifi/models/organization.dart';

import '../../data/organizations_repository.dart';

import '../organizations/organization_list_tile.dart';
import '../organizations/organization_list_tile_shimmer.dart';


class OrganizationDetailsScreen extends ConsumerWidget {
  const OrganizationDetailsScreen(
      {super.key, required this.organizationId, required this.organization});
  final int organizationId;
  final Organization? organization;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (organization != null) {
      return Scaffold(
        appBar: AppBar(
          title: Text(organization!.name!),
        ),
        body: Column(
          children: [
            OrganizationListTile(organization: organization!),
          ],
        ),
      );
    } else {
      final organizationAsync = ref.watch(organizationProvider(organizationId: organizationId));
      return organizationAsync.when(
        error: (e, st) => Scaffold(
          appBar: AppBar(
            title: Text(organization?.name ?? 'Error'),
          ),
          body: Center(child: Text(e.toString())),
        ),
        loading: () => Scaffold(
          appBar: AppBar(
            title: Text(organization?.name ?? 'Loading'),
          ),
          body: const Column(
            children: [
              OrganizationListTileShimmer(),
            ],
          ),
        ),
        data: (organization) => Scaffold(
          appBar: AppBar(
            title: Text(organization.name!),
          ),
          body: Column(
            children: [
              OrganizationListTile(organization: organization),
            ],
          ),
        ),
      );
    }
  }
}

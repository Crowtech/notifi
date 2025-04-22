import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notifi/models/organization.dart';
import 'package:notifi/organizations/src/features/organizations/data/organizations_repository_nf.dart';
import 'package:notifi/widgets/avatar_edit.dart';


import '../organizations/organization_list_tile_shimmer.dart';
import 'package:notifi/i18n/strings.g.dart' as nt;
import 'package:logger/logger.dart' as logger;

var log = logger.Logger(
  printer: logger.PrettyPrinter(),
  level: logger.Level.info,
);

var logNoStack = logger.Logger(
  printer: logger.PrettyPrinter(methodCount: 0),
  level: logger.Level.info,
);

class OrganizationDetailsScreen extends ConsumerWidget {
  const OrganizationDetailsScreen(
      {super.key, required this.organizationId, required this.organization});
  final int organizationId;
  final Organization? organization;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (organization != null) {
      logNoStack.i("ORG_DETAILS_SCREEN: organization is $organization");
      return Scaffold(
        appBar: AppBar(
          title: Text(organization!.name!),
        ),
        body: 
        SingleChildScrollView(
        child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
          children: [
             EditableAvatar(imageUrl: organization!.getAvatarUrl(), diameter: 100,resource: organization!),
               if (organization!.created != null) ...[
                  const SizedBox(height: 8),
                  Text(
                    '${nt.t.form.url}: ${organization!.url}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
                 if (organization!.created != null) ...[
                  const SizedBox(height: 8),
                  Text(
                    '${nt.t.form.email}: ${organization!.email}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
                if (organization!.created != null) ...[
                  const SizedBox(height: 8),
                  Text(
                    '${nt.t.created}: ${organization!.created}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
          ],
        ),
        ),
      );
    } else {
      final organizationAsync = ref.watch(organization2Provider(organizationId: organizationId));
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
               EditableAvatar(imageUrl: organization.getAvatarUrl(), diameter: 100,resource: organization),
               if (organization.created != null) ...[
                  const SizedBox(height: 8),
                  Text(
                    '${nt.t.form.url}: ${organization.url}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
                 if (organization.created != null) ...[
                  const SizedBox(height: 8),
                  Text(
                    '${nt.t.form.email}: ${organization.email}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
                if (organization.created != null) ...[
                  const SizedBox(height: 8),
                  Text(
                    '${nt.t.created}: ${organization.created}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
             // OrganizationListTile(organization: organization),
            ],
          ),
        ),
      );
    }
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notifi/models/organization.dart';
import 'package:notifi/organizations/src/features/organizations/data/organizations_repository_nf.dart';

class OrganizationListWidget extends ConsumerWidget {
  OrganizationListWidget({
    super.key,
    required this.formKey,
    required this.formCode,
    required this.fieldValues,
    required this.fieldCode,
  });

  GlobalKey<FormState> formKey;
  List<Organization> orgs = [];

  final Map<String, dynamic> fieldValues;
  final String formCode;
  final String fieldCode;

  int? value;
  Set<int> orgIds = {};

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final responseAsync = ref.watch(
      //fetchOrganizationsNestFilterProvider(nestFilter: nestFilter),
      fetchOrganizationsNestFilterProvider,
    );
    final totalResults = responseAsync.valueOrNull?.totalResults;

    if (responseAsync.hasValue) {
      // check if there are new organizations, keep the value
      orgs = responseAsync.value!.results;
      for (Organization org in orgs) {
          org.selected = false;
      }
    }
    return Container(
      alignment: Alignment.centerLeft,
      constraints: const BoxConstraints(maxHeight: 201),
      width: 202,
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: totalResults, //_layers.length,
        itemBuilder: (context, index) {
          return CheckboxListTile(
            key: ValueKey(orgs[index].id),
            dense: true,
            title: Text(orgs[index].name!),
            value: orgs[index].selected,
            onChanged: (ind) {
              if (orgIds.contains(orgs[index].id!)) {
                orgIds.remove(orgs[index].id!);
              } else {
                orgIds.add(orgs[index].id!);
              }
              orgs[index].selected = !orgs[index].selected;
              fieldValues['orgIds'] = orgIds.toList();
              logNoStack.i("OrgList selections = $orgIds");
            },
          );
        },
      ),
    );
  }
}

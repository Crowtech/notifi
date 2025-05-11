import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notifi/models/organization.dart';
import 'package:notifi/organizations/src/features/organizations/data/organizations_repository_nf.dart';

class OrganizationListWidget extends ConsumerStatefulWidget {
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
  int? totalResults = 0;

  int? value;
  Set<int> orgIds = {};
  Map<int, bool> orgIdSelected = {};

  @override
  ConsumerState<OrganizationListWidget> createState() =>
      _OrganizationListWidgetState();
}

class _OrganizationListWidgetState
    extends ConsumerState<OrganizationListWidget> {
  @override
  void initState() {
    super.initState();
    final responseAsync = ref.read(
      //fetchOrganizationsNestFilterProvider(nestFilter: nestFilter),
      fetchOrganizationsNestFilterProvider,
    );
    widget.totalResults = responseAsync.valueOrNull?.totalResults;

    if (responseAsync.hasValue) {
      // check if there are new organizations, keep the value
      widget.orgs = responseAsync.value!.results;
      for (Organization org in widget.orgs) {
        org.selected = false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    logNoStack.i("orgList: build");

    return Container(
      alignment: Alignment.centerLeft,
      constraints: const BoxConstraints(maxHeight: 201),
      width: 202,
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: widget.totalResults!, //_layers.length,
        itemBuilder: (context, index) {
          return CheckboxListTile(
            key: ValueKey(widget.orgs[index].id),
            dense: true,
            title: Text(widget.orgs[index].name!),
           selected: widget.orgs[index].selected,
            value: widget.orgs[index].selected,
            onChanged: (value) {
              
              if (widget.orgIds.contains(widget.orgs[index].id!)) {
                widget.orgIds.remove(widget.orgs[index].id!);
                widget.orgs[index].selected = false;
              } else {
                widget.orgIds.add(widget.orgs[index].id!);
                widget.orgs[index].selected = true;
              }

              widget.fieldValues['orgIds'] = widget.orgIds.toList();
              logNoStack.i("OrgList selections = ${widget.orgIds}");
              // setState(() {
              //   widget.orgs;

              // });
            },
          );
        },
      ),
    );
  }
}

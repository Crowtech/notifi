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
  int? totalItems = 0;

  int? value;

  Map<int, bool> orgIdSelected = {};

  @override
  ConsumerState<OrganizationListWidget> createState() =>
      _OrganizationListWidgetState();
}

class _OrganizationListWidgetState
    extends ConsumerState<OrganizationListWidget> {
  Map<int, bool> _selections = {};
  Map<String, dynamic> fieldValues = {};
  int totalItems = 0;
  List<Organization> _orgs = [];
    final Set<int> _orgIds = {};

  @override
  void initState() {
    Map<int, bool> selections = {};
    List<Organization> orgs = [];
    super.initState();
    fieldValues = widget.fieldValues;
    final responseAsync = ref.read(
      //fetchOrganizationsNestFilterProvider(nestFilter: nestFilter),
      fetchOrganizationsNestFilterProvider,
    );

    if (responseAsync.hasValue) {
      // check if there are new organizations, keep the value
      orgs = responseAsync.value!.items!;
      int index = 0;
      for (Organization org in orgs) {
        org.selected = false;
        selections[index] = false;
        index++;
      }
    }
    setState(() {
      totalItems = responseAsync.valueOrNull?.totalItems ?? 0;
      _orgs = orgs;
      _selections = selections;
    });
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
        itemCount: totalItems, //_layers.length,
        itemBuilder: (context, index) {
          return CheckboxListTile(
            key: ValueKey(index),
            dense: true,
            title: Text(_orgs[index].name!),
            selected:
                _selections[index] ?? false, //widget.orgs[index].selected,
            value: _selections[index],
            onChanged: (value) {
             
              setState(() {
                _selections[index] = value!;
                
                if (_orgIds.contains(_orgs[index].id!)) {
                  _orgIds.remove(_orgs[index].id!);
                  _orgs[index].selected = false;
                } else {
                  _orgIds.add(_orgs[index].id!);
                  _orgs[index].selected = true;
                }
                 fieldValues['orgIds'] = _orgIds.toList();
              });
          
              logNoStack.i("ORG_LIST: value=$value , orgs:$_orgIds");
            },
          );
        },
      ),
    );
  }
}

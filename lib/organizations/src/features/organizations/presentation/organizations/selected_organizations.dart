import 'package:notifi/models/nest_filter_type.dart';
import 'package:notifi/models/nestfilter.dart';
import 'package:notifi/models/organization.dart';
import 'package:notifi/models/person.dart';
import 'package:notifi/state/nest_auth2.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:logger/logger.dart' as logger;
import 'package:latlong2/latlong.dart';

part 'selected_organizations.g.dart';

var log = logger.Logger(
  printer: logger.PrettyPrinter(),
  level: logger.Level.info,
);

var logNoStack = logger.Logger(
  printer: logger.PrettyPrinter(methodCount: 0),
  level: logger.Level.info,
);

@Riverpod(keepAlive: true)
class SelectedOrganizations extends _$SelectedOrganizations {
  @override
  List<Organization> build() {
    logNoStack.i("SELECTED ORGS BUILD");
    return [];
  }

  void addOrg(Organization organization) {
    logNoStack.i("SELECTED_ORGS: add ${organization.url}");
    state = [...state, organization];
  }

  void removeOrg(Organization organization) {
    logNoStack.i("SELECTED_ORGS: remove ${organization.url}");
    state = [...state]..remove(organization);
  }

  void update(Organization organization, bool add) {
    if (add == true) {
      addOrg(organization);
    } else {
      removeOrg(organization);
    }

  }

  List<int> getIdList() {
    List<int> orgIntList = [];
    if (state.isEmpty) {
    //  Person currentUser = ref.read(nestAuthProvider.notifier).currentUser;
     // orgIntList.add(currentUser.orgid!); // set default
    } else {
      for (Organization org in state) {
        orgIntList.add(org.id!);
      }
    }
    return orgIntList;
  }
}


@Riverpod(keepAlive: true)
class SelectedOrganizationIds extends _$SelectedOrganizationIds {
  @override
  List<int> build() {
    logNoStack.i("SELECTED ORG IDS BUILD");
    return getIdList();
  }

 
  List<int> getIdList() {
    List<int> orgIntList = [];

    List<Organization> orgs = ref.watch(selectedOrganizationsProvider);
      for (Organization org in orgs) {
        orgIntList.add(org.id!);
      }
  
    return orgIntList;
  }
}

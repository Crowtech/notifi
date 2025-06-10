import 'package:notifi/models/organization.dart';
import 'package:notifi/models/selected_resources.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:logger/logger.dart' as logger;

part 'selected_norganizations.g.dart';

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

  void addOrg(Map<int, bool> orgMap,Organization organization) {
    logNoStack.i("SELECTED_ORGS: add ${organization.url}");

    state = [...state, organization];
  }

  void removeOrg(Map<int, bool> orgMap,Organization organization) {
    logNoStack.i("SELECTED_ORGS: remove ${organization.url}");
    state = [...state]..remove(organization);
  }

  void update(Map<int, bool> orgMap,Organization organization, bool add) {
    if (add == true) {
      addOrg(orgMap,organization);
    } else {
      removeOrg(orgMap,organization);
    }
    // save to api
    ref.read(asyncSelectedResourcesProvider.notifier).setSelectedResourceIds(getSelectedResources(orgMap));
  }

  List<int> getIdList() {
    List<int> orgIntList = [];
    if (state.isEmpty) {
    //  Organization currentUser = ref.read(nestAuthProvider.notifier).currentUser;
     // orgIntList.add(currentUser.orgid!); // set default
    } else {
      for (Organization org in state) {
        orgIntList.add(org.id!);
      }
    }
    return orgIntList;
  } 

    SelectedResources getSelectedResources(Map<int, bool> orgMap) {
    List<int> selectedResourceIds = [];
    List<int> unselectedResourceIds = [];

      for (MapEntry<int, bool> org in orgMap.entries) {
        if (org.value == true) {
          selectedResourceIds.add(org.key);
        } else {
          unselectedResourceIds.add(org.key);
        }
      }
   SelectedResources selectedResources = SelectedResources(selectedResourceIds: selectedResourceIds, unselectedResourceIds: unselectedResourceIds);
    return selectedResources;
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

      // save selectedOrgs to api
     // dsfsdf
  
//  /resources/selected/  SelectedResources

    return orgIntList;
  }
}

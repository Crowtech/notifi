// The StateNotifier class that will be passed to our StateNotifierProvider.
// This class should not expose state outside of its "state" property, which means
// no public getters/properties!
// The public methods on this class will be what allow the UI to modify the state.
import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notifi/api_utils.dart';
import 'package:notifi/models/crowtech_basepage.dart';
import 'package:notifi/models/nestfilter.dart';
import 'package:notifi/models/organization.dart';
import 'package:notifi/models/person.dart';
import 'package:logger/logger.dart' as logger;
import 'package:notifi/state/nest_auth2.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../credentials.dart';

part 'OrgNotifier.g.dart';

var log = logger.Logger(
  printer: logger.PrettyPrinter(),
  level: logger.Level.info,
);

var logNoStack = logger.Logger(
  printer: logger.PrettyPrinter(methodCount: 0),
  level: logger.Level.info,
);

@riverpod
class OrgNotifier extends _$OrgNotifier {
  Future<List<Organization>> _fetchOrganizations() async {
    return fetchOrgs();
  }

  @override
  FutureOr<List<Organization>> build() async {
    return _fetchOrganizations();
  }

  // Let's mark a organization as selected
  void toggle(int organizationId) async {
    AsyncValue<List<Organization>> organizations = await state;

//state = organizations;

    state = [
      for (final organization in organizations.value!)
        // we're marking only the matching organization as selected
        if (organization.id == organizationId)
          // Once more, since our state is immutable, we need to make a copy
          // of the organization. We're using our `copyWith` method implemented before
          // to help with that.
          organization.copyWith(selected: !organization.selected!)
        else
          // other organizations are not modified
          organization,
    ] as AsyncValue<List<Organization>>;
  }

  Future<List<Organization>> fetchOrgs() async {
    NestFilter nestFilter = NestFilter();

    nestFilter.offset = 0;
    String jsonDataStr = jsonEncode(nestFilter);
    Person currentUser = ref.read(nestAuthProvider.notifier).currentUser;
    String token = ref.read(nestAuthProvider.notifier).token!;
    logNoStack.i(
        "Sending NestFilter org for ${currentUser.id} $nestFilter with json as $jsonDataStr");

    var response = await apiPostDataStrNoLocale(
        token,
        "$defaultAPIBaseUrl$defaultApiPrefixPath/resources/sources/${currentUser.id}",
        jsonDataStr);
    // .then((response) {
    logNoStack.i("result ${response.body.toString()}");
    final map = jsonDecode(response.body);

    CrowtechBasePage<Organization> page =
        CrowtechBasePage<Organization>(itemFromJson: Organization.fromJson)
            .fromJson(map);
    String usersStr = "--- Organizations ----\n";
    for (int i = 0; i < page.itemCount(); i++) {
      usersStr += "Org$i  ${page.items![i]}\n";
    }
    logNoStack.i(usersStr);
    if (page.items == null) {
      return [];
    } else {
      return page.items!;
    }
  }

  Future<void> addOrganization(Organization organization) async {
    String token = ref.read(nestAuthProvider.notifier).token!;
    String jsonDataStr = jsonEncode(organization);
    await apiPostDataStrNoLocale(token,
        "$defaultAPIBaseUrl$defaultApiPrefixPath/resources", jsonDataStr);

    // Once the post request is done, we can mark the local cache as dirty.
    // This will cause "build" on our notifier to asynchronously be called again,
    // and will notify listeners when doing so.
    ref.invalidateSelf();

    // (Optional) We can then wait for the new state to be computed.
    // This ensures "addTodo" does not complete until the new state is available.
    await future;
  }
}

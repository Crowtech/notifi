
import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:notifi/api_utils.dart';
import 'package:notifi/models/crowtech_basepage.dart';
import 'package:notifi/models/gps.dart';
import 'package:notifi/models/nestfilter.dart';
import 'package:notifi/models/organization.dart';
import 'package:notifi/models/person.dart';
import 'package:notifi/state/nest_auth2.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:logger/logger.dart' as logger;
import 'package:notifi/credentials.dart';

part 'orgs.g.dart';
part 'orgs.freezed.dart';

var log = logger.Logger(
  printer: logger.PrettyPrinter(),
  level: logger.Level.info,
);

var logNoStack = logger.Logger(
  printer: logger.PrettyPrinter(methodCount: 0),
  level: logger.Level.info,
);


@freezed
sealed class Org with _$Org {
  factory Org({
    required int orgid,
    required int id,
    required String code,
    required DateTime created,
    required DateTime updated,
    required String name,
    required String description,
    required String location,
    required String devicecode,
    required String avatarUrl,
    required GPS gps,
    required bool selected,
    required String orgType,
    required String url,
  }) = _Org;

  factory Org.fromJson(Map<String, dynamic> json) => _$OrgFromJson(json);
}

// This will generates a AsyncNotifier and AsyncNotifierProvider.
// The AsyncNotifier class that will be passed to our AsyncNotifierProvider.
// This class should not expose state outside of its "state" property, which means
// no public getters/properties!
// The public methods on this class will be what allow the UI to modify the state.
// Finally, we are using asyncOrgsProvider(AsyncNotifierProvider) to allow the UI to
// interact with our Orgs class.
@riverpod
class AsyncOrgs extends _$AsyncOrgs {
  Future<List<Org>> _fetchOrg() async {
     NestFilter nestFilter = NestFilter();

    nestFilter.offset = 0;
    String jsonDataStr = jsonEncode(nestFilter);
    Person currentUser = ref.read(nestAuthProvider.notifier).currentUser;
    String token = ref.read(nestAuthProvider.notifier).token!;
    logNoStack.i(
        "ORGS: Sending NestFilter org for ${currentUser.id} $nestFilter with json as $jsonDataStr");

    var response = await apiPostDataStrNoLocale(
        token,
        "$defaultAPIBaseUrl$defaultApiPrefixPath/resources/sources/${currentUser.id}",
        jsonDataStr);
    // .then((response) {
    logNoStack.i("ORGS: result ${response.body.toString()}");
    final map = jsonDecode(response.body);

    CrowtechBasePage<Organization> page =
        CrowtechBasePage<Organization>(itemFromJson: Organization.fromJson)
            .fromJson(map);
    String usersStr = "ORGS: --- Organizations ----\n";
    for (int i = 0; i < page.itemCount(); i++) {
      usersStr += "Org$i  ${page.items![i]}\n";
    }
    logNoStack.i(usersStr);
    if (page.items == null) {
      return [];
    } else {
     // return page.items;
          final todos = jsonDecode(map['items']) as List<Map<Org, dynamic>>;
    //return todos.map(Org.fromJson).toList();

    String itemsJson = map['items'];
     logNoStack.i("ORGS: itemsJson=$itemsJson");
    final todos2 = jsonDecode(itemsJson);// as List<Map<Org, dynamic>>;
    return todos2.map(Org.fromJson).toList();
    }
  }

  @override
  FutureOr<List<Org>> build() async {
    // Load initial todo list from the remote repository
    return _fetchOrg();
  }

  Future<void> addOrg(Org todo) async {
    // Set the state to loading
    state = const AsyncValue.loading();
    // Add the new todo and reload the todo list from the remote repository
    state = await AsyncValue.guard(() async {
    //  await http.post('api/todos', todo.toJson());
      return _fetchOrg();
    });
  }

  // Let's allow removing todos
  Future<void> removeOrg(String todoId) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
    //  await http.delete('api/todos/$todoId');
      return _fetchOrg();
    });
  }

  // Let's mark a todo as completed
  Future<void> toggle(int todoId) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      // await http.patch(
      //   'api/todos/$todoId',
      //   <String, dynamic>{'selected': true},
      // );
      return _fetchOrg();
    });
  }
}
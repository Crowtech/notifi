import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:logger/logger.dart' as logger;
import 'package:notifi/credentials.dart';
import 'package:notifi/models/nest_notifi.dart';
import 'package:notifi/models/nestfilter.dart';
import 'package:notifi/state/nest_auth2.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:app_badge_plus/app_badge_plus.dart';

import '../api_utils.dart';
import '../models/crowtech_basepage.dart';
import '../models/person.dart';

part 'nest_notifis_provider.g.dart';

var log = logger.Logger(
  printer: logger.PrettyPrinter(),
  level: logger.Level.info,
);

var logNoStack = logger.Logger(
  printer: logger.PrettyPrinter(methodCount: 0),
  level: logger.Level.info,
);

// This will generates a AsyncNotifier and AsyncNotifierProvider.
// The AsyncNotifier class that will be passed to our AsyncNotifierProvider.
// This class should not expose state outside of its "state" property, which means
// no public getters/properties!
// The public methods on this class will be what allow the UI to modify the state.
// Finally, we are using asyncOrgsProvider(AsyncNotifierProvider) to allow the UI to
// interact with our Orgs class.
@riverpod
class NestNotifis extends _$NestNotifis {
  List<NestNotifi> _notifications = [];

  void clear() async {
    if (await AppBadgePlus.isSupported()) {
      AppBadgePlus.updateBadge(0);
    }
    _notifications.clear();
  }

  Future<List<NestNotifi>> _fetch() async {
    NestFilter nestFilter = NestFilter();

    nestFilter.offset = 0;
    String jsonDataStr = jsonEncode(nestFilter);
    Person currentUser = ref.read(nestAuthProvider.notifier).currentUser;
    String token = ref.read(nestAuthProvider.notifier).token!;
    logNoStack.i(
        "NEST_NOTIFIS: Sending NestFilter org for ${currentUser.id} $nestFilter with json as $jsonDataStr");

    var response = await apiPostDataStrNoLocale(token,
        "$defaultAPIBaseUrl$defaultApiPrefixPath/nestnotifis", jsonDataStr);
    // .then((response) {
    logNoStack.i("NEST_NOTIFIS: result ${response.body.toString()}");
    final map = jsonDecode(response.body);

    CrowtechBasePage<NestNotifi> page =
        CrowtechBasePage<NestNotifi>(itemFromJson: NestNotifi.fromJson)
            .fromJson(map);
    String usersStr = "NEST_NOTIFIS: --- NestNotifis ----\n";
    for (int i = 0; i < page.itemCount(); i++) {
      usersStr += "NestNotifis$i  ${page.items![i]}\n";
    }
    logNoStack.i(usersStr);
    if (page.items == null) {
      return [];
    } else {
      final items = jsonDecode(map['items']) as List<Map<NestNotifi, dynamic>>;

      String itemsJson = map['items'];
      logNoStack.i("NEST_NOTIFI: itemsJson=${itemsJson}");
      final items2 = jsonDecode(itemsJson); // as List<Map<Org, dynamic>>;
      return items2.map(NestNotifi.fromJson).toList();
    }
  }

  @override
  FutureOr<List<NestNotifi>> build() async {
    // Load initial todo list from the remote repository
    _notifications = await _fetch();
    // updated app badge
    if (await AppBadgePlus.isSupported()) {
      AppBadgePlus.updateBadge(_notifications.length);
    }
    return _notifications;
  }

  //Future<void> add(NestNotifi item) async {
  void add(NestNotifi item) async {
    // Set the state to loading
    state = const AsyncValue.loading();
    // Add the new todo and reload the todo list from the remote repository
    state = await AsyncValue.guard(() async {
      //state = [...state, item];
      _notifications.add(item);
      // return _fetch();
      if (await AppBadgePlus.isSupported()) {
        AppBadgePlus.updateBadge(_notifications.length);
      }
      return _notifications;
    });
  }

  //Future<void> add(NestNotifi item) async {
  void addRemoteNotification(RemoteNotification item) async {
    // Set the state to loading
    state = const AsyncValue.loading();
    // Add the new todo and reload the todo list from the remote repository
    state = await AsyncValue.guard(() async {
      //state = [...state, item];
      NestNotifi nn = NestNotifi();
      nn.name = item.title ?? "";
      nn.description = item.body ?? "";

      _notifications.add(nn);
      if (await AppBadgePlus.isSupported()) {
        AppBadgePlus.updateBadge(_notifications.length);
      }
      // return _fetch();
      return _notifications;
    });
  }

  // Let's allow removing todos
  Future<void> remove(NestNotifi item) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      _notifications.remove(item);
      // return _fetch();

      return _notifications;
    });
  }

  // Let's mark a todo as completed
  Future<void> toggle(String code) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return _notifications;
    });
  }
}

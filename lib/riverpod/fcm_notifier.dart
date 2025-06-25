
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notifi/api_utils.dart';
import 'package:notifi/credentials.dart';
import 'package:notifi/jwt_utils.dart';
import 'package:notifi/models/organization.dart';
import 'package:notifi/models/person.dart';
import 'package:notifi/organizations/src/features/organizations/data/organizations_repository_nf.dart';
import 'package:notifi/state/nest_auth2.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:logger/logger.dart' as logger;

part 'fcm_notifier.g.dart';

var log = logger.Logger(
  printer: logger.PrettyPrinter(),
  level: logger.Level.info,
);

var logNoStack = logger.Logger(
  printer: logger.PrettyPrinter(methodCount: 0),
  level: logger.Level.info,
);

@Riverpod(keepAlive: true)
class FcmNotifier extends _$FcmNotifier {
  Set<String> _topics = {
    defaultRealm,
    'test',
  };

  @override
  String build() {
    init();

    return "NOT_READY";
  }

  Future<void> init() async {
    if (kIsWeb) {
      _topics = {};
    }

    if (defaultTargetPlatform == TargetPlatform.android) {
      _topics.add('android');
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      _topics.add('ios');
    } else if (defaultTargetPlatform == TargetPlatform.linux) {
      _topics.add('linux');
    } else if (defaultTargetPlatform == TargetPlatform.windows) {
      _topics.add('windows');
    } else if (defaultTargetPlatform == TargetPlatform.macOS) {
      _topics.add('macos');
    } else if (defaultTargetPlatform == TargetPlatform.fuchsia) {
      _topics.add('fuchsia');
    } else {
      // We use 'web' as the default platform for unknown platforms.
      _topics.add('web');
    }

    // Add the unique devicecode as a topic
    String deviceId = await fetchDeviceId();
    _topics.add(deviceId);
  }

  void setFcm(String fcm) {
    logNoStack.i("FCM_NOTIFIER: Setting fcm : $fcm}");

    //   ref.read(sendFcmProvider(fcm));
    state = fcm;
    //
  }

  Set<String> getTopics() {
    return _topics;
  }

  Set<String> addTopic(String topic) {
    _topics.add(topic);
    logNoStack.i("FCM_NOTIFIER, ADDING TOPIC $topic");
    return _topics;
  }

  Set<String> removeTopic(String topic) {
    _topics.remove(topic);
    return _topics;
  }

  void setTopics() {
    subscribeToTopics(_topics);
  }

  void sendFcm(String token, String fcm) async {
    logNoStack.i("SEND_FCM: Sending fcm to api : $fcm}");
    String devicecode = await fetchDeviceId();
    //Locale locale = (Locale)null;
    Map result = await registerFCM(token, devicecode, fcm);
    logNoStack.i("SEND_FCM: result = $result");

    final responseAsync = ref.watch(
      fetchOrganizationsNestFilterProvider,
    );

    if (responseAsync.hasValue) {
      for (Organization org in responseAsync.value!.items) {
        addTopic(org.code!);
      }
    }

    Person currentUser = ref.read(nestAuthProvider.notifier).currentUser;
    addTopic(currentUser.code!);
    addTopic(currentUser.username!);
    setTopics();
  }
}

Future<void> subscribeToTopics(Set<String> topics) async {
  if (enableNotifications) {
    if (!kIsWeb) {
      logNoStack.i("NOTIFI2: Subscribing to ${topics.length} topics");

      for (final topic in topics) {
        try {
          logNoStack.i("FCM_NOTIFIER: Subscribing to topic: $topic");
          FirebaseMessaging.instance.subscribeToTopic(topic).then((_) {});
        } on Exception catch (_) {
          log.e("FCM_NOTIFIER: Firebase error");
        }
      }
    } else {
      logNoStack.i("FCM_NOTIFIER: Not subscribing to topics");
    }
  }
}

@Riverpod(keepAlive: true)
void sendFcm(Ref ref) async {
  var fcm = ref.watch(fcmNotifierProvider);
  String? token = ref.read(nestAuthProvider.notifier).token;
  if (token == null) {
    return;
  }
  bool isLoggedIn = ref.read(nestAuthProvider.notifier).isLoggedIn;
  if (isLoggedIn) {
    logNoStack.i("SEND_FCM: Sending fcm to api : $fcm}");
    String devicecode = await fetchDeviceId();
    //Locale locale = (Locale)null;
    Map result = await registerFCM(token, devicecode, fcm);
    logNoStack.i("SEND_FCM: result = $result");
  }
}

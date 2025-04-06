import 'dart:ui';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notifi/api_utils.dart';
import 'package:notifi/credentials.dart';
import 'package:notifi/jwt_utils.dart';
import 'package:notifi/state/nest_auth2.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:logger/logger.dart' as logger;
import 'package:latlong2/latlong.dart';

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
  List<String> _topics = [
    defaultRealm,
    'test',
  ];

  @override
  String build() {
    init();

    return "NOT_READY";
  }

  Future<void> init() async {
    if (kIsWeb) {
      _topics = [];
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

  List<String> getTopics() {
    return _topics;
  }

  List<String> addTopic(String topic) {
    _topics.add(topic);
    return _topics;
  }

  List<String> removeTopic(String topic) {
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
  }
}

Future<void> subscribeToTopics(List<String> topics) async {
  if (enableNotifications) {
    if (!kIsWeb) {
      logNoStack.i("NOTIFI2: Subscribing to topics");

      for (final topic in topics) {
        try {
          FirebaseMessaging.instance.subscribeToTopic(topic).then((_) {
            logNoStack.i("NOTIFI2: Subscribed to topic: $topic");
          });
        } on Exception catch (_) {
          log.e("NOTIFI2: Firebase error");
        }
      }
    } else {
      logNoStack.i("NOTIFI2: Not subscribing to topics");
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

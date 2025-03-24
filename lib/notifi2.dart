library notifi;

import 'dart:convert';
import 'dart:io' show Platform;

import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart' as logger;
import 'package:notifi/jwt_utils.dart';
import 'package:notifi/riverpod/deviceid_notifier.dart';
import 'package:notifi/riverpod/fcm_notifier.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'credentials.dart';
import 'firebase/firebase_api.dart';

part 'notifi2.g.dart';

var log = logger.Logger(
  printer: logger.PrettyPrinter(),
  level: logger.Level.info,
);

var logNoStack = logger.Logger(
  printer: logger.PrettyPrinter(methodCount: 0),
  level: logger.Level.info,
);

bool get isAndroid => !kIsWeb && Platform.isAndroid;
bool get isIOS => !kIsWeb && Platform.isIOS;
bool get isWindows => !kIsWeb && Platform.isWindows;

String? _fcmToken = '';
String? get fcmToken => _fcmToken;

late AndroidNotificationChannel _androidChannel;

bool isFlutterLocalNotificationsInitialized = false;

// /// Initialize the [FlutterLocalNotificationsPlugin] package.
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  log.d("Handling a background message: ${message.messageId}");
}

Future<void> setupFlutterNotifications() async {
  if (isFlutterLocalNotificationsInitialized) {
    log.d("Flutter Local Notifications not initialised, exiting");
    return;
  }
  _androidChannel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  /// Create an Android Notification Channel.
  ///
  /// We use this channel in the `AndroidManifest.xml` file to override the
  /// default FCM channel to enable heads up notifications.
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(_androidChannel);

  /// Update the iOS foreground notification presentation options to allow
  /// heads up notifications.
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  isFlutterLocalNotificationsInitialized = true;
}

@Riverpod(keepAlive: true)
void Notifi2(Ref ref, FirebaseOptions options, secondsToast,
    List<String>? topics) async {
  logNoStack.i("NOTIFI2: run");
  FirebaseOptions? _options;

  bool _preventAutoLogin = false;
  int _secondsToast = secondsToast ?? 2;
  List<String> _topics = topics ?? [];
  List<CameraDescription> _cameras = <CameraDescription>[];

  String deviceId = await fetchDeviceId();

  ref.read(deviceIdNotifierProvider.notifier).setDeviceId(deviceId);

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

  if (enableNotifications) {
    await Firebase.initializeApp(options: options);
  }

  WidgetsFlutterBinding.ensureInitialized();

  logNoStack
      .i("NOTIFI: Camera setting is ${enableCamera ? "ENABLED" : "DISABLED"}");
  if (enableCamera) {
    initialiseCamera(_cameras);
  }

  //if (Constants.notificationsEnabled) {
  if (enableNotifications) {
    await Firebase.initializeApp(options: options);

    // Set the background messaging handler early on, as a named top-level function
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    if (!kIsWeb) {
      // await setupFlutterNotifications();  <--- using the web example
      await FirebaseApi().initNotifications();
    } else {
      await setupFlutterNotifications();
    }
  }

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: true,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: true,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    logNoStack.i('NOTIFI: User granted notifications permission');
  } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
    logNoStack.i('NOTIFI: User granted provisional messaging permission');
  } else {
    logNoStack
        .i('NOTIFI: User declined or has not accepted messaging permission');
  }
  logNoStack
      .i('NOTIFI: User granted permission: ${settings.authorizationStatus}');

  FirebaseMessaging.instance.onTokenRefresh.listen((token) async {
    // TODO: If necessary send token to application server.

    // Note: This callback is fired at each app startup and whenever a new
    // token is generated.
    logNoStack.i("NOTIFI: Refresh Notifi FCM TOKEN = $token");
    ref.read(fcmNotifierProvider.notifier).setFcm(token);
  }).onError((err) {
    // Error getting token.
  });

  if (kIsWeb) {
    logNoStack.i("Got to here: WEB detected");
  } else {
    logNoStack.i("Got to here: WEB not detected");
  }
  if (kIsWeb) {
    logNoStack.i("NOTIFI: vapidKey is $vapidKey");
    FirebaseMessaging.instance.getToken(vapidKey: vapidKey).then((token) {
      logNoStack.i("NOTIFI: Web fcm token is $token");
      ref.read(fcmNotifierProvider.notifier).setFcm(token!);
    });
  }

  if (isIOS) {
    logNoStack.i("NOTIFI: Fetching Mobile Apple fcm token ");
    FirebaseMessaging.instance.getAPNSToken().then((apnsToken) {
      if (apnsToken != null) {
        // APNS token is available, make FCM plugin API requests...
        FirebaseMessaging.instance.getToken().then((token) {
          logNoStack.i("NOTIFI: Mobile Apple fcm token is $_fcmToken");
          subscribeToTopics(_topics);
          ref.read(fcmNotifierProvider.notifier).setFcm(token!);
        });
      }
    });
  }
  if (isAndroid) {
    FirebaseMessaging.instance.getToken().then((token) {
      _fcmToken = token;
      String fcm = token!;
      logNoStack.d("NOTIFI: Mobile Android fcm token is $_fcmToken");
      subscribeToTopics(_topics);
      ref.read(fcmNotifierProvider.notifier).setFcm(fcm);
    });
  }

  logNoStack.d("NOTIFI: Got to here before setup Flutter Notifications");
  await setupFlutterNotifications();
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    final notification = message.notification;
    if (notification == null) return;

    logNoStack.i(
        "NOTIFI: INCOMING NOTIFICATION:!nTITLE: ${notification.title}\nBODY: ${notification.body}");
    flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
            _androidChannel.id, _androidChannel.name,
            channelDescription: _androidChannel.description,
            icon: '@drawable/ic_launcher'),
      ),
      payload: jsonEncode(message.toMap()),
    );
    logNoStack
        .i("NOTIFI: INCOMING NOTIFICATION: AFter flutterLocalnotifixaiotn");
    Fluttertoast.showToast(
        msg: "${notification.title!}::${notification.body!}",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: secondsToast,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
    logNoStack.i("NOTIFI: INCOMING NOTIFICATION: AFter toast");
  });

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

}

// void setPreventAutoLogin(bool preventAutoLogin) {
//   _preventAutoLogin = preventAutoLogin;
// }

// void addTopic(String topic) {
//   _topics.add(topic);
// }

// void removeTopic(String topic) {
//   _topics.remove(topic);
// }

void initialiseCamera(List<CameraDescription> cameras) async {
  // Fetch the available cameras before initializing the app.
  try {
    cameras = await availableCameras();
  } on CameraException catch (e) {
    logNoStack.e("${e.code} ${e..description}");
  }
}

void subscribeToTopics(List<String> topics) {
  if (enableNotifications) {
    if (!kIsWeb) {
      logNoStack.i("NOTIFI: Subscribing to topics");

      for (final topic in topics) {
        try {
          FirebaseMessaging.instance.subscribeToTopic(topic).then((_) {
            logNoStack.i("NOTIFI: Subscribed to topic: $topic");
          });
        } on Exception catch (_) {
          log.e("NOTIFI: Firebase error");
        }
      }
    } else {
      logNoStack.i("NOTIFI: Not subscribing to topics");
    }
  }
}

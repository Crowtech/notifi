library notifi;

import 'dart:convert';
import 'dart:io' show Platform;

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_storage/get_storage.dart';

//import 'firebase_options.dart';

bool get isAndroid => !kIsWeb && Platform.isAndroid;
bool get isIOS => !kIsWeb && Platform.isIOS;
bool get isWindows => !kIsWeb && Platform.isWindows;
bool get isWeb => kIsWeb;
late AndroidNotificationChannel _androidChannel;

bool isFlutterLocalNotificationsInitialized = false;

// /// Initialize the [FlutterLocalNotificationsPlugin] package.
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}

Future<void> setupFlutterNotifications() async {
  if (isFlutterLocalNotificationsInitialized) {
    print("Flutter Local Notifications not initialised, exiting");
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

class Notifi {
  String? vapidKey;
  int secondsToast;
  List<String> _topics = ["all"];
  FirebaseOptions? options;

  Notifi(
      {this.options,
      this.vapidKey,
      this.secondsToast = 2,
      List<String>? topics}) {
    if (topics != null && topics.isNotEmpty) {
      this._topics.addAll(topics);
    }
    if (defaultTargetPlatform == TargetPlatform.android) {
      this._topics.add('android');
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      this._topics.add('ios');
    } else if (defaultTargetPlatform == TargetPlatform.linux) {
      this._topics.add('linux');
    } else if (defaultTargetPlatform == TargetPlatform.windows) {
      this._topics.add('windows');
    } else if (defaultTargetPlatform == TargetPlatform.macOS) {
      this._topics.add('macos');
    } else if (defaultTargetPlatform == TargetPlatform.fuchsia) {
      this._topics.add('fuchsia');
    } else {
      // We use 'web' as the default platform for unknown platforms.
      this._topics.add('web');
    }
  }

  Future<void> init() async {
    await GetStorage.init();
    await Firebase.initializeApp(options: options);

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
      print('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }
    print('User granted permission: ${settings.authorizationStatus}');

    FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) async {
      // TODO: If necessary send token to application server.

      // Note: This callback is fired at each app startup and whenever a new
      // token is generated.
      print("Refresh Notifi FCM TOKEN = $fcmToken");
    }).onError((err) {
      // Error getting token.
    });

    if (isWeb) {
      final fcmToken =
          await FirebaseMessaging.instance.getToken(vapidKey: vapidKey);
      print("Web fcm token is $fcmToken");
    }

    if (isIOS) {
      final apnsToken = await FirebaseMessaging.instance.getAPNSToken();
      if (apnsToken != null) {
        // APNS token is available, make FCM plugin API requests...
        final fcmToken = await FirebaseMessaging.instance.getToken();
        print("Mobile Apple fcm token is $fcmToken");
      }
    }
    if (isAndroid) {
      final fcmToken = await FirebaseMessaging.instance.getToken();
      print("Mobile Android fcm token is $fcmToken");
    }
    await setupFlutterNotifications();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      final notification = message.notification;
      if (notification == null) return;

      print("Foreground msg:${notification.title!}::${notification.body!}");
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

      Fluttertoast.showToast(
          msg: "${notification.title!}::${notification.body!}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: secondsToast,
          fontSize: 16.0);
    });

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    if (!isWeb) {
      for (final topic in _topics) {
        await FirebaseMessaging.instance.subscribeToTopic(topic);
      }
    }
  }
}

library notifi;

import 'dart:convert';
import 'dart:io' show Platform;
import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_storage/get_storage.dart';
import 'package:notifi/geo_page.dart';
import 'package:notifi/models/person.dart' as Person;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:logger/logger.dart' as logger;

var log = logger.Logger(
  printer: logger.PrettyPrinter(),
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

class Notifi extends ChangeNotifier {
  String? _vapidKey;
  int secondsToast = 2;
  final List<String> _topics = [];
  String _fcm = "Loading ...";
  bool _preventAutoLogin = false;

  late PackageInfo _packageInfo;
  late String _deviceId;

  Person.Person? user;

  FirebaseOptions? options;

  String? get vapidKey => _vapidKey;
  String? get deviceId => _deviceId;


  PackageInfo? get packageInfo => _packageInfo;

  /// List of items in the cart.
  List<String> get topics => _topics;

  String get fcm => _fcm;
  Notifi get notifi => this;

  bool get preventAutoLogin => _preventAutoLogin;

 set preventAutoLogin(bool value) {
   _preventAutoLogin = value;
 }


  set fcm(String newFcm) {
    _fcm = newFcm;
    notifyListeners();
  }

  void addTopic(String topic) {
    _topics.add(topic);
    // This line tells [Model] that it should rebuild the widgets that
    // depend on it.
    notifyListeners();
  }

  void removeTopic(String topic) {
    _topics.remove(topic);
    // This line tells [Model] that it should rebuild the widgets that
    // depend on it.
    notifyListeners();
  }

  Notifi(
      {this.options,
      String? vapidKey,
      required PackageInfo packageInfo,
      required String deviceId,
      this.secondsToast = 2,
      List<String>? topics}) {
    logNoStack.d("notifi constructor");
    _vapidKey = vapidKey;
    _packageInfo = packageInfo;
    _deviceId = deviceId;

    if (kIsWeb) {
      topics = [];
    }
    if (topics != null && topics.isNotEmpty) {
      _topics.addAll(topics);
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
    // log.d("PACKAGE ${packageInfo!.version} ${deviceId} ");
  }

  ChangeNotifier initialise() {
    init();
    return this;
  }

  Future<ChangeNotifier> init() async {
    logNoStack.i("Notifi initing!");
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
      logNoStack.i('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      logNoStack.i('User granted provisional permission');
    } else {
      logNoStack.i('User declined or has not accepted permission');
    }
    logNoStack.i('User granted permission: ${settings.authorizationStatus}');

    FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) async {
      // TODO: If necessary send token to application server.

      // Note: This callback is fired at each app startup and whenever a new
      // token is generated.
      log.d("Refresh Notifi FCM TOKEN = $fcmToken");
      fcmToken = fcmToken;
      fcm = fcmToken;
      notifyListeners();
    }).onError((err) {
      // Error getting token.
    });

    if (kIsWeb) {
      log.d("Got to here: WEB detected");
    } else {
      logNoStack.i("Got to here: WEB not detected");
    }
    if (kIsWeb) {
      logNoStack.i("vapidKey is $vapidKey");
      FirebaseMessaging.instance.getToken(vapidKey: vapidKey).then((token) {
        logNoStack.d("Web fcm token is $token");
        _fcmToken = token;
        fcm = token!;
        notifyListeners();
      });
    }

    if (isIOS) {
      logNoStack.i("Fetching Mobile Apple fcm token ");
      FirebaseMessaging.instance.getAPNSToken().then((apnsToken) {
        if (apnsToken != null) {
          // APNS token is available, make FCM plugin API requests...
          FirebaseMessaging.instance.getToken().then((token) {
            _fcmToken = token;
            fcm = token!;
            notifyListeners();
            logNoStack.i("Mobile Apple fcm token is $_fcmToken");
            subscribeToTopics();
          });
        }
      });
    }
    if (isAndroid) {
      FirebaseMessaging.instance.getToken().then((token) {
        _fcmToken = token;
        fcm = token!;
        notifyListeners();
        logNoStack.d("Mobile Android fcm token is $_fcmToken");
        subscribeToTopics();
      });
    }

    logNoStack.d("Got to here before setup Flutter Notifications");
    await setupFlutterNotifications();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      final notification = message.notification;
      if (notification == null) return;

      logNoStack
          .d("Foreground msg:${notification.title!}::${notification.body!}");
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

    return this;
  }

  void subscribeToTopics() {
    if (!kIsWeb) {
      logNoStack.i("Subscribing to topics");

      for (final topic in _topics) {
        try {
          FirebaseMessaging.instance.subscribeToTopic(topic).then((_) {
            logNoStack.i("Subscribed to topic: $topic");
          });
        } on Exception catch (_) {
          log.e("Firebase error");
        }
      }
    } else {
      logNoStack.i("Not subscribing to topics");
    }
  }

  
}

library notifi;

import 'dart:convert';
import 'dart:io' show Platform;

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_storage/get_storage.dart';
import 'package:package_info_plus/package_info_plus.dart';

//import 'firebase_options.dart';

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

class Notifi extends ChangeNotifier {
  String? _vapidKey;
  int secondsToast = 2;
  final List<String> _topics = [];
  late String _fcm;

  late PackageInfo _packageInfo ;
  late String _deviceId;

  FirebaseOptions? options;

  String? get vapidKey => _vapidKey;
 String? get deviceId  => _deviceId ;

 PackageInfo? get packageInfo => _packageInfo ;

  /// List of items in the cart.
  List<String> get topics => _topics;

  String get fcm => _fcm;

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

  Notifi({
    this.options,
    String? vapidKey,
    required  PackageInfo packageInfo,
    required String deviceId,
    this.secondsToast = 2,
    List<String>? topics,
  }) {
    print("notifi constructor");
    _vapidKey = vapidKey;
    _packageInfo = packageInfo;
    _deviceId = deviceId;


    if (kIsWeb) {
      topics = [];
    }
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
    // print("PACKAGE ${packageInfo!.version} ${deviceId} ");
  }

  ChangeNotifier initialise()
  {
    init();
    return this;
  }

  Future<ChangeNotifier> init() async {
    print("Notifi initing!");
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

    FirebaseMessaging.instance.onTokenRefresh.listen((__fcmToken) async {
      // TODO: If necessary send token to application server.

      // Note: This callback is fired at each app startup and whenever a new
      // token is generated.
      print("Refresh Notifi FCM TOKEN = $__fcmToken");
      _fcmToken = __fcmToken;
      fcm = __fcmToken;
      notifyListeners();
    }).onError((err) {
      // Error getting token.
    });

    if (kIsWeb) {
      print("Got to here: WEB detected");
    } else {
      print("Got to here: WEB not detected");
    }
    if (kIsWeb) {
      print("vapidKey is $vapidKey");
      FirebaseMessaging.instance.getToken(vapidKey: vapidKey).then((token) {
        print("Web fcm token is $token");
        _fcmToken = token;
        fcm = token!;
        notifyListeners();
      });
    }

    if (isIOS) {
      final apnsToken = await FirebaseMessaging.instance.getAPNSToken();
      if (apnsToken != null) {
        // APNS token is available, make FCM plugin API requests...
        FirebaseMessaging.instance.getToken().then((token) {
          _fcmToken = token;
          fcm = token!;
          notifyListeners();
          print("Mobile Apple fcm token is $_fcmToken");
        });
      }
    }
    if (isAndroid) {
      FirebaseMessaging.instance.getToken().then((token) {
        _fcmToken = token;
        fcm = token!;
        notifyListeners();
        print("Mobile Android fcm token is $_fcmToken");
      });
    }
    print("Got to here before setup Flutter Notifications");
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

    if (!kIsWeb) {
      print("Subscribing to topics");

      for (final topic in _topics) {
        FirebaseMessaging.instance.subscribeToTopic(topic).then((_) {
          print("Subscribed to topic: $topic");
        });
      }
    } else {
      print("Not subscribing to topics");
    }
    return this;
  }
}

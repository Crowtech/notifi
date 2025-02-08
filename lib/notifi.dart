library notifi;

import 'dart:convert';
import 'dart:io' show Platform;

import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_storage/get_storage.dart';
import 'package:notifi/firebase/firebase_api.dart';
import 'package:notifi/geo_page.dart';
import 'package:notifi/jwt_utils.dart';
import 'package:notifi/models/person.dart' as Person;
import 'package:notifi/riverpod/fcm.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:logger/logger.dart' as logger;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:notifi/app_state.dart' as app_state;

import 'credentials.dart';

var log = logger.Logger(
  printer: logger.PrettyPrinter(),
  level: logger.Level.info,
);

var logNoStack = logger.Logger(
  printer: logger.PrettyPrinter(methodCount: 0),
  level: logger.Level.info,
);



@riverpod
class Notifi extends _$Notifi {
  late SharedPreferences _sharedPreferences;

  String? _vapidKey;
  int secondsToast = 2;
  final List<String> _topics = [];
  String _fcm = "Loading ...";
  bool _preventAutoLogin = false;

  late PackageInfo _packageInfo;
  late String _deviceId;
  List<CameraDescription> _cameras = <CameraDescription>[];

  Person.Person? _user;
  bool _userReady = false;

  FirebaseOptions? options;

  bool get userReady => _userReady;
  set userReady(bool value) {
    _userReady = value;
  }

  String? get vapidKey => _vapidKey;
  String? get deviceId => _deviceId;

  PackageInfo? get packageInfo => _packageInfo;

  /// List of items in the cart.
  List<String> get topics => _topics;

  String get fcm => _fcm;
  List<CameraDescription> get cameras => _cameras;

  Notifi get notifi => this;

  bool get preventAutoLogin => _preventAutoLogin;

  set preventAutoLogin(bool value) {
    _preventAutoLogin = value;
  }

@override
  Future<String> build() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    logNoStack.i("NOTIFI Build!");

    // listen for cachedAuthUser then call auth_controller login
    //ref.read(authControllerProvider.notifier).loginOidc( event );
    app_state.currentManager.userChanges().listen((event) async {
      if (event?.userInfo != null) {
        var exp = event?.claims['exp'];
        var name = event?.claims['name'];
        var username = event?.claims['preferred_username'];

        var deviceId = await fetchDeviceId();
        logNoStack.i(
          'AUTH CONTROLLER BUILD: App State User changed (login): exp:$exp, $username, $name $deviceId',
        );
        logNoStack.i("token = ${event?.token.accessToken}");
        ref.read(fcmProvider.notifier).init();
      } else {
        logNoStack.i("NOTIFI BUILD: App State User changed to NULL:");
      }
    });


    return "";
  }

  init(
      {this.options,
      String? vapidKey,
      required PackageInfo packageInfo,
      required String deviceId,
      this.secondsToast = 2,
      List<String>? topics}) {
    log.i("notifi constructor");


    _vapidKey = vapidKey;
    _packageInfo = packageInfo;
    _deviceId = deviceId;

      }

  ChangeNotifier initialise() {
    log.i("Initialising Notifi");
    init();
    return this;
  }

  Future<ChangeNotifier> init() async {
    logNoStack.i("Notifi initing!");
    await GetStorage.init();
   // await Firebase.initializeApp(options: options);

    WidgetsFlutterBinding.ensureInitialized();

    //String? vapidKey, List<String>? topics, FirebaseOptions? options}
    fcmProvider.read<.init(vapidKey,topics,);

    logNoStack.i(
        "NOTIFI: Camera setting is ${enableCamera ? "ENABLED" : "DISABLED"}");
    if (enableCamera) {
      initialiseCamera();
    }

    //FirebaseMessaging messaging = FirebaseMessaging.instance;

      await Firebase.initializeApp(options: options);

  // Set the background messaging handler early on, as a named top-level function
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  if (!kIsWeb) {
    // await setupFlutterNotifications();  <--- using the web example
    await FirebaseApi().initNotifications();
  } else {
    await setupFlutterNotifications();
  }

    // NotificationSettings settings = await messaging.requestPermission(
    //   alert: true,
    //   announcement: true,
    //   badge: true,
    //   carPlay: false,
    //   criticalAlert: false,
    //   provisional: true,
    //   sound: true,
    // );

    // if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    //   logNoStack.i('NOTIFI: User granted notifications permission');
    // } else if (settings.authorizationStatus ==
    //     AuthorizationStatus.provisional) {
    //   logNoStack.i('NOTIFI: User granted provisional messaging permission');
    // } else {
    //   logNoStack
    //       .i('NOTIFI: User declined or has not accepted messaging permission');
    // }
    // logNoStack
    //     .i('NOTIFI: User granted permission: ${settings.authorizationStatus}');

    // FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) async {
    //   // TODO: If necessary send token to application server.

    //   // Note: This callback is fired at each app startup and whenever a new
    //   // token is generated.
    //   log.i("NOTIFI: Refresh Notifi FCM TOKEN = $fcmToken");
    //   fcmToken = fcmToken;
    //   fcm = fcmToken;
    //   notifyListeners();
    // }).onError((err) {
    //   // Error getting token.
    // });

    // if (kIsWeb) {
    //   log.i("Got to here: WEB detected");
    // } else {
    //   logNoStack.i("Got to here: WEB not detected");
    // }
    // if (kIsWeb) {
    //   logNoStack.i("NOTIFI: vapidKey is $vapidKey");
    //   FirebaseMessaging.instance.getToken(vapidKey: vapidKey).then((token) {
    //     logNoStack.i("NOTIFI: Web fcm token is $token");
    //     _fcmToken = token;
    //     fcm = token!;
    //     notifyListeners();
    //   });
    // }

    // if (isIOS) {
    //   logNoStack.i("NOTIFI: Fetching Mobile Apple fcm token ");
    //   FirebaseMessaging.instance.getAPNSToken().then((apnsToken) {
    //     if (apnsToken != null) {
    //       // APNS token is available, make FCM plugin API requests...
    //       FirebaseMessaging.instance.getToken().then((token) {
    //         _fcmToken = token;
    //         fcm = token!;
    //         notifyListeners();
    //         logNoStack.i("NOTIFI: Mobile Apple fcm token is $_fcmToken");
    //         subscribeToTopics();
    //       });
    //     }
    //   });
    // }
    // if (isAndroid) {
    //   FirebaseMessaging.instance.getToken().then((token) {
    //     _fcmToken = token;
    //     fcm = token!;
    //     notifyListeners();
    //     logNoStack.d("NOTIFI: Mobile Android fcm token is $_fcmToken");
    //     subscribeToTopics();
    //   });
    // }

    // logNoStack.d("NOTIFI: Got to here before setup Flutter Notifications");
    // await setupFlutterNotifications();
    // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    //   final notification = message.notification;
    //   if (notification == null) return;

    //   logNoStack.i(
    //       "NOTIFI: INCOMING NOTIFICATION:!nTITLE: ${notification.title}\nBODY: ${notification.body}");
    //   flutterLocalNotificationsPlugin.show(
    //     notification.hashCode,
    //     notification.title,
    //     notification.body,
    //     NotificationDetails(
    //       android: AndroidNotificationDetails(
    //           _androidChannel.id, _androidChannel.name,
    //           channelDescription: _androidChannel.description,
    //           icon: '@drawable/ic_launcher'),
    //     ),
    //     payload: jsonEncode(message.toMap()),
    //   );
    //   logNoStack
    //       .i("NOTIFI: INCOMING NOTIFICATION: AFter flutterLocalnotifixaiotn");
    //   Fluttertoast.showToast(
    //       msg: "${notification.title!}::${notification.body!}",
    //       toastLength: Toast.LENGTH_SHORT,
    //       gravity: ToastGravity.CENTER,
    //       timeInSecForIosWeb: secondsToast,
    //       backgroundColor: Colors.red,
    //     textColor: Colors.white,
    //       fontSize: 16.0);
    //   logNoStack.i("NOTIFI: INCOMING NOTIFICATION: AFter toast");
    // });

    // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    return this;
  }

  void subscribeToTopics() {
    if (!kIsWeb) {
      logNoStack.i("NOTIFI: Subscribing to topics");

      for (final topic in _topics) {
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

  void initialiseCamera() async {
    // Fetch the available cameras before initializing the app.
    try {
      _cameras = await availableCameras();
    } on CameraException catch (e) {
      logNoStack.e("${e.code} ${e..description}");
    }
  }
}

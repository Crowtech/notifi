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
import 'package:notifi/riverpod/fcm_notifier.dart';
import 'package:notifi/riverpod/nest_notifis_provider.dart';
import 'package:notifi/state/nest_auth2.dart';
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
  log.i("Handling a background message: ${message.messageId}");
  if (message.data.isNotEmpty) {
    String output = '';
    for (final kv in message.data.entries) {
      output += ('${kv.key} = ${kv.value}\n');
    }
    log.i("Handling a background message data:\n$output");
  }
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

bool notifi2AlreadyRunning = false;

@Riverpod(keepAlive: true)
void Notifi2(Ref ref, FirebaseOptions options, secondsToast) async {
  logNoStack.i(
      "NOTIFI2: run $notifi2AlreadyRunning?'notifi already running':'notifi starting new");
  if (notifi2AlreadyRunning == true) {
    return;
  } else {
    notifi2AlreadyRunning = true;
  }

  FirebaseOptions? options0 = options;

  bool preventAutoLogin = false;
  int secondsToast0 = secondsToast ?? 2;
  List<CameraDescription> cameras = <CameraDescription>[];

  //ref.read(deviceIdNotifierProvider.notifier).setDeviceId(deviceId);

  logNoStack.i(
      "NOTIFI2: EnableNotifications setting is ${enableNotifications ? "ENABLED" : "DISABLED"}");

  WidgetsFlutterBinding.ensureInitialized();

  logNoStack
      .i("NOTIFI2: Camera setting is ${enableCamera ? "ENABLED" : "DISABLED"}");
  if (enableCamera) {
    initialiseCamera(cameras);
  }

  //if (Constants.notificationsEnabled) {
  if (enableNotifications) {
    logNoStack.i("NOTIFI2: About to initialise Firebase");
    await Firebase.initializeApp(options: options);
    logNoStack.i("NOTIFI2: after init Firebase App");
    // Set the background messaging handler early on, as a named top-level function
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    if (!kIsWeb) {
      await FirebaseApi().initNotifications();
      await setupFlutterNotifications(); //<--- using the web example
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
    logNoStack.i('NOTIFI2: User granted notifications permission');
  } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
    logNoStack.i('NOTIFI2: User granted provisional messaging permission');
  } else {
    logNoStack
        .i('NOTIFI2: User declined or has not accepted messaging permission');
  }
  logNoStack
      .i('NOTIFI2: User granted permission: ${settings.authorizationStatus}');

  FirebaseMessaging.instance.onTokenRefresh.listen((token) async {
    // TODO: If necessary send token to application server.

    // Note: This callback is fired at each app startup and whenever a new
    // token is generated.
    logNoStack.i("NOTIFI2: Refresh Notifi FCM TOKEN = $token");
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
    logNoStack.i("NOTIFI2: vapidKey is $vapidKey");
    FirebaseMessaging.instance.getToken(vapidKey: vapidKey).then((fcm) async {
      logNoStack.i("NOTIFI2: Web fcm token is $fcm");
      ref.read(fcmNotifierProvider.notifier).setFcm(fcm!);
      bool isLoggedIn = ref.read(nestAuthProvider.notifier).isLoggedIn;
      if (isLoggedIn) {
        String authToken = ref.read(nestAuthProvider.notifier).token!;
        ref.read(fcmNotifierProvider.notifier).sendFcm(authToken, fcm);
            }
      Fluttertoast.showToast(
          msg: "FCM : $fcm",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: secondsToast,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }).catchError((e) {
      logNoStack
          .e('NOTIFI2: web fcm Got error: $e'); // Finally, callback fires.
    });
  }


  if (isIOS) {
    String? apnsToken = await FirebaseMessaging.instance.getAPNSToken();
    logNoStack.i('APNS Token: $apnsToken');
    await Future.delayed(const Duration(seconds: 3));
    //subscribeToTopics(_topics);
    //     ref.read(fcmNotifierProvider.notifier).setFcm(token!);

    logNoStack.i("NOTIFI2: Fetching Mobile Apple fcm token ");
    // FirebaseMessaging.instance.getAPNSToken().then((apnsToken) {
    logNoStack.i("NOTIFI2: In getAPNSToken $apnsToken ");
    if (apnsToken != null) {
      // APNS token is available, make FCM plugin API requests...
      FirebaseMessaging.instance.getToken().then((fcm) async {
        logNoStack.i("NOTIFI2: Mobile Apple fcm token is $fcm");

        ref.read(fcmNotifierProvider.notifier).setFcm(fcm!);
        bool isLoggedIn = ref.read(nestAuthProvider.notifier).isLoggedIn;
        if (isLoggedIn) {
          String authToken = ref.read(nestAuthProvider.notifier).token!;
          ref.read(fcmNotifierProvider.notifier).sendFcm(authToken, fcm);
        }
        Fluttertoast.showToast(
            msg: "FCM : $fcm",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: secondsToast,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      });
    } else {
      logNoStack.i("NOTIFI2: In getAPNSToken IT IS NULL ");
    }
    // }).catchError((e) {
    //     logNoStack.e('NOTIFI2: ios fcm Got error: $e'); // Finally, callback fires.

    //   });
  }
  if (isAndroid) {
    FirebaseMessaging.instance.getToken().then((token) async {
      _fcmToken = token;
      String fcm = token!;
      logNoStack.d("NOTIFI2: Mobile Android fcm token is $_fcmToken");

      ref.read(fcmNotifierProvider.notifier).setFcm(fcm);
      bool isLoggedIn = ref.read(nestAuthProvider.notifier).isLoggedIn;
      if (isLoggedIn) {
        String authToken = ref.read(nestAuthProvider.notifier).token!;
        ref.read(fcmNotifierProvider.notifier).sendFcm(authToken, fcm);
      }
      Fluttertoast.showToast(
          msg: "FCM : $token",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: secondsToast,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }).catchError((e) {
      logNoStack
          .e('NOTIFI2: android fcm Got error: $e'); // Finally, callback fires.
    });
  }

  logNoStack.d("NOTIFI2: Got to here before setup Flutter Notifications");
  await setupFlutterNotifications();
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!!!!');
    print('Message data!!!: ${message.data}');


    // if (message.notification != null) {
    //   print('Message also contained a notification: ${message.notification}');
    // }
    // logNoStack.i("NOTIFI2: iIncoming Notification msgType=>${message.messageType!}");
    if (message.data.isNotEmpty) {
      
      logNoStack.i('Message data AGAIN!: ${message.data} category: ${message.category}');
      Map<String, dynamic> data = message.data;
      logNoStack.i('Message data AGAIN2!: $data');
      String output = '';
      for (final kv in message.data.entries) {
        output += ('${kv.key} = ${kv.value}\n');

      }
      logNoStack.i(
          "NOTIFI2: INCOMING DATA NOTIFICATION!:\n $output\n ");
      Fluttertoast.showToast(
          msg: "Incoming ${message.category ?? ''} Data!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: secondsToast*4,
          backgroundColor: const Color.fromARGB(255, 143, 54, 244),
          textColor: const Color.fromARGB(255, 250, 248, 248),
          webBgColor: "linear-gradient(139deg, #3a47d5, #purple)",
          fontSize: 16.0);
    } else if (message.notification != null) {
      final notification = message.notification;
      logNoStack.i("NOTIFI2: INCOMING NOTIFICATION: $notification");
      logNoStack.i(
          "NOTIFI2: INCOMING NOTIFICATION:!nTITLE: ${notification!.title}\nBODY: ${notification.body}");

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
          .i("NOTIFI2: INCOMING NOTIFICATION: AFter flutterLocalnotifixaiotn");

      ref
          .read(nestNotifisProvider.notifier)
          .addRemoteNotification(notification);
      Fluttertoast.showToast(
          msg: "${notification.title!}::${notification.body!}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: secondsToast,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      logNoStack.i("NOTIFI2: INCOMING NOTIFICATION: AFter toast");
    }
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

import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:notifi/credentials.dart';
import 'package:session_storage/session_storage.dart';
// import 'package:get_storage/get_storage.dart';
//import 'package:firebase_messaging_web/firebase_messaging_web.dart';

class FirebaseApi {
  //create an instance of firebase messaging
  final _firebaseMessaging = FirebaseMessaging.instance;

  final _androidChannel = const AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    description: 'This channel is used for important notification',
    importance: Importance.defaultImportance,
  );

  final _localNotifications = FlutterLocalNotificationsPlugin();
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future initLocalNotifications() async {
    print("LocalNotifs INitialiazed");
    const android = AndroidInitializationSettings('@drawable/ic_launcher');
    var ios = const DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      // onDidReceiveLocalNotification:
      //     (int id, String? title, String? body, String? payload) async {},
    );

    var settings = InitializationSettings(android: android, iOS: ios);

    await _localNotifications.initialize(
      settings,
    );

    final platform = _localNotifications.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    await platform?.createNotificationChannel(_androidChannel);
  }

  Future initPushNotifications() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // Handle incoming data message when the app is in the foreground
      print("Data message received: ${message.data}");
      showFlutterNotification(message);

      Fluttertoast.showToast(
          msg: "Incoming Data Message Received at firebase api.dart${message.data}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 5,
          fontSize: 16.0);
      // Extract data and perform custom actions
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      // Handle incoming data message when the app is in the background or terminated
      print("Data message opened: ${message.data}");
      // Extract data and perform custom actions
    });

    FirebaseMessaging.onMessage.listen((message) {
      final notification = message.notification;
      if (notification == null) return;

      _localNotifications.show(
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
          timeInSecForIosWeb: 1,
          fontSize: 16.0);
    });
  }

  //function to initialize notifications
  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();

    // fetch FCM Token for this device
    final fCMToken = await _firebaseMessaging.getToken(
        vapidKey:
            vapidKey);

    print('token: $fCMToken');

    if (kIsWeb) {
      final session = SessionStorage();
      session["fcm"] = fCMToken.toString();
      //await FirebaseMessaging.instance.subscribeToTopic("web");
      print("web notify initialised");
    } else {
      print("saving to secure storage");
      // final box = GetStorage();
      // box.write('fcm', fCMToken.toString());

      await _storage.write(key: 'fcm', value: fCMToken.toString());
      String? fcmToken = await _storage.read(key: 'fcm');
      print("FCM Token: ${fcmToken}Saved Securely");

      initPushNotifications();
      initLocalNotifications();
      print("non web notify initialised");
    }

    if (Platform.isAndroid) {
      print("android subscribe");
      await FirebaseMessaging.instance.subscribeToTopic("android");
    }
    if (Platform.isIOS) {
      print("ios subscribe");
      await FirebaseMessaging.instance.subscribeToTopic("ios");
    }
    print("exiting initNotifications");
  }

  //function to handle received messages
  void showFlutterNotification(RemoteMessage message) {
    print("Incoming message: $message");
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;

    if (notification != null && android != null && !kIsWeb) {
      _localNotifications.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            _androidChannel.id,
            _androidChannel.name,
            channelDescription: _androidChannel.description,
            // TODO add a proper drawable resource to android, for now using
            //      one that already exists in example app.
            icon: 'launch_background',
          ),
        ),
      );
    }
    if (notification != null && kIsWeb) {
      print("Notification detected!-> ${notification.title!}: ${notification.body!}");

      Fluttertoast.showToast(
          msg: "${notification.title!}::${notification.body!}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 5,
          fontSize: 16.0);
      // SnackBar(
      //   duration: Duration(milliseconds: 2000),
      //   content: Column(
      //     mainAxisSize: MainAxisSize.min,
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: [
      //       Text(notification.title! + "::" + notification.body!),
      //     ],
      //   ),
      //   backgroundColor: const Color.fromARGB(255, 105, 118, 240),
      // );
    }
  }

  //function to initialize foreground and background settings
}

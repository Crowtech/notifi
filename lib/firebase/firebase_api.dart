/// Firebase Cloud Messaging integration for the Notifi application.
/// 
/// This file provides a centralized Firebase API service that handles:
/// - Firebase Cloud Messaging (FCM) token management
/// - Push notification setup and configuration
/// - Local notification display and handling
/// - Platform-specific notification behavior (Android, iOS, Web)
/// - Secure token storage and retrieval
/// - Topic subscriptions for targeted messaging
/// 
/// The FirebaseApi class serves as the primary interface between the Notifi
/// application and Firebase services, enabling real-time push notifications
/// to keep users informed about important updates and communications.
library;

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

/// Firebase API service for managing push notifications in the Notifi application.
/// 
/// This class provides a comprehensive interface for Firebase Cloud Messaging
/// integration, handling notification setup, token management, and platform-specific
/// behavior. It supports Android, iOS, and Web platforms with appropriate
/// configuration for each environment.
/// 
/// Key responsibilities:
/// - FCM token generation and secure storage
/// - Local notification setup and display
/// - Push notification handling (foreground, background, terminated states)
/// - Platform-specific notification channels and permissions
/// - Topic subscriptions for targeted messaging
class FirebaseApi {
  /// Firebase Messaging instance for handling FCM operations.
  /// 
  /// This is the primary interface for Firebase Cloud Messaging functionality,
  /// including token management, permission requests, and message handling.
  final _firebaseMessaging = FirebaseMessaging.instance;

  /// Android notification channel configuration for high-importance notifications.
  /// 
  /// This channel is specifically configured for critical notifications that
  /// should be displayed prominently to users on Android devices. The channel
  /// uses default importance level to ensure notifications are visible without
  /// being overly intrusive.
  final _androidChannel = const AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    description: 'This channel is used for important notification',
    importance: Importance.defaultImportance,
  );

  /// Flutter Local Notifications plugin instance for displaying notifications.
  /// 
  /// This plugin handles the actual display of notifications on the device,
  /// working in conjunction with Firebase Cloud Messaging to show both
  /// remote and local notifications with consistent styling and behavior.
  final _localNotifications = FlutterLocalNotificationsPlugin();
  
  /// Secure storage instance for persisting FCM tokens.
  /// 
  /// FCM tokens are sensitive data that should be stored securely on the device.
  /// This storage is used on mobile platforms (Android/iOS) to persist tokens
  /// between app launches, ensuring consistent notification delivery.
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  /// Initializes local notification settings for Android and iOS platforms.
  /// 
  /// This method configures the Flutter Local Notifications plugin with
  /// platform-specific settings, enabling the app to display notifications
  /// locally on the device. It sets up notification channels for Android
  /// and permission requests for iOS.
  /// 
  /// Platform-specific behavior:
  /// - Android: Uses the app's launcher icon and creates a high-importance channel
  /// - iOS: Requests alert, badge, and sound permissions from the user
  /// 
  /// The method ensures that the notification system is properly initialized
  /// before any notifications are displayed, providing a consistent experience
  /// across platforms.
  Future initLocalNotifications() async {
    print("LocalNotifs INitialiazed");
    
    // Android notification initialization settings
    // Uses the app's launcher icon as the default notification icon
    const android = AndroidInitializationSettings('@drawable/ic_launcher');
    
    // iOS/macOS notification initialization settings
    // Requests all standard notification permissions from the user
    var ios = const DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      // onDidReceiveLocalNotification:
      //     (int id, String? title, String? body, String? payload) async {},
    );

    // Combine platform-specific settings into a single configuration
    var settings = InitializationSettings(android: android, iOS: ios);

    // Initialize the local notifications plugin with the configured settings
    await _localNotifications.initialize(
      settings,
    );

    // Create the Android notification channel for high-importance notifications
    // This ensures that notifications are displayed with the correct priority
    final platform = _localNotifications.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    await platform?.createNotificationChannel(_androidChannel);
  }

  /// Initializes push notification handling for Firebase Cloud Messaging.
  /// 
  /// This method configures how the app handles incoming push notifications
  /// in different app states (foreground, background, terminated). It sets up
  /// event listeners for various notification scenarios and configures
  /// foreground notification presentation options.
  /// 
  /// Key functionality:
  /// - Configures foreground notification display (alert, badge, sound)
  /// - Sets up listener for messages received while app is in foreground
  /// - Sets up listener for messages that open the app from background/terminated state
  /// - Displays local notifications and toast messages for user feedback
  /// - Handles both notification and data messages from Firebase
  /// 
  /// The method ensures that users receive appropriate feedback for all
  /// notification scenarios, maintaining engagement and communication flow.
  Future initPushNotifications() async {
    // Configure how notifications are presented when the app is in the foreground
    // This ensures users are aware of incoming notifications even when actively using the app
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,  // Show notification alerts
      badge: true,  // Update app badge count
      sound: true,  // Play notification sound
    );

    // Listen for messages received while the app is in the foreground
    // This handler processes both notification and data messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // Handle incoming data message when the app is in the foreground
      print("Data message received: ${message.data}");
      showFlutterNotification(message);

      // Display a toast notification to provide immediate user feedback
      Fluttertoast.showToast(
          msg: "Incoming Data Message Received at firebase api.dart${message.data}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 5,
          fontSize: 16.0);
      // Extract data and perform custom actions
    });

    // Listen for messages that cause the app to open from background or terminated state
    // This handler is triggered when a user taps on a notification
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      // Handle incoming data message when the app is in the background or terminated
      print("Data message opened: ${message.data}");
      // Extract data and perform custom actions
    });

    // Secondary listener for foreground messages to handle notification display
    // This ensures consistent notification presentation across all platforms
    FirebaseMessaging.onMessage.listen((message) {
      final notification = message.notification;
      if (notification == null) return;

      // Display the notification using the local notifications plugin
      // This provides consistent styling and behavior across platforms
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

      // Show a toast with the notification content for immediate user feedback
      Fluttertoast.showToast(
          msg: "${notification.title!}::${notification.body!}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          fontSize: 16.0);
    });
  }

  /// Initializes the complete Firebase Cloud Messaging system for the Notifi application.
  /// 
  /// This is the main entry point for setting up Firebase notifications across all
  /// supported platforms. It handles permission requests, token generation and storage,
  /// platform-specific initialization, and topic subscriptions.
  /// 
  /// Platform-specific behavior:
  /// - Web: Stores FCM token in session storage using VAPID key for web push
  /// - Mobile (Android/iOS): Stores FCM token in secure storage and initializes
  ///   both push notifications and local notifications
  /// - Android: Automatically subscribes to "android" topic for targeted messaging
  /// - iOS: Automatically subscribes to "ios" topic for targeted messaging
  /// 
  /// Security considerations:
  /// - FCM tokens are stored securely using platform-appropriate storage mechanisms
  /// - VAPID key is used for web push notification authentication
  /// - Tokens are persisted to maintain consistent notification delivery
  /// 
  /// This method should be called early in the app lifecycle to ensure
  /// notification functionality is available throughout the user session.
  Future<void> initNotifications() async {
    // Request notification permissions from the user
    // This is required before any notifications can be displayed
    await _firebaseMessaging.requestPermission();

    // Generate FCM token for this device instance
    // The token uniquely identifies this app installation for push notifications
    // VAPID key is required for web push notifications
    final fCMToken = await _firebaseMessaging.getToken(
        vapidKey:
            vapidKey);

    print('token: $fCMToken');

    // Platform-specific token storage and initialization
    if (kIsWeb) {
      // Web platform: Store FCM token in session storage
      // Session storage is appropriate for web as it persists during the browser session
      final session = SessionStorage();
      session["fcm"] = fCMToken.toString();
      //await FirebaseMessaging.instance.subscribeToTopic("web");
      print("web notify initialised");
    } else {
      // Mobile platforms (Android/iOS): Use secure storage for FCM tokens
      print("saving to secure storage");
      // final box = GetStorage();
      // box.write('fcm', fCMToken.toString());

      // Store FCM token securely on the device
      await _storage.write(key: 'fcm', value: fCMToken.toString());
      String? fcmToken = await _storage.read(key: 'fcm');
      print("FCM Token: ${fcmToken}Saved Securely");

      // Initialize push and local notification systems for mobile platforms
      initPushNotifications();
      initLocalNotifications();
      print("non web notify initialised");
    }

    // Platform-specific topic subscriptions for targeted messaging
    // This allows the server to send notifications to specific platforms
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

  /// Displays a Flutter notification for incoming Firebase messages.
  /// 
  /// This method handles the presentation of Firebase Cloud Messaging notifications
  /// with platform-specific behavior. It processes incoming RemoteMessage objects
  /// and displays them using the appropriate notification system for each platform.
  /// 
  /// Platform-specific behavior:
  /// - Android: Displays notifications using the local notifications plugin with
  ///   the configured notification channel and custom icon
  /// - iOS: Uses the local notifications plugin with iOS-specific styling
  /// - Web: Shows toast notifications since web browsers handle push notifications
  ///   differently and don't support local notification plugin
  /// 
  /// The method extracts notification data from the RemoteMessage and presents
  /// it in a user-friendly format while maintaining consistency across platforms.
  /// 
  /// [message] The RemoteMessage received from Firebase Cloud Messaging containing
  /// notification data and metadata.
  void showFlutterNotification(RemoteMessage message) {
    print("Incoming message: $message");
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;

    // Handle mobile platforms (Android/iOS) with local notifications
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
    
    // Handle web platform with toast notifications
    // Web browsers have built-in push notification support, so we use toast for additional feedback
    if (notification != null && kIsWeb) {
      print("Notification detected!-> ${notification.title!}: ${notification.body!}");

      // Display a toast notification for web users
      // Toast provides immediate visual feedback without interfering with browser notifications
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

  /// Additional methods for foreground and background notification settings
  /// can be added here as needed for future enhancements.
  /// 
  /// Potential future functionality:
  /// - Custom notification actions and responses
  /// - Advanced topic management and subscription handling
  /// - Integration with app-specific notification preferences
  /// - Analytics and tracking for notification engagement
}

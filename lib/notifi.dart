/// # Notifi Library
/// 
/// A comprehensive Flutter library for managing notifications, authentication, and device capabilities.
/// This library provides a centralized system for handling Firebase Cloud Messaging (FCM),
/// user authentication, camera access, and cross-platform device management.
/// 
/// ## Features
/// - Firebase Cloud Messaging (FCM) integration
/// - Cross-platform notification support (iOS, Android, Web)
/// - Camera device management
/// - User authentication and session management
/// - Topic-based messaging system
/// - Local notification display
/// - Platform-specific behavior handling
/// 
/// ## Usage
/// ```dart
/// // Initialize the Notifi system
/// final notifi = Notifi(
///   ref: ref,
///   packageInfo: packageInfo,
///   deviceId: deviceId,
///   topics: ['general', 'updates'],
/// );
/// 
/// // Initialize notifications and camera
/// await notifi.init();
/// 
/// // Subscribe to topics
/// notifi.subscribeToTopics();
/// ```
library;

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

import 'package:notifi/models/person.dart' as Person;
import 'package:notifi/riverpod/fcm_notifier.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:logger/logger.dart' as logger;

import 'credentials.dart';
import 'firebase/firebase_api.dart';

/// Global logger instance with stack trace information for debugging.
/// Used for detailed error reporting and debugging information.
var log = logger.Logger(
  printer: logger.PrettyPrinter(),
  level: logger.Level.info,
);

/// Global logger instance without stack trace information.
/// Used for general information logging and cleaner output.
var logNoStack = logger.Logger(
  printer: logger.PrettyPrinter(methodCount: 0),
  level: logger.Level.info,
);

/// Returns true if the current platform is Android and not running on web.
bool get isAndroid => !kIsWeb && Platform.isAndroid;

/// Returns true if the current platform is iOS and not running on web.
bool get isIOS => !kIsWeb && Platform.isIOS;

/// Returns true if the current platform is Windows and not running on web.
bool get isWindows => !kIsWeb && Platform.isWindows;

/// Global FCM token storage for Firebase Cloud Messaging.
/// This token is used to identify the device for push notifications.
String? _fcmToken = '';

/// Getter for the current FCM token.
/// Returns null if no token has been generated yet.
String? get fcmToken => _fcmToken;

/// Android-specific notification channel for high-importance notifications.
/// This channel is used to display heads-up notifications on Android devices.
late AndroidNotificationChannel _androidChannel;

/// Flag to track whether Flutter Local Notifications has been initialized.
/// Prevents multiple initialization attempts.
bool isFlutterLocalNotificationsInitialized = false;

/// Flutter Local Notifications plugin instance.
/// Used to display local notifications across all platforms.
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

/// Background message handler for Firebase Cloud Messaging.
/// 
/// This function is called when a push notification is received while the app
/// is in the background or terminated. It must be a top-level function and
/// marked with @pragma('vm:entry-point') to be accessible from native code.
/// 
/// **Parameters:**
/// - `message`: The [RemoteMessage] containing notification data
/// 
/// **Note:** This function automatically initializes Firebase if needed
/// and logs the message ID for debugging purposes.
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  log.d("Handling a background message: ${message.messageId}");
}

/// Sets up Flutter Local Notifications for cross-platform notification display.
/// 
/// This function initializes the notification system with platform-specific
/// configurations. It creates an Android notification channel for high-importance
/// notifications and configures iOS foreground notification presentation.
/// 
/// **Features:**
/// - Creates Android notification channel with heads-up notifications
/// - Configures iOS foreground notification presentation (alert, badge, sound)
/// - Prevents duplicate initialization
/// - Enables cross-platform notification display
/// 
/// **Returns:** Future<void> that completes when setup is finished
/// 
/// **Example:**
/// ```dart
/// await setupFlutterNotifications();
/// ```
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

/// Main Notifi class that manages notifications, authentication, and device capabilities.
/// 
/// This class extends [ChangeNotifier] to provide reactive state management for
/// the notification system. It handles Firebase Cloud Messaging, user authentication,
/// camera access, and cross-platform device management.
/// 
/// **Key Features:**
/// - Firebase Cloud Messaging integration
/// - Topic-based messaging system
/// - User authentication management
/// - Camera device enumeration
/// - Cross-platform notification support
/// - Toast notification display
/// 
/// **Example Usage:**
/// ```dart
/// final notifi = Notifi(
///   ref: ref,
///   packageInfo: packageInfo,
///   deviceId: deviceId,
///   topics: ['general', 'updates'],
/// );
/// 
/// await notifi.init();
/// notifi.subscribeToTopics();
/// ```
class Notifi extends ChangeNotifier {
  /// Riverpod reference for state management integration.
  Ref ref;
  
  /// Duration in seconds for toast notifications display.
  int secondsToast = 2;
  
  /// List of FCM topics this device is subscribed to.
  final List<String> _topics = [];
  
  /// Current Firebase Cloud Messaging token.
  String _fcm = "Loading ...";
  
  /// Flag to prevent automatic login on app start.
  bool _preventAutoLogin = false;

  /// Package information for the current app.
  late PackageInfo _packageInfo;
  
  /// Unique device identifier.
  late String _deviceId;
  
  /// List of available camera devices on the current platform.
  List<CameraDescription> _cameras = <CameraDescription>[];

  /// Currently authenticated user.
  Person.Person? _user;
  
  /// Flag indicating if user data is ready for use.
  bool _userReady = false;

  /// Firebase configuration options for initialization.
  FirebaseOptions? options;

  /// Returns whether user data is ready for use.
  bool get userReady => _userReady;
  
  /// Sets the user ready state.
  set userReady(bool value) {
    _userReady = value;
  }

  /// Returns the unique device identifier.
  String? get deviceId => _deviceId;

  /// Returns the current app's package information.
  PackageInfo? get packageInfo => _packageInfo;
  
  /// Returns the current app version from package info.
  String get appVersion => _packageInfo.version;

  /// Returns the list of FCM topics this device is subscribed to.
  /// Topics are used for targeted messaging to groups of devices.
  List<String> get topics => _topics;

  /// Returns the current Firebase Cloud Messaging token.
  String get fcm => _fcm;
  
  /// Returns the list of available camera devices.
  List<CameraDescription> get cameras => _cameras;

  /// Returns this Notifi instance (self-reference for convenience).
  Notifi get notifi => this;

  /// Returns whether automatic login is prevented.
  bool get preventAutoLogin => _preventAutoLogin;

  /// Sets whether to prevent automatic login on app start.
  set preventAutoLogin(bool value) {
    _preventAutoLogin = value;
  }

  /// Returns the currently authenticated user.
  Person.Person? get currentUser => _user;

  /// Sets the current user and marks user data as ready.
  /// Notifies listeners when the user changes.
  set currentUser(Person.Person? user) {
    _user = user;
    _userReady = true;
    notifyListeners();
  }

  /// Sets the FCM token and notifies listeners of the change.
  /// This is called when a new FCM token is generated.
  set fcm(String newFcm) {
    _fcm = newFcm;
    notifyListeners();
  }

  /// Adds a new topic to the subscription list.
  /// 
  /// Topics are used for targeted messaging to groups of devices.
  /// After adding a topic, you should call [subscribeToTopics] to
  /// actually subscribe to it with Firebase.
  /// 
  /// **Parameters:**
  /// - `topic`: The topic name to add
  /// 
  /// **Example:**
  /// ```dart
  /// notifi.addTopic('news');
  /// notifi.subscribeToTopics();
  /// ```
  void addTopic(String topic) {
    _topics.add(topic);
    // This line tells [Model] that it should rebuild the widgets that
    // depend on it.
    notifyListeners();
  }

  /// Removes a topic from the subscription list.
  /// 
  /// This removes the topic from the local list but does not
  /// automatically unsubscribe from it with Firebase.
  /// 
  /// **Parameters:**
  /// - `topic`: The topic name to remove
  /// 
  /// **Example:**
  /// ```dart
  /// notifi.removeTopic('news');
  /// ```
  void removeTopic(String topic) {
    _topics.remove(topic);
    // This line tells [Model] that it should rebuild the widgets that
    // depend on it.
    notifyListeners();
  }

  /// Creates a new Notifi instance with the specified configuration.
  /// 
  /// This constructor initializes the notification system with platform-specific
  /// topics and device information. It automatically adds a platform-specific
  /// topic (android, ios, web, etc.) to enable targeted messaging.
  /// 
  /// **Parameters:**
  /// - `ref`: Riverpod reference for state management
  /// - `options`: Optional Firebase configuration options
  /// - `packageInfo`: App package information for version tracking
  /// - `deviceId`: Unique device identifier
  /// - `secondsToast`: Duration for toast notifications (default: 2 seconds)
  /// - `topics`: Optional list of initial topics to subscribe to
  /// 
  /// **Example:**
  /// ```dart
  /// final notifi = Notifi(
  ///   ref: ref,
  ///   packageInfo: packageInfo,
  ///   deviceId: 'device_123',
  ///   topics: ['news', 'updates'],
  /// );
  /// ```
  Notifi(
      { required this.ref,
      this.options,
      required PackageInfo packageInfo,
      required String deviceId,
      this.secondsToast = 2,
      List<String>? topics}) {
    logNoStack.i("notifi constructor");
    _packageInfo = packageInfo;
    _deviceId = deviceId;

    // Clear topics for web platform due to limitations
    if (kIsWeb) {
      topics = [];
    }
    // Add provided topics to the subscription list
    if (topics != null && topics.isNotEmpty) {
      _topics.addAll(topics);
    }
    // Add platform-specific topic for targeted messaging
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

  /// Initializes the Notifi system synchronously.
  /// 
  /// This method starts the initialization process and returns immediately,
  /// allowing the caller to continue while initialization happens in the background.
  /// 
  /// **Returns:** This [ChangeNotifier] instance for method chaining
  /// 
  /// **Example:**
  /// ```dart
  /// final notifi = Notifi(...).initialise();
  /// ```
  ChangeNotifier initialise() {
    log.i("Initialising Notifi");
    init();
    return this;
  }

  /// Initializes the Notifi system asynchronously.
  /// 
  /// This method sets up Firebase, notifications, camera access, and FCM token
  /// management. It handles platform-specific initialization and sets up
  /// message listeners for incoming notifications.
  /// 
  /// **Features initialized:**
  /// - Firebase Core and Cloud Messaging
  /// - Camera device enumeration (if enabled)
  /// - Notification permissions and channels
  /// - FCM token generation and refresh handling
  /// - Platform-specific notification setup
  /// - Message listeners for foreground and background notifications
  /// 
  /// **Returns:** Future<ChangeNotifier> that completes when initialization is done
  /// 
  /// **Example:**
  /// ```dart
  /// await notifi.init();
  /// ```
  Future<ChangeNotifier> init() async {
    logNoStack.i("Notifi initing!");

    if (enableNotifications) {
      await Firebase.initializeApp(options: options);
    }

    WidgetsFlutterBinding.ensureInitialized();

    logNoStack.i(
        "NOTIFI: Camera setting is ${enableCamera ? "ENABLED" : "DISABLED"}");
    if (enableCamera) {
      initialiseCamera();
    }

    //if (Constants.notificationsEnabled) {
    if (enableNotifications) {
      await Firebase.initializeApp(options: options);

      // Set the background messaging handler early on, as a named top-level function
      FirebaseMessaging.onBackgroundMessage(
          _firebaseMessagingBackgroundHandler);

      if (!kIsWeb) {
        // await setupFlutterNotifications();  <--- using the web example
        await FirebaseApi().initNotifications();
      } else {
        await setupFlutterNotifications();
      }
    }

///////////////////
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
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      logNoStack.i('NOTIFI: User granted provisional messaging permission');
    } else {
      logNoStack
          .i('NOTIFI: User declined or has not accepted messaging permission');
    }
    logNoStack
        .i('NOTIFI: User granted permission: ${settings.authorizationStatus}');

    FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) async {
      // TODO: If necessary send token to application server.

      // Note: This callback is fired at each app startup and whenever a new
      // token is generated.
      logNoStack.i("NOTIFI: Refresh Notifi FCM TOKEN = $fcmToken");
      fcmToken = fcmToken;
      fcm = fcmToken;
      notifyListeners();
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
        _fcmToken = token;
        fcm = token!;
        notifyListeners();
        ref.read(fcmNotifierProvider.notifier).setFcm(fcm);
      });
    }

    if (isIOS) {
      logNoStack.i("NOTIFI: Fetching Mobile Apple fcm token ");
      FirebaseMessaging.instance.getAPNSToken().then((apnsToken) {
        if (apnsToken != null) {
          // APNS token is available, make FCM plugin API requests...
          FirebaseMessaging.instance.getToken().then((token) {
            _fcmToken = token;
            fcm = token!;
            notifyListeners();
            logNoStack.i("NOTIFI: Mobile Apple fcm token is $_fcmToken");
            subscribeToTopics();
            ref.read(fcmNotifierProvider.notifier).setFcm(fcm);
          });
        }
      });
    }
    if (isAndroid) {
      FirebaseMessaging.instance.getToken().then((token) {
        _fcmToken = token;
        fcm = token!;
        notifyListeners();
        logNoStack.d("NOTIFI: Mobile Android fcm token is $_fcmToken");
        subscribeToTopics();
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

    return this;
  }

  /// Subscribes to all topics in the current topics list.
  /// 
  /// This method iterates through all topics and subscribes to them with
  /// Firebase Cloud Messaging. Topic subscriptions enable targeted messaging
  /// to groups of devices.
  /// 
  /// **Behavior:**
  /// - Only works if notifications are enabled
  /// - Skips subscription on web platform due to limitations
  /// - Logs successful subscriptions and errors
  /// - Handles exceptions gracefully
  /// 
  /// **Example:**
  /// ```dart
  /// notifi.addTopic('news');
  /// notifi.addTopic('updates');
  /// notifi.subscribeToTopics();
  /// ```
  void subscribeToTopics() {
    if (enableNotifications) {
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
  }

  /// Initializes camera access and enumerates available camera devices.
  /// 
  /// This method discovers all available camera devices on the current platform
  /// and stores them in the [_cameras] list. It handles camera-specific exceptions
  /// and logs any errors that occur during initialization.
  /// 
  /// **Behavior:**
  /// - Fetches all available camera devices
  /// - Handles [CameraException] gracefully
  /// - Logs errors with code and description
  /// - Updates the cameras list for UI consumption
  /// 
  /// **Example:**
  /// ```dart
  /// await notifi.initialiseCamera();
  /// final cameras = notifi.cameras; // Access available cameras
  /// ```
  void initialiseCamera() async {
    // Fetch the available cameras before initializing the app.
    try {
      _cameras = await availableCameras();
    } on CameraException catch (e) {
      logNoStack.e("${e.code} ${e..description}");
    }
  }
}

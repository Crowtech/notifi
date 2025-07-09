import 'dart:async';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../riverpod/fcm_notifier.dart';
import '../../riverpod/nest_notifis_provider.dart';
import '../../state/nest_auth2.dart';
// Logger functionality will be replaced with print statements
import 'notification_handler.dart';
import 'platform_helper.dart';
import 'topic_manager.dart';

part 'notification_service.g.dart';

/// Main notification service that handles Firebase messaging,
/// local notifications, and topic management.
@Riverpod(keepAlive: true)
class NotificationService extends _$NotificationService {
  static const String _channelId = 'high_importance_channel';
  static const String _channelName = 'High Importance Notifications';
  static const String _channelDescription = 'This channel is used for important notifications';
  
  late final FirebaseMessaging _messaging;
  late final FlutterLocalNotificationsPlugin _localNotifications;
  late final TopicManager _topicManager;
  late final NotificationHandler _notificationHandler;
  
  bool _isInitialized = false;

  @override
  Future<void> build() async {
    _messaging = FirebaseMessaging.instance;
    _localNotifications = FlutterLocalNotificationsPlugin();
    _topicManager = TopicManager(_messaging);
    _notificationHandler = NotificationHandler(
      localNotifications: _localNotifications,
      ref: ref,
    );
    
    await _initialize();
  }

  /// Initialize the notification service
  Future<void> _initialize() async {
    if (_isInitialized) {
      print('NotificationService already initialized');
      return;
    }

    try {
      // Initialize Firebase if not already done
      await _initializeFirebase();
      
      // Setup permissions
      await _requestPermissions();
      
      // Setup local notifications
      await _setupLocalNotifications();
      
      // Setup FCM
      await _setupFCM();
      
      // Setup message handlers
      _setupMessageHandlers();
      
      _isInitialized = true;
      print('NotificationService initialized successfully');
    } catch (e, stack) {
      print('Error initializing NotificationService: $e');
      print('Stack: $stack');
      rethrow;
    }
  }

  /// Initialize Firebase
  Future<void> _initializeFirebase() async {
    try {
      if (Firebase.apps.isEmpty) {
        await Firebase.initializeApp();
        print('Firebase initialized');
      } else {
        print('Firebase already initialized');
      }
    } catch (e) {
      print('Error initializing Firebase: $e');
      rethrow;
    }
  }

  /// Request notification permissions
  Future<void> _requestPermissions() async {
    if (PlatformHelper.isWeb) {
      await _messaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );
    } else if (Platform.isIOS || Platform.isAndroid) {
      await Permission.notification.request();
    }
  }

  /// Setup local notifications
  Future<void> _setupLocalNotifications() async {
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
    );
    
    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _localNotifications.initialize(
      initSettings,
      onDidReceiveNotificationResponse: _notificationHandler.handleNotificationTap,
    );

    // Create notification channel for Android
    if (Platform.isAndroid) {
      await _createNotificationChannel();
    }
  }

  /// Create Android notification channel
  Future<void> _createNotificationChannel() async {
    const channel = AndroidNotificationChannel(
      _channelId,
      _channelName,
      description: _channelDescription,
      importance: Importance.high,
      enableLights: true,
      enableVibration: true,
      playSound: true,
    );

    await _localNotifications
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  /// Setup FCM
  Future<void> _setupFCM() async {
    // Get and update FCM token
    final token = await _messaging.getToken();
    if (token != null) {
      await ref.read(fcmNotifierProvider.notifier).updateFcmToken(token);
      print('FCM Token: $token');
    }

    // Listen for token refresh
    _messaging.onTokenRefresh.listen((newToken) async {
      await ref.read(fcmNotifierProvider.notifier).updateFcmToken(newToken);
      print('FCM Token refreshed: $newToken');
    });
  }

  /// Setup message handlers
  void _setupMessageHandlers() {
    // Foreground messages
    FirebaseMessaging.onMessage.listen(_notificationHandler.handleForegroundMessage);
    
    // Background messages
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    
    // Message opened app
    FirebaseMessaging.onMessageOpenedApp.listen(_notificationHandler.handleMessageOpenedApp);
  }

  /// Subscribe to topics
  Future<void> subscribeToTopics(List<String> topics) async {
    await _topicManager.subscribeToTopics(topics);
  }

  /// Unsubscribe from topics
  Future<void> unsubscribeFromTopics(List<String> topics) async {
    await _topicManager.unsubscribeFromTopics(topics);
  }

  /// Get current topics
  List<String> get currentTopics => _topicManager.currentTopics;

  /// Show a local notification
  Future<void> showLocalNotification({
    required String title,
    required String body,
    String? payload,
  }) async {
    await _notificationHandler.showLocalNotification(
      title: title,
      body: body,
      payload: payload,
    );
  }

  /// Clear all notifications
  Future<void> clearAllNotifications() async {
    await _localNotifications.cancelAll();
  }

  /// Check if notifications are enabled
  Future<bool> areNotificationsEnabled() async {
    if (PlatformHelper.isWeb) {
      final permission = await _messaging.getNotificationSettings();
      return permission.authorizationStatus == AuthorizationStatus.authorized;
    } else {
      return await Permission.notification.isGranted;
    }
  }
}

/// Background message handler (must be top-level function)
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling background message: ${message.messageId}');
  
  // Handle the message
  // Note: We can't use Riverpod providers here as it's outside the app context
  // You might want to use shared preferences or other storage to handle background messages
}
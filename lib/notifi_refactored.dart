/// Notifi - Refactored notification and management library
/// 
/// This is the refactored version that consolidates notifi.dart and notifi2.dart
/// into a cleaner, more maintainable architecture using Riverpod.
library notifi;

// Core services
export 'core/notifications/notification_service.dart';
export 'core/notifications/platform_helper.dart';
export 'core/camera/camera_service.dart';

// Utils
export 'utils/logger.dart';

// Models - Export only the classes, not the logger variables
export 'models/person.dart' hide log, logNoStack, logger;
export 'models/organization.dart' hide log, logNoStack, logger;
export 'models/notification.dart';

// Providers - Export only the providers, not internal logger variables
export 'riverpod/fcm_notifier.dart' hide log, logNoStack;
export 'riverpod/nest_notifis_provider.dart' hide log, logNoStack;
export 'riverpod/notifications_data.dart';
export 'state/nest_auth2.dart' hide log, logNoStack;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'core/notifications/notification_service.dart';
import 'core/camera/camera_service.dart';
import 'riverpod/fcm_notifier.dart';
import 'state/nest_auth2.dart';
import 'utils/logger.dart';

/// Initialize the Notifi library
/// 
/// This function initializes all the core services required by the Notifi library.
/// It should be called once during app startup.
/// 
/// Example:
/// ```dart
/// void main() async {
///   WidgetsFlutterBinding.ensureInitialized();
///   
///   final container = ProviderContainer();
///   await initializeNotifi(container);
///   
///   runApp(
///     UncontrolledProviderScope(
///       container: container,
///       child: MyApp(),
///     ),
///   );
/// }
/// ```
Future<void> initializeNotifi(ProviderContainer container) async {
  try {
    logger.i('Initializing Notifi library...');
    
    // Initialize notification service
    final notificationService = await container.read(notificationServiceProvider.future);
    logger.d('Notification service initialized');
    
    // Initialize camera service if needed
    final cameraService = await container.read(cameraServiceProvider.future);
    logger.d('Camera service initialized');
    
    // Show FCM token in development mode
    if (await _isDevelopmentMode(container)) {
      await _showDevelopmentInfo(container);
    }
    
    logger.i('Notifi library initialized successfully');
  } catch (e, stack) {
    logger.e('Error initializing Notifi library', error: e, stackTrace: stack);
    rethrow;
  }
}

/// Check if app is in development mode
Future<bool> _isDevelopmentMode(ProviderContainer container) async {
  try {
    final authController = container.read(nestAuthProvider.notifier);
    final user = authController.currentUser;
    return user.email?.contains('@crowtech.com') ?? false;
  } catch (e) {
    return false;
  }
}

/// Show development information
Future<void> _showDevelopmentInfo(ProviderContainer container) async {
  try {
    // Get FCM token
    final token = container.read(fcmNotifierProvider);
    
    if (token != null) {
      // Show FCM token toast
      await Fluttertoast.showToast(
        msg: 'FCM Token: ${token.substring(0, 20)}...',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 8,
        backgroundColor: const Color(0xFF323232),
        textColor: const Color(0xFFFFFFFF),
        fontSize: 14.0,
      );
      
      logger.d('FCM Token (Dev Mode): $token');
    }
  } catch (e) {
    logger.e('Error showing development info', error: e);
  }
}

/// Quick access functions for common operations

/// Subscribe to FCM topics
Future<void> subscribeToTopics(
  ProviderContainer container,
  List<String> topics,
) async {
  // TODO: Fix void result error
  // final service = await container.read(notificationServiceProvider.future);
  // await service.subscribeToTopics(topics);
}

/// Unsubscribe from FCM topics
Future<void> unsubscribeFromTopics(
  ProviderContainer container,
  List<String> topics,
) async {
  // TODO: Fix void result error
  // final service = await container.read(notificationServiceProvider.future);
  // await service.unsubscribeFromTopics(topics);
}

/// Show a local notification
Future<void> showNotification(
  ProviderContainer container, {
  required String title,
  required String body,
  String? payload,
}) async {
  // TODO: Fix void result error
  // final service = await container.read(notificationServiceProvider.future);
  // await service.showLocalNotification(
  //   title: title,
  //   body: body,
  //   payload: payload,
  // );
}

/// Clear all notifications
Future<void> clearNotifications(ProviderContainer container) async {
  // TODO: Fix void result error
  // final service = await container.read(notificationServiceProvider.future);
  // await service.clearAllNotifications();
}

/// Check if notifications are enabled
Future<bool> areNotificationsEnabled(ProviderContainer container) async {
  // TODO: Fix void result error
  // final service = await container.read(notificationServiceProvider.future);
  // return await service.areNotificationsEnabled();
  return false; // placeholder
}
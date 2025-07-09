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

// Models
export 'models/person.dart';
export 'models/organization.dart';
export 'models/notification.dart';

// Providers
export 'riverpod/fcm_notifier.dart';
export 'riverpod/nest_notifis_provider.dart';
export 'riverpod/notifications_data.dart';
export 'state/nest_auth2.dart';

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
    await container.read(notificationServiceProvider.future);
    logger.d('Notification service initialized');
    
    // Initialize camera service if needed
    await container.read(cameraServiceProvider.future);
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
    final auth = container.read(nestAuthProvider);
    return auth != null && auth.user.email.contains('@crowtech.com');
  } catch (e) {
    return false;
  }
}

/// Show development information
Future<void> _showDevelopmentInfo(ProviderContainer container) async {
  try {
    // Get FCM token
    final fcmState = container.read(fcmNotifierProvider);
    final token = fcmState.when(
      data: (data) => data.fcmToken,
      loading: () => null,
      error: (_, __) => null,
    );
    
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
  final service = await container.read(notificationServiceProvider.future);
  await service.subscribeToTopics(topics);
}

/// Unsubscribe from FCM topics
Future<void> unsubscribeFromTopics(
  ProviderContainer container,
  List<String> topics,
) async {
  final service = await container.read(notificationServiceProvider.future);
  await service.unsubscribeFromTopics(topics);
}

/// Show a local notification
Future<void> showNotification(
  ProviderContainer container, {
  required String title,
  required String body,
  String? payload,
}) async {
  final service = await container.read(notificationServiceProvider.future);
  await service.showLocalNotification(
    title: title,
    body: body,
    payload: payload,
  );
}

/// Clear all notifications
Future<void> clearNotifications(ProviderContainer container) async {
  final service = await container.read(notificationServiceProvider.future);
  await service.clearAllNotifications();
}

/// Check if notifications are enabled
Future<bool> areNotificationsEnabled(ProviderContainer container) async {
  final service = await container.read(notificationServiceProvider.future);
  return await service.areNotificationsEnabled();
}
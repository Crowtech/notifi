import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

import '../../riverpod/nest_notifis_provider.dart';
import '../../riverpod/notifications_data.dart';
import '../../state/nest_auth2.dart';
// Logger functionality replaced with print statements
import 'platform_helper.dart';

/// Handles incoming notifications and notification interactions
class NotificationHandler {
  final FlutterLocalNotificationsPlugin localNotifications;
  final Ref ref;
  
  static const String _channelId = 'high_importance_channel';
  static const int _notificationId = 0;
  
  NotificationHandler({
    required this.localNotifications,
    required this.ref,
  });
  
  /// Handle foreground messages
  Future<void> handleForegroundMessage(RemoteMessage message) async {
    print('Handling foreground message: ${message.messageId}');
    
    try {
      // Update notifications data
      await _updateNotificationsData(message);
      
      // Show local notification if not on web
      if (!PlatformHelper.isWeb) {
        await _showNotification(message);
      }
      
      // Show toast for web or if specified
      if (PlatformHelper.isWeb || _shouldShowToast(message)) {
        await _showToast(message);
      }
      
      // Handle specific message types
      await _handleMessageType(message);
      
    } catch (e) {
      print('Error handling foreground message: $e');
    }
  }
  
  /// Handle message that opened the app
  Future<void> handleMessageOpenedApp(RemoteMessage message) async {
    print('Message opened app: ${message.messageId}');
    
    try {
      // Handle navigation based on message data
      await _handleMessageNavigation(message);
    } catch (e) {
      print('Error handling message opened app: $e');
    }
  }
  
  /// Handle notification tap
  Future<void> handleNotificationTap(NotificationResponse response) async {
    print('Notification tapped: ${response.payload}');
    
    try {
      if (response.payload != null) {
        final data = jsonDecode(response.payload!);
        await _handleNotificationAction(data);
      }
    } catch (e) {
      print('Error handling notification tap: $e');
    }
  }
  
  /// Show local notification
  Future<void> showLocalNotification({
    required String title,
    required String body,
    String? payload,
    String? imageUrl,
  }) async {
    try {
      // Android notification details
      final androidDetails = AndroidNotificationDetails(
        _channelId,
        'High Importance Notifications',
        channelDescription: 'This channel is used for important notifications',
        importance: Importance.high,
        priority: Priority.high,
        showWhen: true,
        enableLights: true,
        enableVibration: true,
        playSound: true,
        styleInformation: imageUrl != null
            ? BigPictureStyleInformation(
                FilePathAndroidBitmap(imageUrl),
                contentTitle: title,
                summaryText: body,
              )
            : BigTextStyleInformation(body),
      );
      
      // iOS notification details
      const iosDetails = DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      );
      
      // Platform-specific details
      final details = NotificationDetails(
        android: androidDetails,
        iOS: iosDetails,
      );
      
      // Show the notification
      await localNotifications.show(
        _notificationId,
        title,
        body,
        details,
        payload: payload,
      );
      
      print('Local notification shown: $title');
    } catch (e) {
      print('Error showing local notification: $e');
    }
  }
  
  /// Update notifications data provider
  Future<void> _updateNotificationsData(RemoteMessage message) async {
    try {
      // Check if message has nestCode
      final nestCode = message.data['nestCode'];
      if (nestCode != null) {
        // Invalidate the provider to refresh
        ref.invalidate(nestNotifisProvider);
      }
      
      // Update notification data if available
      final notificationData = message.data;
      if (notificationData.isNotEmpty) {
        ref.read(notificationsDataProvider(nestCode ?? 'default').notifier).update(notificationData);
      }
    } catch (e) {
      print('Error updating notifications data: $e');
    }
  }
  
  /// Show notification from RemoteMessage
  Future<void> _showNotification(RemoteMessage message) async {
    final notification = message.notification;
    
    if (notification != null) {
      await showLocalNotification(
        title: notification.title ?? 'New Notification',
        body: notification.body ?? '',
        payload: jsonEncode(message.data),
        imageUrl: _getImageUrl(notification, message.data),
      );
    } else if (message.data.isNotEmpty) {
      // Handle data-only messages
      await showLocalNotification(
        title: message.data['title'] ?? 'New Notification',
        body: message.data['body'] ?? message.data['message'] ?? '',
        payload: jsonEncode(message.data),
      );
    }
  }
  
  /// Show toast notification
  Future<void> _showToast(RemoteMessage message) async {
    final notification = message.notification;
    String toastMessage = '';
    
    if (notification != null) {
      toastMessage = '${notification.title ?? 'Notification'}: ${notification.body ?? ''}';
    } else if (message.data.isNotEmpty) {
      toastMessage = message.data['message'] ?? 
                     message.data['body'] ?? 
                     'New notification received';
    }
    
    if (toastMessage.isNotEmpty) {
      await Fluttertoast.showToast(
        msg: toastMessage,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 4,
        backgroundColor: const Color(0xFF323232),
        textColor: const Color(0xFFFFFFFF),
        fontSize: 16.0,
      );
    }
  }
  
  /// Handle specific message types
  Future<void> _handleMessageType(RemoteMessage message) async {
    final messageType = message.data['type'] ?? message.data['category'];
    
    switch (messageType) {
      case 'nest_notification':
        await _handleNestNotification(message);
        break;
      case 'system_update':
        await _handleSystemUpdate(message);
        break;
      case 'emergency':
        await _handleEmergencyNotification(message);
        break;
      default:
        print('Unhandled message type: $messageType');
    }
  }
  
  /// Handle navigation based on message data
  Future<void> _handleMessageNavigation(RemoteMessage message) async {
    final route = message.data['route'] ?? message.data['screen'];
    
    if (route != null) {
      print('Navigating to route: $route');
      // TODO: Implement navigation using your routing solution
      // Example: ref.read(routerProvider).go(route);
    }
  }
  
  /// Handle notification action
  Future<void> _handleNotificationAction(Map<String, dynamic> data) async {
    final action = data['action'];
    
    switch (action) {
      case 'open_detail':
        final id = data['id'];
        if (id != null) {
          // TODO: Navigate to detail screen
          print('Opening detail for id: $id');
        }
        break;
      case 'mark_read':
        final notificationId = data['notification_id'];
        if (notificationId != null) {
          // Update notification data to mark as read
          ref.read(notificationsDataProvider(notificationId).notifier).update({
            'read': true,
            'notification_id': notificationId,
          });
        }
        break;
      default:
        print('Unhandled notification action: $action');
    }
  }
  
  /// Handle nest notification
  Future<void> _handleNestNotification(RemoteMessage message) async {
    print('Handling nest notification');
    
    // Refresh nest notifications
    ref.invalidate(nestNotifisProvider);
    
    // Check if user needs to re-authenticate
    try {
      final authController = ref.read(nestAuthProvider.notifier);
      if (authController.currentUser.email?.isEmpty ?? true) {
        print('User not authenticated for nest notification');
      }
    } catch (e) {
      print('Error checking authentication: $e');
    }
  }
  
  /// Handle system update notification
  Future<void> _handleSystemUpdate(RemoteMessage message) async {
    print('Handling system update notification');
    
    final updateType = message.data['update_type'];
    if (updateType == 'force_update') {
      // TODO: Show force update dialog
      print('Force update required');
    }
  }
  
  /// Handle emergency notification
  Future<void> _handleEmergencyNotification(RemoteMessage message) async {
    print('Handling emergency notification');
    
    // Emergency notifications should be shown with highest priority
    await showLocalNotification(
      title: '🚨 ${message.notification?.title ?? 'Emergency Alert'}',
      body: message.notification?.body ?? message.data['message'] ?? '',
      payload: jsonEncode(message.data),
    );
    
    // TODO: Trigger emergency alert UI
  }
  
  /// Determine if toast should be shown
  bool _shouldShowToast(RemoteMessage message) {
    // Show toast for specific message types
    final showToast = message.data['show_toast'];
    if (showToast != null) {
      return showToast == 'true' || showToast == true;
    }
    
    // Show toast for high priority messages
    final priority = message.data['priority'];
    return priority == 'high' || priority == 'urgent';
  }
  
  /// Get image URL from notification
  String? _getImageUrl(RemoteNotification notification, Map<String, dynamic> data) {
    // Check Android specific image
    if (Platform.isAndroid && notification.android?.imageUrl != null) {
      return notification.android!.imageUrl;
    }
    
    // Check iOS specific image
    if (Platform.isIOS && notification.apple?.imageUrl != null) {
      return notification.apple!.imageUrl;
    }
    
    // Check data for image URL
    return data['image_url'] ?? data['image'] ?? data['picture'];
  }
}
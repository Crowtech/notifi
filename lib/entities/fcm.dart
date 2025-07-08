import 'package:firebase_core/firebase_core.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'fcm.freezed.dart';

/// **Firebase Cloud Messaging Configuration Entity**
/// 
/// Represents the configuration and state of Firebase Cloud Messaging (FCM)
/// for push notifications in the Notifi application. This domain entity
/// encapsulates all FCM-related settings and credentials needed for
/// push notification functionality.
/// 
/// The entity follows a union type pattern using Freezed, providing two
/// distinct states: active (configured and ready) and inactive (not configured).
/// This design ensures type safety and prevents operations on unconfigured FCM.
/// 
/// **Business Rules:**
/// - FCM can only be in one state at a time (active or inactive)
/// - When active, Firebase configuration must be properly initialized
/// - Topics represent notification categories users can subscribe to
/// - Token is required for device-specific notifications
/// - VAPID key is needed for web push notifications
/// 
/// **Domain Concepts:**
/// - **Active State**: FCM is configured and ready for push notifications
/// - **Inactive State**: FCM is not configured or disabled
/// - **Topics**: Notification categories for targeted messaging
/// - **VAPID Key**: Voluntary Application Server Identification for web push
/// - **Token**: Device-specific identifier for push notifications
/// 
/// **Usage:**
/// ```dart
/// // Creating an active FCM configuration
/// final fcm = Fcm.active(
///   firebaseOptions: FirebaseOptions(...),
///   vapidKey: 'web_push_vapid_key',
///   secondsToast: 5,
///   topics: ['news', 'alerts', 'updates'],
///   token: 'device_fcm_token'
/// );
/// 
/// // Creating an inactive state
/// final fcm = Fcm.inactive();
/// ```
@freezed
sealed class Fcm with _$Fcm {
  /// **Active FCM Configuration State**
  /// 
  /// Represents a fully configured Firebase Cloud Messaging setup that is
  /// ready to send and receive push notifications. This state contains all
  /// necessary configuration parameters and credentials.
  /// 
  /// **Properties:**
  /// - [firebaseOptions]: Platform-specific Firebase configuration
  /// - [vapidKey]: Web push VAPID key for browser notifications
  /// - [secondsToast]: Duration to display toast notifications
  /// - [topics]: List of notification topics the user is subscribed to
  /// - [token]: Device-specific FCM token for targeted notifications
  /// 
  /// **Business Rules:**
  /// - Firebase options may be null for certain platforms
  /// - VAPID key is required for web push notifications
  /// - Toast duration should be reasonable (typically 3-10 seconds)
  /// - Topics list should not be empty when active
  /// - Token must be valid and not expired
  const factory Fcm.active({
    /// Platform-specific Firebase configuration options
    /// 
    /// Contains the Firebase project configuration including:
    /// - API keys and project identifiers
    /// - Platform-specific settings (iOS, Android, Web)
    /// - Authentication and messaging configurations
    /// 
    /// **Note:** May be null for platforms where Firebase is not available
    /// or when using alternative push notification services.
    required FirebaseOptions? firebaseOptions,
    
    /// VAPID key for web push notifications
    /// 
    /// Voluntary Application Server Identification (VAPID) key used for
    /// web push notifications. This key identifies the application server
    /// to the push service and is required for web-based notifications.
    /// 
    /// **Note:** Required for web platforms, may be null for mobile-only apps.
    required String? vapidKey,
    
    /// Duration in seconds for toast notification display
    /// 
    /// Controls how long toast notifications remain visible to the user.
    /// This affects user experience and notification visibility.
    /// 
    /// **Recommended values:**
    /// - 3-5 seconds for informational messages
    /// - 5-10 seconds for important alerts
    /// - Consider accessibility requirements for longer durations
    required int secondsToast,
    
    /// List of notification topics the user is subscribed to
    /// 
    /// Topics allow for targeted messaging to specific user groups or
    /// interests. Users can subscribe to multiple topics to receive
    /// relevant notifications.
    /// 
    /// **Examples:**
    /// - ['news', 'alerts', 'updates'] for general app notifications
    /// - ['sports', 'weather', 'breaking'] for news app categories
    /// - ['team-alpha', 'project-beta'] for organization-specific topics
    /// 
    /// **Business Rules:**
    /// - Topic names should follow Firebase naming conventions
    /// - Users should be able to subscribe/unsubscribe from topics
    /// - Empty list indicates no topic subscriptions
    required List<String> topics,
    
    /// Device-specific FCM registration token
    /// 
    /// Unique identifier for this device/app instance, used for sending
    /// targeted push notifications. This token is generated by Firebase
    /// and may change periodically.
    /// 
    /// **Important:**
    /// - Token should be refreshed when it changes
    /// - Token is required for device-specific notifications
    /// - Token should be sent to your notification service backend
    required String token,
  }) = Active;
  
  /// Private constructor for Freezed code generation
  /// 
  /// This enables the generated code to create instances with custom methods
  /// while maintaining immutability and the union type pattern.
  const Fcm._();
  
  /// **Inactive FCM State**
  /// 
  /// Represents a state where Firebase Cloud Messaging is not configured
  /// or has been disabled. In this state, the application cannot send or
  /// receive push notifications.
  /// 
  /// **Use Cases:**
  /// - Initial application state before FCM setup
  /// - When user has disabled notifications
  /// - When FCM configuration fails
  /// - During testing or development without FCM
  /// 
  /// **Business Rules:**
  /// - No push notifications can be sent or received
  /// - User should be notified about disabled notification features
  /// - The app should gracefully handle the lack of push notifications
  const factory Fcm.inactive() = Inactive;
  
  /// **FCM Activation Status Checker**
  /// 
  /// Convenience getter that returns true if FCM is active and configured,
  /// false otherwise. This provides a simple way to check if push
  /// notifications are available without pattern matching.
  /// 
  /// **Returns:**
  /// - `true` when FCM is in [Active] state with proper configuration
  /// - `false` when FCM is in [Inactive] state
  /// 
  /// **Usage:**
  /// ```dart
  /// if (fcm.isFcm) {
  ///   // FCM is active, can send push notifications
  ///   await sendPushNotification(message);
  /// } else {
  ///   // FCM is inactive, use alternative notification methods
  ///   showInAppNotification(message);
  /// }
  /// ```
  bool get isFcm => switch (this) {
        Active() => true,
        Inactive() => false,
      };
}

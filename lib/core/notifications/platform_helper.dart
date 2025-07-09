import 'dart:io';
import 'package:flutter/foundation.dart';

/// Helper class for platform-specific operations
class PlatformHelper {
  /// Check if running on web
  static bool get isWeb => kIsWeb;
  
  /// Check if running on iOS
  static bool get isIOS => !kIsWeb && Platform.isIOS;
  
  /// Check if running on Android
  static bool get isAndroid => !kIsWeb && Platform.isAndroid;
  
  /// Check if running on macOS
  static bool get isMacOS => !kIsWeb && Platform.isMacOS;
  
  /// Check if running on Windows
  static bool get isWindows => !kIsWeb && Platform.isWindows;
  
  /// Check if running on Linux
  static bool get isLinux => !kIsWeb && Platform.isLinux;
  
  /// Check if running on mobile (iOS or Android)
  static bool get isMobile => isIOS || isAndroid;
  
  /// Check if running on desktop (macOS, Windows, or Linux)
  static bool get isDesktop => isMacOS || isWindows || isLinux;
  
  /// Get platform name as string
  static String get platformName {
    if (isWeb) return 'Web';
    if (isIOS) return 'iOS';
    if (isAndroid) return 'Android';
    if (isMacOS) return 'macOS';
    if (isWindows) return 'Windows';
    if (isLinux) return 'Linux';
    return 'Unknown';
  }
  
  /// Check if platform supports local notifications
  static bool get supportsLocalNotifications => isMobile || isDesktop;
  
  /// Check if platform supports push notifications
  static bool get supportsPushNotifications => isWeb || isMobile;
  
  /// Check if platform requires notification permissions
  static bool get requiresNotificationPermissions => isIOS || isWeb;
  
  /// Get device type for analytics
  static String get deviceType {
    if (isWeb) return 'web';
    if (isMobile) return 'mobile';
    if (isDesktop) return 'desktop';
    return 'unknown';
  }
}
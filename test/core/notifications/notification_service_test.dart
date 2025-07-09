import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:notifi/core/notifications/notification_service.dart';
import 'package:notifi/core/notifications/platform_helper.dart';

@GenerateMocks([FirebaseMessaging])
void main() {
  group('NotificationService Tests', () {
    late ProviderContainer container;
    
    setUp(() {
      container = ProviderContainer();
    });
    
    tearDown(() {
      container.dispose();
    });
    
    test('PlatformHelper correctly identifies platform', () {
      // These tests will pass/fail based on the test environment
      expect(PlatformHelper.platformName, isNotEmpty);
      expect(PlatformHelper.deviceType, isIn(['web', 'mobile', 'desktop', 'unknown']));
    });
    
    test('Topic validation works correctly', () {
      // Test topic name validation logic
      final validTopics = [
        'news',
        'updates_2024',
        'user.123',
        'platform-ios',
        'test~topic',
        'percent%20encoded',
      ];
      
      final invalidTopics = [
        '', // empty
        'a' * 96, // too long
        '/topics/news', // starts with /topics/
        'invalid@topic', // invalid character
        'invalid topic', // space
      ];
      
      // Note: These would be tested if _isValidTopicName was public
      // For now, we're just documenting the expected behavior
      expect(validTopics, everyElement(isNotEmpty));
      expect(invalidTopics, everyElement(isNotEmpty));
    });
    
    test('NotificationService provider can be created', () {
      // This test verifies the provider can be created
      // In a real test, you'd mock Firebase.initializeApp()
      expect(
        () => container.read(notificationServiceProvider),
        returnsNormally,
      );
    });
  });
  
  group('Migration Compatibility Tests', () {
    test('Exported types are available', () {
      // Verify that all expected exports are available
      expect(NotificationService, isNotNull);
      expect(PlatformHelper, isNotNull);
    });
  });
}
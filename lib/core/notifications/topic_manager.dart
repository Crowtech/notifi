import 'package:firebase_messaging/firebase_messaging.dart';
// Logger functionality replaced with print statements
import 'platform_helper.dart';

/// Manages FCM topic subscriptions
class TopicManager {
  final FirebaseMessaging _messaging;
  final Set<String> _subscribedTopics = {};
  
  TopicManager(this._messaging);
  
  /// Get currently subscribed topics
  List<String> get currentTopics => _subscribedTopics.toList();
  
  /// Subscribe to multiple topics
  Future<void> subscribeToTopics(List<String> topics) async {
    if (topics.isEmpty) return;
    
    // Filter out already subscribed topics
    final topicsToSubscribe = topics.where((topic) => !_subscribedTopics.contains(topic)).toList();
    
    if (topicsToSubscribe.isEmpty) {
      print('Already subscribed to all requested topics');
      return;
    }
    
    print('Subscribing to topics: $topicsToSubscribe');
    
    // Subscribe to each topic
    final futures = <Future>[];
    for (final topic in topicsToSubscribe) {
      futures.add(_subscribeToTopic(topic));
    }
    
    // Wait for all subscriptions to complete
    final results = await Future.wait(futures, eagerError: false);
    
    // Check for any failures
    final failures = results.where((result) => result == false).length;
    if (failures > 0) {
      print('Failed to subscribe to $failures topics');
    }
  }
  
  /// Subscribe to a single topic
  Future<bool> _subscribeToTopic(String topic) async {
    try {
      // Validate topic name
      if (!_isValidTopicName(topic)) {
        print('Invalid topic name: $topic');
        return false;
      }
      
      await _messaging.subscribeToTopic(topic);
      _subscribedTopics.add(topic);
      print('Subscribed to topic: $topic');
      return true;
    } catch (e) {
      print('Error subscribing to topic $topic: $e');
      return false;
    }
  }
  
  /// Unsubscribe from multiple topics
  Future<void> unsubscribeFromTopics(List<String> topics) async {
    if (topics.isEmpty) return;
    
    // Filter out topics we're not subscribed to
    final topicsToUnsubscribe = topics.where((topic) => _subscribedTopics.contains(topic)).toList();
    
    if (topicsToUnsubscribe.isEmpty) {
      print('Not subscribed to any of the requested topics');
      return;
    }
    
    print('Unsubscribing from topics: $topicsToUnsubscribe');
    
    // Unsubscribe from each topic
    final futures = <Future>[];
    for (final topic in topicsToUnsubscribe) {
      futures.add(_unsubscribeFromTopic(topic));
    }
    
    // Wait for all unsubscriptions to complete
    final results = await Future.wait(futures, eagerError: false);
    
    // Check for any failures
    final failures = results.where((result) => result == false).length;
    if (failures > 0) {
      print('Failed to unsubscribe from $failures topics');
    }
  }
  
  /// Unsubscribe from a single topic
  Future<bool> _unsubscribeFromTopic(String topic) async {
    try {
      await _messaging.unsubscribeFromTopic(topic);
      _subscribedTopics.remove(topic);
      print('Unsubscribed from topic: $topic');
      return true;
    } catch (e) {
      print('Error unsubscribing from topic $topic: $e');
      return false;
    }
  }
  
  /// Clear all topic subscriptions
  Future<void> clearAllTopics() async {
    if (_subscribedTopics.isEmpty) return;
    
    print('Clearing all topic subscriptions');
    await unsubscribeFromTopics(_subscribedTopics.toList());
  }
  
  /// Add platform-specific default topics
  Future<void> addPlatformTopics() async {
    final platformTopics = <String>[];
    
    // Add platform-specific topic
    final platformTopic = 'platform_${PlatformHelper.platformName.toLowerCase()}';
    platformTopics.add(platformTopic);
    
    // Add device type topic
    final deviceTopic = 'device_${PlatformHelper.deviceType}';
    platformTopics.add(deviceTopic);
    
    // Add 'all' topic for broadcast messages
    platformTopics.add('all');
    
    await subscribeToTopics(platformTopics);
  }
  
  /// Validate topic name according to FCM rules
  bool _isValidTopicName(String topic) {
    // FCM topic rules:
    // - Must match regex: [a-zA-Z0-9-_.~%]+
    // - Cannot be longer than 95 characters
    // - Cannot start with /topics/
    
    if (topic.isEmpty || topic.length > 95) {
      return false;
    }
    
    if (topic.startsWith('/topics/')) {
      return false;
    }
    
    // Check for valid characters
    final validPattern = RegExp(r'^[a-zA-Z0-9\-_.~%]+$');
    return validPattern.hasMatch(topic);
  }
  
  /// Get topic statistics
  Map<String, dynamic> getStatistics() {
    return {
      'total_topics': _subscribedTopics.length,
      'topics': _subscribedTopics.toList(),
      'platform': PlatformHelper.platformName,
      'device_type': PlatformHelper.deviceType,
    };
  }
}
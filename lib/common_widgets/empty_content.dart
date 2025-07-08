/// A widget for displaying empty state content with customizable messaging.
/// 
/// This widget provides a consistent way to display empty states throughout
/// the application. It's commonly used when lists are empty, search results
/// return no matches, or when content is not yet available.
/// 
/// The widget displays a centered title and message with subtle styling
/// to indicate the empty state without being intrusive. It helps guide users
/// on what to do next or explains why content is not available.
/// 
/// Example usage:
/// ```dart
/// EmptyContent(
///   title: 'No notifications',
///   message: 'You\'ll see your notifications here when you receive them',
/// )
/// ```

import 'package:flutter/material.dart';

/// A widget that displays a consistent empty state with title and message.
/// 
/// This widget provides a standardized way to show empty states across the
/// application, helping users understand when content is not available and
/// potentially guiding them on next steps.
class EmptyContent extends StatelessWidget {
  /// Creates an [EmptyContent] widget with customizable title and message.
  /// 
  /// The [title] and [message] parameters have default values that provide
  /// generic empty state messaging, but can be customized for specific contexts.
  const EmptyContent({
    super.key,
    this.title = 'Nothing here',
    this.message = 'Add a new item to get started',
  });
  
  /// The main title text displayed in the empty state.
  /// 
  /// This should be a concise statement that clearly indicates the empty
  /// state, such as 'No items found' or 'No notifications'.
  final String title;
  
  /// The descriptive message displayed below the title.
  /// 
  /// This message should provide context about why the content is empty
  /// and potentially guide the user on what they can do next.
  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            title,
            // Large, prominent title with subtle color to indicate empty state
            style: const TextStyle(fontSize: 32.0, color: Colors.black54),
          ),
          Text(
            message,
            // Smaller, descriptive text with matching subtle color
            style: const TextStyle(fontSize: 16.0, color: Colors.black54),
          ),
        ],
      ),
    );
  }
}

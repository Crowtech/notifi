/// A versatile list builder widget that handles async data and empty states.
/// 
/// This widget provides a comprehensive solution for displaying lists of items
/// with proper handling of loading states, errors, and empty content. It's
/// designed to work seamlessly with Riverpod's AsyncValue pattern, making it
/// easy to display data from async providers.
/// 
/// The widget automatically handles common list scenarios:
/// - Loading state with a progress indicator
/// - Error state with user-friendly error messaging
/// - Empty state with appropriate empty content
/// - Populated state with properly formatted list items
/// 
/// The list includes subtle dividers between items and padding at the top
/// and bottom for better visual presentation.
/// 
/// Example usage:
/// ```dart
/// ListItemsBuilder<User>(
///   data: ref.watch(usersProvider),
///   itemBuilder: (context, user) => UserListTile(user),
/// )
/// ```

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'empty_content.dart';

/// Type definition for a function that builds widgets for individual list items.
/// 
/// This function receives the build context and the item data, and should
/// return a widget that represents that item in the list.
typedef ItemWidgetBuilder<T> = Widget Function(BuildContext context, T item);

/// A comprehensive list builder that handles async data with proper state management.
/// 
/// This widget provides a complete solution for displaying lists with loading,
/// error, and empty states, making it ideal for use with async data sources.
class ListItemsBuilder<T> extends StatelessWidget {
  /// Creates a [ListItemsBuilder] with the specified data and item builder.
  /// 
  /// The [data] parameter should be an AsyncValue containing the list data.
  /// The [itemBuilder] parameter is a function that builds widgets for each item.
  const ListItemsBuilder({
    super.key,
    required this.data,
    required this.itemBuilder,
  });
  
  /// The async data containing the list of items to display.
  /// 
  /// This should be an AsyncValue<List<T>> that represents the current
  /// state of the data (loading, error, or loaded with data).
  final AsyncValue<List<T>> data;
  
  /// Function that builds the widget for each list item.
  /// 
  /// This function receives the build context and the item data,
  /// and should return a widget that represents that item in the list.
  final ItemWidgetBuilder<T> itemBuilder;

  @override
  Widget build(BuildContext context) {
    return data.when(
      // Success state: build list if items exist, otherwise show empty content
      data: (items) => items.isNotEmpty
          ? ListView.separated(
              // Add 2 to item count for top and bottom padding items
              itemCount: items.length + 2,
              // Subtle dividers between items for visual separation
              separatorBuilder: (context, index) => const Divider(height: 0.5),
              itemBuilder: (context, index) {
                // First and last items are empty for padding/spacing
                if (index == 0 || index == items.length + 1) {
                  return const SizedBox.shrink();
                }
                // Build actual list item (adjust index by -1 for padding offset)
                return itemBuilder(context, items[index - 1]);
              },
            )
          : const EmptyContent(),
      // Loading state: show centered loading indicator
      loading: () => const Center(child: CircularProgressIndicator()),
      // Error state: show user-friendly error message
      error: (_, __) => const EmptyContent(
        title: 'Something went wrong',
        message: 'Can\'t load items right now',
      ),
    );
  }
}

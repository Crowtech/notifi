/// Widgets for handling asynchronous state in the application.
/// 
/// This file contains utilities for rendering different states of asynchronous
/// operations (loading, error, success) in a consistent manner throughout the app.
/// These widgets are essential for providing proper user feedback during data
/// fetching operations and maintaining a responsive user interface.
/// 
/// The widgets handle the common pattern of showing loading indicators,
/// error messages, and success content based on the state of async operations.
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'error_message_widget.dart';

/// A generic widget that renders different UI states for asynchronous operations.
/// 
/// This widget provides a consistent way to handle the three main states of
/// async operations: loading, error, and success. It's designed to work with
/// Riverpod's [AsyncValue] type, which encapsulates these states.
/// 
/// The widget automatically displays:
/// - A loading indicator when data is being fetched
/// - An error message when an error occurs
/// - The success content when data is available
/// 
/// Example usage:
/// ```dart
/// AsyncValueWidget<List<User>>(
///   value: ref.watch(usersProvider),
///   data: (users) => ListView.builder(
///     itemCount: users.length,
///     itemBuilder: (context, index) => UserTile(users[index]),
///   ),
/// )
/// ```
class AsyncValueWidget<T> extends StatelessWidget {
  /// Creates an [AsyncValueWidget] with the specified async value and data builder.
  /// 
  /// The [value] parameter contains the async state to be rendered.
  /// The [data] parameter is a function that builds the widget for the success state.
  const AsyncValueWidget({super.key, required this.value, required this.data});
  
  /// The asynchronous value containing the current state (loading, error, or data).
  /// 
  /// This is typically obtained from a Riverpod provider that performs
  /// asynchronous operations like API calls or database queries.
  final AsyncValue<T> value;
  
  /// Function that builds the widget to display when data is successfully loaded.
  /// 
  /// This function receives the loaded data of type [T] and should return
  /// the widget that represents the success state of the operation.
  final Widget Function(T) data;

  @override
  Widget build(BuildContext context) {
    return value.when(
      // Success state: render the data using the provided builder function
      data: data,
      // Error state: show centered error message with details
      error: (e, st) => Center(child: ErrorMessageWidget(e.toString())),
      // Loading state: show centered loading indicator
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}

/// A specialized async value widget that wraps content in a Scaffold.
/// 
/// This widget is similar to [AsyncValueWidget] but provides a full scaffold
/// structure with an app bar. It's particularly useful for full-screen views
/// that need to display async content while maintaining consistent navigation
/// and layout structure.
/// 
/// The widget ensures that loading and error states are properly displayed
/// within a scaffold context, providing a better user experience for
/// full-screen async operations.
/// 
/// Example usage:
/// ```dart
/// ScaffoldAsyncValueWidget<UserProfile>(
///   value: ref.watch(userProfileProvider),
///   data: (profile) => UserProfileView(profile),
/// )
/// ```
class ScaffoldAsyncValueWidget<T> extends StatelessWidget {
  /// Creates a [ScaffoldAsyncValueWidget] with the specified async value and data builder.
  /// 
  /// The [value] parameter contains the async state to be rendered.
  /// The [data] parameter is a function that builds the widget for the success state.
  const ScaffoldAsyncValueWidget(
      {super.key, required this.value, required this.data});
  
  /// The asynchronous value containing the current state (loading, error, or data).
  /// 
  /// This is typically obtained from a Riverpod provider that performs
  /// asynchronous operations like API calls or database queries.
  final AsyncValue<T> value;
  
  /// Function that builds the widget to display when data is successfully loaded.
  /// 
  /// This function receives the loaded data of type [T] and should return
  /// the widget that represents the success state of the operation.
  final Widget Function(T) data;

  @override
  Widget build(BuildContext context) {
    return value.when(
      // Success state: render the data using the provided builder function
      data: data,
      // Error state: show scaffold with app bar and centered error message
      error: (e, st) => Scaffold(
        appBar: AppBar(),
        body: Center(child: ErrorMessageWidget(e.toString())),
      ),
      // Loading state: show scaffold with app bar and centered loading indicator
      loading: () => Scaffold(
        appBar: AppBar(),
        body: const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}

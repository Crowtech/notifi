/// A comprehensive placeholder widget for empty states with navigation options.
/// 
/// This widget provides a more sophisticated empty state experience compared to
/// [EmptyContent]. It includes navigation functionality that intelligently
/// routes users to either the home screen or login screen based on their
/// authentication status.
/// 
/// The widget is particularly useful for error states, 404 pages, or situations
/// where users need to be redirected to a meaningful part of the application.
/// It provides both informative messaging and a clear call-to-action to help
/// users recover from the empty state.
/// 
/// Example usage:
/// ```dart
/// EmptyPlaceholderWidget(
///   message: 'Page not found',
///   homeRoute: '/dashboard',
///   loginRoute: '/signin',
/// )
/// ```

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../constants/app_sizes.dart';
import '../state/nest_auth2.dart';
import 'primary_button.dart';

/// A sophisticated placeholder widget that provides contextual navigation
/// based on user authentication status.
/// 
/// This widget displays a message and includes a call-to-action button that
/// intelligently routes users to either the home or login screen depending
/// on their current authentication state.
class EmptyPlaceholderWidget extends ConsumerWidget {
  /// Creates an [EmptyPlaceholderWidget] with customizable message and routes.
  /// 
  /// The [message] parameter is required and describes the empty state.
  /// The [homeRoute] and [loginRoute] parameters specify where authenticated
  /// and unauthenticated users should be directed, respectively.
  const EmptyPlaceholderWidget({
    super.key, 
    this.homeRoute = '/home',
    this.loginRoute = '/login',
    required this.message,
  }); 
  
  /// The message displayed to explain the empty state.
  /// 
  /// This should be a clear, user-friendly explanation of why the content
  /// is not available and what the user can do about it.
  final String message;
  
  /// The route to navigate to for authenticated users.
  /// 
  /// This should be a meaningful destination within the app where
  /// authenticated users can continue their workflow.
  final String homeRoute;
  
  /// The route to navigate to for unauthenticated users.
  /// 
  /// This should be the login or authentication screen where users
  /// can sign in to access the application.
  final String loginRoute;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(Sizes.p16),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              message,
              // Use prominent headline style to draw attention to the message
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            // Standard spacing between message and action button
            gapH32,
            PrimaryButton(
              onPressed: () {
                // Check authentication status to determine appropriate route
                final isLoggedIn = ref.read(nestAuthProvider);
                
                // Navigate to home if authenticated, login if not
                // This provides contextual navigation based on user state
                context.goNamed(
                    isLoggedIn ? homeRoute : loginRoute);
              },
              text: 'Go Home',
            )
          ],
        ),
      ),
    );
  }
}

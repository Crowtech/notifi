/// A primary button widget that serves as the main call-to-action element.
/// 
/// This widget provides a consistent, prominent button style throughout the
/// application. It's designed to be used for primary actions like 'Save',
/// 'Submit', 'Continue', or other important user interactions that should
/// stand out visually.
/// 
/// The button supports a loading state that replaces the text with a
/// progress indicator, providing immediate feedback during async operations.
/// This prevents multiple submissions and clearly communicates that an
/// action is in progress.
/// 
/// The button maintains a fixed height for consistent layout and uses
/// the application's primary color scheme for maximum visual impact.
/// 
/// Example usage:
/// ```dart
/// PrimaryButton(
///   text: 'Create Account',
///   isLoading: _isSubmitting,
///   onPressed: _isSubmitting ? null : _submitForm,
/// )
/// ```

import 'package:flutter/material.dart';

import '../constants/app_sizes.dart';

/// A primary button widget designed for main call-to-action elements.
/// 
/// This button provides consistent styling and behavior for the most
/// important actions in the application, with built-in loading state support.
class PrimaryButton extends StatelessWidget {
  /// Creates a [PrimaryButton] with the specified text and optional loading state.
  /// 
  /// The [text] parameter defines the button's label.
  /// The [isLoading] parameter controls whether to show a loading indicator.
  /// The [onPressed] callback is called when the button is tapped.
  const PrimaryButton(
      {super.key, required this.text, this.isLoading = false, this.onPressed});
  
  /// The text to display on the button.
  /// 
  /// This text is hidden when [isLoading] is true, replaced by a
  /// loading indicator to show that an action is in progress.
  final String text;
  
  /// Whether to show a loading indicator instead of the text.
  /// 
  /// When true, the button displays a circular progress indicator
  /// instead of the text, indicating that an async operation is in progress.
  /// This helps prevent multiple submissions and provides user feedback.
  final bool isLoading;
  
  /// Callback function called when the button is pressed.
  /// 
  /// If this is null, the button will be disabled and unresponsive to taps.
  /// During loading state, this callback should typically be set to null
  /// to prevent multiple submissions.
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // Fixed height ensures consistent button dimensions across the app
      height: Sizes.p48,
      child: ElevatedButton(
        onPressed: onPressed,
        child: isLoading
            // Show loading indicator during async operations
            ? const CircularProgressIndicator()
            // Show button text with prominent styling
            : Text(
                text,
                textAlign: TextAlign.center,
                // Use prominent text style with white color for visibility
                // against the primary button background
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: Colors.white),
              ),
      ),
    );
  }
}

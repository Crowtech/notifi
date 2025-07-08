/// A specialized text button widget designed for use as an AppBar action.
/// 
/// This widget provides a consistent style and layout for text buttons that appear
/// in the app bar's action area. It ensures proper spacing, typography, and visual
/// hierarchy within the application's design system.
/// 
/// The button displays white text on a transparent background, making it suitable
/// for use in app bars with darker backgrounds. The text styling follows the
/// titleLarge theme for appropriate emphasis and readability.
/// 
/// Example usage:
/// ```dart
/// AppBar(
///   actions: [
///     ActionTextButton(
///       text: 'Save',
///       onPressed: () => _saveData(),
///     ),
///   ],
/// )
/// ```

import 'package:flutter/material.dart';

import '../constants/app_sizes.dart';

/// A specialized text button widget designed for use as an AppBar action.
/// 
/// This widget provides consistent styling and spacing for text buttons that
/// appear in the app bar's action area. It ensures proper visual hierarchy
/// and follows the application's design system guidelines.
class ActionTextButton extends StatelessWidget {
  /// Creates an [ActionTextButton] with the specified text and optional callback.
  /// 
  /// The [text] parameter is required and defines the button's label.
  /// The [onPressed] callback is optional - if null, the button will be disabled.
  const ActionTextButton({super.key, required this.text, this.onPressed});
  
  /// The text to display on the button.
  /// 
  /// This text will be styled using the theme's titleLarge text style
  /// with white color for visibility against darker app bar backgrounds.
  final String text;
  
  /// Callback function called when the button is pressed.
  /// 
  /// If this is null, the button will be disabled and unresponsive to taps.
  /// The callback should handle the action associated with this button.
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      // Horizontal padding ensures proper spacing from app bar edges
      // and other action buttons
      padding: const EdgeInsets.symmetric(horizontal: Sizes.p16),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          // Use titleLarge for emphasis and readability in app bar context
          // White color ensures visibility against darker app bar backgrounds
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: Colors.white),
        ),
      ),
    );
  }
}

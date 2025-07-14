/// A customizable text button widget with fixed dimensions and styling options.
/// 
/// This widget provides a consistent interface for text buttons throughout the
/// application while allowing for customization of text styling. It ensures
/// uniform button dimensions and behavior across different parts of the app.
/// 
/// The button maintains a fixed height for consistent layout and alignment,
/// making it suitable for forms, dialogs, and other UI contexts where
/// predictable button sizing is important.
/// 
/// Example usage:
/// ```dart
/// CustomTextButton(
///   text: 'Cancel',
///   style: TextStyle(color: Colors.red),
///   onPressed: () => Navigator.pop(context),
/// )
/// ```
library;

import 'package:flutter/material.dart';

import '../constants/app_sizes.dart';

/// A customizable text button widget with fixed dimensions and styling options.
/// 
/// This widget provides a consistent interface for text buttons throughout the
/// application while allowing for customization of text styling. It maintains
/// a fixed height for consistent layout and supports custom text styling.
class CustomTextButton extends StatelessWidget {
  /// Creates a [CustomTextButton] with the specified text and optional styling.
  /// 
  /// The [text] parameter is required and defines the button's label.
  /// The [style] parameter allows custom text styling.
  /// The [onPressed] callback is optional - if null, the button will be disabled.
  const CustomTextButton(
      {super.key, required this.text, this.style, this.onPressed});
  
  /// The text to display on the button.
  /// 
  /// This text will be styled using either the provided [style] parameter
  /// or the default theme styling if no custom style is provided.
  final String text;
  
  /// Optional custom text style for the button label.
  /// 
  /// If not provided, the button will use the default theme's text styling.
  /// This allows for customization of color, font weight, size, and other
  /// text properties to match specific design requirements.
  final TextStyle? style;
  
  /// Callback function called when the button is pressed.
  /// 
  /// If this is null, the button will be disabled and unresponsive to taps.
  /// The callback should handle the action associated with this button.
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // Fixed height ensures consistent button dimensions across the app
      height: Sizes.p48,
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: style,
          // Center alignment ensures text is properly positioned
          // within the button's fixed dimensions
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

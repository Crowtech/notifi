/// A custom dropdown-style input widget that triggers external selection dialogs.
/// 
/// This widget provides a dropdown-like appearance and behavior without
/// containing the actual dropdown logic. Instead, it serves as a trigger
/// for external dialogs or pickers (like date pickers, time pickers, or
/// custom selection dialogs).
/// 
/// The widget is designed to look like a standard form input field but
/// displays a dropdown arrow to indicate that tapping will open a selection
/// interface. It's commonly used for date/time selection, option picking,
/// and other scenarios where a custom selection UI is preferred over a
/// traditional dropdown.
/// 
/// Example usage:
/// ```dart
/// InputDropdown(
///   labelText: 'Select Date',
///   valueText: '2023-12-25',
///   valueStyle: TextStyle(fontSize: 16),
///   onPressed: () => _showDatePicker(context),
/// )
/// ```
library;

import 'package:flutter/material.dart';

/// A custom input widget that mimics a dropdown appearance while triggering
/// external selection dialogs or pickers.
/// 
/// This widget provides consistent styling for inputs that need to open
/// external selection interfaces rather than inline dropdown menus.
class InputDropdown extends StatelessWidget {
  /// Creates an [InputDropdown] with the specified styling and callback.
  /// 
  /// The [valueText] and [valueStyle] parameters are required to display
  /// the current value. The [labelText] is optional and provides context.
  /// The [onPressed] callback is triggered when the user taps the widget.
  const InputDropdown({
    super.key,
    this.labelText,
    required this.valueText,
    required this.valueStyle,
    this.onPressed,
  });

  /// Optional label text displayed above the input field.
  /// 
  /// This helps users understand what type of value they're selecting,
  /// such as 'Date', 'Time', or 'Category'.
  final String? labelText;
  
  /// The current value text displayed in the input field.
  /// 
  /// This should be a formatted representation of the selected value,
  /// such as a formatted date, time, or option name.
  final String valueText;
  
  /// The text style to apply to the value text.
  /// 
  /// This allows customization of the appearance of the displayed value
  /// to match the application's design system.
  final TextStyle valueStyle;
  
  /// Callback function called when the user taps the input.
  /// 
  /// This should typically open a dialog, picker, or other selection
  /// interface that allows the user to choose a new value.
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: labelText,
        ),
        baseStyle: valueStyle,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            // Display the current value with specified styling
            Text(valueText, style: valueStyle),
            // Dropdown arrow icon that adapts to light/dark theme
            Icon(
              Icons.arrow_drop_down,
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.grey.shade700  // Darker arrow for light theme
                  : Colors.white70,       // Lighter arrow for dark theme
            ),
          ],
        ),
      ),
    );
  }
}

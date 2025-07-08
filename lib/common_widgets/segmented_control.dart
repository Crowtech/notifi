/// A segmented control widget that provides iOS-style option selection.
/// 
/// This widget creates a segmented control interface similar to iOS's
/// UISegmentedControl, allowing users to select from a set of mutually
/// exclusive options. It's particularly useful for filtering, categorization,
/// or any scenario where users need to choose between related options.
/// 
/// The widget displays a header above the segmented control and takes the
/// full width of its container. Each segment can contain any widget,
/// providing flexibility in how options are presented to users.
/// 
/// Example usage:
/// ```dart
/// SegmentedControl<String>(
///   header: Text('View Mode'),
///   value: _selectedMode,
///   children: {
///     'list': Text('List'),
///     'grid': Text('Grid'),
///     'card': Text('Card'),
///   },
///   onValueChanged: (value) => setState(() => _selectedMode = value),
/// )
/// ```

import 'package:flutter/cupertino.dart';

/// A segmented control widget that provides iOS-style option selection.
/// 
/// This widget creates a horizontal segmented control with customizable
/// segments, ideal for presenting mutually exclusive options to users.
class SegmentedControl<T extends Object> extends StatelessWidget {
  /// Creates a [SegmentedControl] with the specified options and callbacks.
  /// 
  /// The [header] is displayed above the control.
  /// The [value] represents the currently selected option.
  /// The [children] map defines the available options and their labels.
  /// The [onValueChanged] callback is called when the selection changes.
  const SegmentedControl({
    super.key,
    required this.header,
    required this.value,
    required this.children,
    required this.onValueChanged,
  });
  
  /// The header widget displayed above the segmented control.
  /// 
  /// This typically contains a label or title that describes what the
  /// segmented control is used for, such as 'Sort by' or 'View mode'.
  final Widget header;
  
  /// The currently selected value.
  /// 
  /// This should be one of the keys in the [children] map. The corresponding
  /// segment will be highlighted to indicate the current selection.
  final T value;
  
  /// A map of available options and their corresponding widgets.
  /// 
  /// The keys represent the values that can be selected, while the values
  /// are the widgets displayed in each segment (typically Text widgets).
  final Map<T, Widget> children;
  
  /// Callback function called when the user selects a different option.
  /// 
  /// This function receives the newly selected value and should update
  /// the parent widget's state to reflect the change.
  final ValueChanged<T> onValueChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          // Standard padding around the header for consistent spacing
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: header,
        ),
        SizedBox(
          // Full width ensures the segmented control spans the entire container
          width: double.infinity,
          child: CupertinoSegmentedControl<T>(
            children: children,
            groupValue: value,
            onValueChanged: onValueChanged,
          ),
        ),
      ],
    );
  }
}

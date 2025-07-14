/// A combined date and time picker widget for user input.
/// 
/// This widget provides a unified interface for selecting both date and time
/// values in a single component. It presents two separate input fields - one
/// for date selection and one for time selection - that work together to
/// provide a complete date-time input experience.
/// 
/// The widget uses Material Design date and time pickers internally, ensuring
/// a consistent and familiar user experience across the application. It's
/// particularly useful for scheduling, appointment booking, and event creation
/// features where precise date and time selection is required.
/// 
/// Example usage:
/// ```dart
/// DateTimePicker(
///   labelText: 'Appointment Date',
///   selectedDate: DateTime.now(),
///   selectedTime: TimeOfDay.now(),
///   onSelectedDate: (date) => setState(() => _selectedDate = date),
///   onSelectedTime: (time) => setState(() => _selectedTime = time),
/// )
/// ```
library;

import 'dart:async';

import 'package:flutter/material.dart';

import '../constants/app_sizes.dart';
import '../utils/format.dart';
import 'input_dropdown.dart';

/// A combined date and time picker widget that allows users to select both
/// date and time values through an intuitive interface.
/// 
/// This widget combines separate date and time selection controls into a
/// single cohesive component, making it easy for users to specify complete
/// date-time values for scheduling and planning purposes.
class DateTimePicker extends StatelessWidget {
  /// Creates a [DateTimePicker] with the specified initial values and callbacks.
  /// 
  /// The [labelText] is used to describe the purpose of the date selection.
  /// The [selectedDate] and [selectedTime] represent the current values.
  /// The callback functions are called when the user changes the values.
  const DateTimePicker({
    super.key,
    required this.labelText,
    required this.selectedDate,
    required this.selectedTime,
    this.onSelectedDate,
    this.onSelectedTime,
  });

  /// The label text displayed above the date picker.
  /// 
  /// This text helps users understand what the date selection is for,
  /// such as 'Event Date', 'Appointment Time', or 'Deadline'.
  final String labelText;
  
  /// The currently selected date value.
  /// 
  /// This date will be displayed in the date picker field and used
  /// as the initial value when the date picker dialog is opened.
  final DateTime selectedDate;
  
  /// The currently selected time value.
  /// 
  /// This time will be displayed in the time picker field and used
  /// as the initial value when the time picker dialog is opened.
  final TimeOfDay selectedTime;
  
  /// Callback function called when the user selects a new date.
  /// 
  /// This function receives the newly selected [DateTime] and should
  /// update the parent widget's state to reflect the change.
  final ValueChanged<DateTime>? onSelectedDate;
  
  /// Callback function called when the user selects a new time.
  /// 
  /// This function receives the newly selected [TimeOfDay] and should
  /// update the parent widget's state to reflect the change.
  final ValueChanged<TimeOfDay>? onSelectedTime;

  /// Shows the date picker dialog and handles date selection.
  /// 
  /// This method displays a Material Design date picker dialog with the
  /// current selected date as the initial value. The date range is set
  /// from 2019 to 2100 to cover practical use cases while preventing
  /// selection of dates too far in the past or future.
  /// 
  /// If the user selects a different date, the [onSelectedDate] callback
  /// is called with the new date value.
  Future<void> _selectDate(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      // Set reasonable date bounds for practical use
      firstDate: DateTime(2019, 1),
      lastDate: DateTime(2100),
    );
    
    // Only trigger callback if a different date was selected
    if (pickedDate != null && pickedDate != selectedDate) {
      onSelectedDate?.call(pickedDate);
    }
  }

  /// Shows the time picker dialog and handles time selection.
  /// 
  /// This method displays a Material Design time picker dialog with the
  /// current selected time as the initial value. The time picker allows
  /// users to select both hour and minute values in a familiar interface.
  /// 
  /// If the user selects a different time, the [onSelectedTime] callback
  /// is called with the new time value.
  Future<void> _selectTime(BuildContext context) async {
    final pickedTime = await showTimePicker(
      context: context, 
      initialTime: selectedTime,
    );
    
    // Only trigger callback if a different time was selected
    if (pickedTime != null && pickedTime != selectedTime) {
      onSelectedTime?.call(pickedTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Use consistent text styling for both date and time displays
    final valueStyle = Theme.of(context).textTheme.titleLarge!;
    
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        // Date picker takes up more space (5/9) as dates are typically longer
        Expanded(
          flex: 5,
          child: InputDropdown(
            labelText: labelText,
            valueText: Format.date(selectedDate),
            valueStyle: valueStyle,
            onPressed: () => _selectDate(context),
          ),
        ),
        // Standard gap between date and time inputs
        gapW12,
        // Time picker takes up less space (4/9) as times are shorter
        Expanded(
          flex: 4,
          child: InputDropdown(
            valueText: selectedTime.format(context),
            valueStyle: valueStyle,
            onPressed: () => _selectTime(context),
          ),
        ),
      ],
    );
  }
}

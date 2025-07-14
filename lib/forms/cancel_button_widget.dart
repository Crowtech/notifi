/// # Cancel Button Widget Module
/// 
/// This file contains the cancel button component for form dialogs in the Notifi application.
/// It provides a consistent, reusable button widget that allows users to dismiss forms
/// without saving changes or submitting data.
/// 
/// ## Business Context
/// The cancel button is a critical user interface component that provides users with
/// a clear escape route from form interactions. It ensures users can always exit
/// a form without making unwanted changes, supporting good user experience principles
/// and preventing accidental data submission.
/// 
/// ## Key Features
/// - **Consistent Styling**: Uses TextButton for Material Design compliance
/// - **Localized Text**: Supports internationalization with localized cancel text
/// - **Form Integration**: Accepts form key and code for potential validation cleanup
/// - **Navigation Handling**: Automatically closes the current dialog/modal
/// - **No Side Effects**: Dismisses form without saving or validating data
/// 
/// ## User Experience Considerations
/// - Always enabled (never disabled) to provide consistent escape route
/// - Uses standard Material Design button styling for familiarity
/// - Positioned consistently across all forms (typically left side of button row)
/// - Clear visual distinction from submit/save buttons
/// - Immediate response with no loading states or delays
/// 
/// ## Form Integration
/// While the cancel button currently doesn't use the form key or code parameters,
/// they are provided for potential future enhancements such as:
/// - Showing confirmation dialogs for forms with unsaved changes
/// - Clearing form validation state on cancel
/// - Analytics tracking for form abandonment
/// - Custom cancellation behavior per form type
/// 
/// ## Navigation Behavior
/// The button uses Navigator.pop() to close the current modal/dialog context.
/// This is appropriate for forms presented as dialogs, bottom sheets, or pushed routes.
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notifi/i18n/strings.g.dart' as nt;
import 'package:logger/logger.dart' as logger;

var log = logger.Logger(
  printer: logger.PrettyPrinter(),
  level: logger.Level.info,
);

var logNoStack = logger.Logger(
  printer: logger.PrettyPrinter(methodCount: 0),
  level: logger.Level.info,
);

/// ## CancelButtonWidget - Universal Form Cancel Button
/// 
/// A reusable cancel button component designed for use across all form dialogs
/// in the Notifi application. This widget provides consistent cancellation
/// behavior with proper localization and Material Design styling.
/// 
/// ### Design Principles
/// - **Always Available**: Never disabled to ensure users can always exit
/// - **Consistent Placement**: Standardized positioning across all forms
/// - **Clear Intent**: Uses TextButton styling to distinguish from primary actions
/// - **Immediate Response**: No loading states or confirmation dialogs
/// - **Localized**: Supports multiple languages through i18n system
/// 
/// ### Form Integration
/// - Accepts form key and code for potential future enhancements
/// - Currently performs simple navigation without form state cleanup
/// - Designed for expansion to support unsaved changes warnings
/// - Compatible with all form types (creation, editing, notification)
/// 
/// ### User Experience Features
/// - Uses standard Material Design button patterns
/// - Provides immediate visual feedback on tap
/// - Maintains accessibility standards with proper semantics
/// - Consistent with platform conventions for cancel actions
/// 
/// ### Business Rules
/// - Always closes the current form/dialog context
/// - Does not save or validate any form data
/// - Does not trigger any API calls or side effects
/// - Suitable for all form contexts where cancellation should be simple
// ignore: must_be_immutable
class CancelButtonWidget extends ConsumerWidget {
  CancelButtonWidget({super.key,required this.formKey,required this.formCode});

  /// Form key for potential future form state management
  /// Currently not used but available for enhancements like unsaved changes detection
  GlobalKey<FormState> formKey;
  
  /// Unique identifier for the form containing this cancel button
  /// Available for form-specific cancellation behavior or analytics
  String formCode;

  /// ## Build Method - Cancel Button UI Construction
  /// 
  /// Creates a Material Design TextButton with localized cancel text.
  /// The button provides immediate navigation back to the previous screen
  /// without any form validation or data saving.
  /// 
  /// ### Button Configuration
  /// - **TextButton**: Uses Material Design secondary button style
  /// - **Localized Text**: Displays cancel text in user's preferred language
  /// - **Navigation**: Simple pop operation to close current context
  /// - **No Validation**: Bypasses all form validation and state checks
  /// 
  /// ### User Interaction Flow
  /// 1. User taps cancel button
  /// 2. Navigator immediately pops current route/dialog
  /// 3. User returns to previous screen
  /// 4. No form data is saved or validated
  /// 
  /// @param context Build context for navigation and theming
  /// @param ref Widget reference for potential state management
  /// @return TextButton widget configured for form cancellation
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Note: refreshWidgetProvider integration commented out as it's not currently needed
    // ref.watch(refreshWidgetProvider("$formCode-cancel"));
    
    return TextButton(
      /// Cancel button press handler - provides immediate form dismissal
      /// Uses Navigator.pop() to close the current dialog/modal context
      /// No confirmation or validation is performed to ensure users can always exit
      onPressed: () {
        Navigator.of(context).pop();
      },
      
      /// Localized cancel text for internationalization support
      /// Text adapts to user's language preference automatically
      child: Text(nt.t.response.cancel),
    );
  }
}
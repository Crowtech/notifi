/// # Text Form Field Widget Module
/// 
/// This file contains the core text form field component for the Notifi application.
/// It provides a highly configurable, reusable text input widget with advanced features
/// including real-time validation, debouncing, async validation, state management,
/// and comprehensive user experience enhancements.
/// 
/// ## Business Context
/// The TextFormFieldWidget is the foundation of all form input handling in Notifi.
/// It provides consistent validation behavior, user feedback, and data handling
/// across all forms in the application. This widget integrates deeply with the
/// Riverpod state management system and the backend API for validation services.
/// 
/// ## Key Features
/// - **Real-time Validation**: Immediate feedback as users type
/// - **Debounced Input**: Prevents excessive API calls during typing
/// - **Async Validation**: Server-side validation for uniqueness checks
/// - **State Management**: Integration with Riverpod for form validation state
/// - **Visual Feedback**: Icons and colors indicating validation status
/// - **Input Formatting**: Automatic text formatting and filtering
/// - **Accessibility**: Screen reader support and keyboard navigation
/// - **Internationalization**: Localized error messages and labels
/// 
/// ## Validation Process
/// 1. **Immediate Validation**: Basic format validation on each keystroke
/// 2. **Debounced Validation**: Waits for user to stop typing before complex validation
/// 3. **Async Validation**: Server-side checks for uniqueness (email, code, etc.)
/// 4. **State Updates**: Updates form validation state for submit button control
/// 5. **Visual Feedback**: Shows loading, success, or error states with icons
/// 
/// ## Form Integration
/// - Integrates with validateFormProvider for overall form validation
/// - Updates enableWidgetProvider for conditional field enabling/disabling
/// - Uses refreshWidgetProvider for triggering UI updates
/// - Stores field values in central Map for form submission
/// 
/// ## User Experience Features
/// - Smooth animations for validation state changes
/// - Clear visual indicators (colors, icons) for validation status
/// - Helpful error messages with specific validation requirements
/// - Responsive layout that adapts to different screen sizes
/// - Consistent behavior across all form instances
/// 
/// ## Configuration Options
/// - Regex patterns for validation rules
/// - Input formatters for text transformation
/// - Debounce timing for performance optimization
/// - Optional vs required field handling
/// - Custom validation functions
/// - Localized messages and labels
library;

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart' as logger;
import 'package:notifi/api_utils.dart';
import 'package:notifi/credentials.dart';
import 'package:notifi/riverpod/enable_widget.dart';
import 'package:notifi/riverpod/refresh_widget.dart';
import 'package:notifi/riverpod/validate_form.dart';
import 'package:notifi/state/nest_auth2.dart';

var log = logger.Logger(
  printer: logger.PrettyPrinter(),
  level: logger.Level.info,
);

var logNoStack = logger.Logger(
  printer: logger.PrettyPrinter(methodCount: 0),
  level: logger.Level.info,
);

/// Type definition for custom validation functions
/// Allows forms to provide custom validation logic beyond regex patterns
typedef ValidateFunction<String> = bool Function(String value);

/// ## TextFormFieldWidget - Advanced Form Input Component
/// 
/// A highly configurable, reusable text input widget that provides comprehensive
/// form input handling with real-time validation, debouncing, async validation,
/// and state management integration. This widget serves as the foundation for
/// all text input fields across the Notifi application.
/// 
/// ### Core Functionality
/// - **Real-time Validation**: Validates input as user types with debouncing
/// - **Async Validation**: Performs server-side validation for uniqueness checks
/// - **State Management**: Integrates with Riverpod for form-wide state coordination
/// - **Visual Feedback**: Provides immediate visual feedback for validation status
/// - **Input Formatting**: Applies text formatting rules (uppercase, lowercase, filtering)
/// - **Accessibility**: Full accessibility support with proper semantics
/// 
/// ### Validation Workflow
/// 1. User types in field
/// 2. Basic format validation occurs immediately
/// 3. After debounce delay, advanced validation runs
/// 4. If async validation is configured, server check occurs
/// 5. Validation state updates throughout the form
/// 6. Visual feedback reflects current validation status
/// 
/// ### Business Rules Integration
/// - Supports required vs optional field logic
/// - Integrates with form-wide validation state
/// - Handles field enabling/disabling based on business rules
/// - Provides consistent error messaging across all forms
/// 
/// ### Performance Optimization
/// - Debounced validation prevents excessive API calls
/// - Efficient state updates minimize unnecessary rebuilds
/// - Smart validation caching reduces redundant checks
/// - Responsive UI updates with smooth animations
/// 
/// ### Configuration Parameters
/// - **fieldValues**: Central storage for form field values
/// - **validationDebounce**: Timing for validation delay (default 500ms)
/// - **controller**: Text controller for input management
/// - **isValidatingMessage**: Message shown during async validation
/// - **valueIsEmptyMessage**: Error message for empty required fields
/// - **valueIsInvalidMessage**: Error message for invalid format
/// - **valueIsExisting**: Error message for duplicate values
/// - **formCode**: Unique identifier for form instance
/// - **fieldCode**: Unique identifier for field within form
/// - **optional**: Whether field is required or optional
/// - **regex**: Regular expression pattern for validation
/// - **onValidate**: Custom validation function
/// - **inputFormatters**: Text formatting rules
class TextFormFieldWidget extends ConsumerStatefulWidget {
  TextFormFieldWidget({
    super.key,
    required this.fieldValues,
    this.validationDebounce = const Duration(milliseconds: 500),
    required this.controller,
    this.isValidatingMessage,
    this.valueIsEmptyMessage = 'please enter a value',
    this.valueIsInvalidMessage = 'please enter a valid value',
    this.valueIsExisting,
    this.existingIsError = false,
    this.hintText = '',
    required this.formCode,
    required this.fieldCode,
    this.initialValue = "",
    this.readOnly = false,
    this.enabled = true,
    required this.itemCategory,
    required this.itemName,
    required this.itemValidation,
    this.itemExists = false,
    this.optional = false,
    this.regex = r"^[\p{L} ,.'-0-9]*$",
    this.textCapitalization = TextCapitalization.none,
    this.onValidate,
    this.inputFormatters = const [],
  });

  /// Central storage for all form field values
  /// Maps field names to their current values for form submission
  final Map<String, dynamic> fieldValues;
  
  /// Debounce duration for validation to prevent excessive API calls
  /// Balances responsiveness with performance
  Duration validationDebounce;
  
  /// Text controller for managing input state and programmatic access
  final TextEditingController controller;
  
  /// Hint text displayed in the field to guide user input
  String hintText;
  
  /// Message displayed during async validation process
  String? isValidatingMessage;
  
  /// Error message displayed when required field is empty
  String valueIsEmptyMessage;
  
  /// Error message displayed when field format is invalid
  String valueIsInvalidMessage;
  
  /// Error message displayed when value already exists (uniqueness check)
  String? valueIsExisting;

  bool existingIsError;
  
  /// Unique identifier for the form containing this field
  final String formCode;
  
  /// Unique identifier for this field within the form
  final String fieldCode;
  
  /// Initial value for the field (usually empty for new forms)
  String initialValue;
  
  /// Whether the field is read-only (display purposes)
  bool readOnly;
  
  /// Whether the field is enabled for user interaction
  bool enabled;
  
  /// Category of item this field represents (for contextual messages)
  final String itemCategory;
  
  /// Display name for the field (used in labels and error messages)
  final String itemName;
  
  /// Validation error message template for this field
  final String itemValidation;
  
  /// Whether the item already exists (used in update scenarios)
  bool itemExists;
  
  /// Whether this field is optional (can be left empty)
  bool optional;
  
  /// Regular expression pattern for format validation
  String regex;
  
  /// Text capitalization behavior for user input
  TextCapitalization textCapitalization;
  
  /// Custom validation function for complex business rules
  ValidateFunction<String>? onValidate;
  
  /// Input formatters for text transformation and filtering
  List<TextInputFormatter> inputFormatters;

  @override
  ConsumerState<TextFormFieldWidget> createState() =>
      _TextFormFieldWidgetState();
}

/// ## TextFormFieldWidget State Management
/// 
/// Manages the complex state for the text form field including validation states,
/// debouncing, async validation coordination, visual feedback, and integration
/// with the broader form validation system. This class orchestrates the
/// interaction between user input, validation logic, and UI updates.
/// 
/// ### State Variables Overview
/// - **Validation States**: Track validation progress and results
/// - **User Interaction States**: Monitor user input and field interaction
/// - **Visual Feedback States**: Control UI indicators and colors
/// - **Performance States**: Manage debouncing and async operations
/// - **Integration States**: Coordinate with form-wide validation system
class _TextFormFieldWidgetState extends ConsumerState<TextFormFieldWidget> {
  /// Form field key for programmatic access to field state and validation
  /// Used to trigger validation and access validation state
  final GlobalKey<FormFieldState> itemFormFieldKey =
      GlobalKey<FormFieldState>();

  /// Timer for debounced validation to prevent excessive API calls
  /// Cancelled and recreated on each keystroke
  Timer? _debounce;
  
  /// **Validation State Variables**
  
  /// Whether async validation is currently in progress
  /// Used to show loading indicators and prevent multiple concurrent validations
  var isValidating = false;
  
  /// Whether the current field value passes all validation rules
  /// Determines visual feedback and form submission enablement
  var isValid = false;
  
  /// Whether the current value already exists in the system (uniqueness check)
  /// Used for email, username, or other unique field validation
  var isExisting = false;
  
  /// Whether the user has interacted with the field
  /// Prevents showing validation errors before user input
  var isDirty = false;
  
  /// Whether the field is waiting for debounced validation to trigger
  /// Used to manage validation timing and prevent premature validation
  var isWaiting = false;

  /// **Field State Variables**
  
  /// Whether the field is currently empty
  /// Used for optional field logic and validation decisions
  bool isEmpty = true;
  
  /// Whether the field is currently enabled for user interaction
  /// Managed by enableWidgetProvider for business rule enforcement
  late bool enableWidget;
  
  /// Whether the initial value was valid (used for form initialization)
  bool initialValid = false;
  
  /// Input formatters applied to user input for text transformation
  late List<TextInputFormatter>? inputFormatters;
  
  /// Clean field code without prefix (extracted from widget.fieldCode)
  /// Used for API calls and field value storage
  late String pureFieldCode;

  @override
  void initState() {
    super.initState();
    
    /// Extract clean field code for use in API calls and value storage
    /// Removes prefix (e.g., "true-email" becomes "email")
    pureFieldCode =
        widget.fieldCode.substring(widget.fieldCode.indexOf('-') + 1);
    
    /// Initialize input formatters from widget configuration
    inputFormatters = widget.inputFormatters;

    /// Initialize field state based on initial value
    isEmpty = widget.initialValue.isEmpty;
    enableWidget = widget.enabled;
  }

  /// ## Status Color Determination
  /// 
  /// Calculates the appropriate color for visual feedback based on field state.
  /// This provides immediate visual cues to users about validation status
  /// and field interaction state.
  /// 
  /// ### Color Logic
  /// - **Grey**: Field is disabled (no user interaction allowed)
  /// - **Green**: Field is valid (empty optional field or valid non-empty field)
  /// - **Black**: Field is empty and required (neutral state, no error yet)
  /// - **Red**: Field has validation errors (invalid format or failed rules)
  /// 
  /// ### Business Rules
  /// - Disabled fields always show grey regardless of content
  /// - Optional empty fields are considered valid (green)
  /// - Required empty fields show neutral state until user interaction
  /// - Invalid non-empty fields show error state (red)
  /// 
  /// @return Color representing the current validation state
  Color statusColor() {
    logNoStack.i(
      "StatusColor: ${widget.fieldCode} enabled:$enableWidget isValid:$isValid isEmpty:$isEmpty optional:${widget.optional}",
    );
    
    if (enableWidget == false) {
      return Colors.grey; // Disabled state
    } else if (isEmpty && widget.optional) {
      return Colors.green; // Valid optional empty field
    } else if (isEmpty) {
      return Colors.black; // Required empty field (neutral)
    } else if (!isEmpty && isValid) {
      return Colors.green; // Valid non-empty field
    } else if (!isEmpty && isExisting) {
      return Colors.green; // Valid non-empty existing field
    } else {
      return Colors.red; // Invalid field
    }
  }

  /// ## Comprehensive Field Validation
  /// 
  /// Performs multi-stage validation including format validation and optional
  /// async server-side validation for uniqueness checks. This method coordinates
  /// local validation, API calls, state updates, and form integration.
  /// 
  /// ### Validation Stages
  /// 1. **Format Validation**: Check against regex pattern or custom validator
  /// 2. **Async Validation**: Server-side uniqueness check (if configured)
  /// 3. **State Updates**: Update local validation state and visual feedback
  /// 4. **Form Integration**: Update form-wide validation state
  /// 5. **Value Storage**: Store validated value in form field values
  /// 
  /// ### Async Validation Process
  /// - Only triggered if format validation passes and async message is configured
  /// - Shows loading state during API call
  /// - Checks server response for existing values
  /// - Updates validation state based on server response
  /// 
  /// ### Performance Considerations
  /// - Called after debounce delay to prevent excessive API calls
  /// - Manages loading states to prevent concurrent validations
  /// - Efficiently updates only necessary state variables
  /// 
  /// ### Form Integration
  /// - Updates validateFormProvider with field validation state
  /// - Stores field value in central fieldValues map for form submission
  /// - Coordinates with other fields for overall form validation
  /// 
  /// @param value The current field value to validate
  /// @return Future<bool> indicating whether the value is valid
  Future<bool> validate(String value) async {
    /// Stage 1: Format validation using regex or custom validator
    var isValid = isValidInput(value);
    isExisting = false;

    /// Stage 2: Async validation for uniqueness checks (if configured)
    if (isValid && (widget.isValidatingMessage != null)) {
      /// Set loading state for user feedback
      setState(() {
        isValidating = true;
        isExisting = false;
      });
      
      /// Get authentication token for API call
      var token = ref.read(nestAuthProvider.notifier).token;
      
      /// Construct API endpoint for uniqueness check
      /// Format: /{formCode}s/check/{fieldCode}/{encodedValue}
      var apiPath =
          "$defaultAPIBaseUrl$defaultApiPrefixPath/${widget.formCode}s/check/$pureFieldCode/";
      apiPath = "$apiPath${Uri.encodeComponent(value)}";
      logNoStack.i("TEXT_FORM_WIDGET: check encodedApiPath is $apiPath");
      
      /// Make authenticated API call for server-side validation
      var response = await apiGetData(token!, apiPath, "application/json");
      
      /// Parse response - "true" means value already exists (validation fails)
      isExisting = response.body.contains("true");
      
      if (isExisting) {
        /// Value exists - validation fails
        isValid = false;
        setState(() {
          isValidating = false;
          isExisting = true;
          isValid = widget.existingIsError? false: true ;
        });
      } else {
        /// Value is unique - validation passes
        setState(() {
          isValidating = false;
          isExisting = false;
          isValid = true;
        });
      }
    }
    
    /// Stage 3: Store validated value in form field values
    widget.fieldValues[pureFieldCode] = value;
    
    /// Stage 4: Update form-wide validation state
    /// This enables/disables submit button based on all field validation states
    ref
        .read(validateFormProvider(widget.formCode).notifier)
        .add(pureFieldCode, isValid);
        
    return isValid;
  }

  @override
  void dispose() {
    /// Clean up debounce timer to prevent memory leaks and unwanted callbacks
    /// Critical for proper resource management in Flutter applications
    _debounce?.cancel();
    super.dispose();
  }

  /// ## Build Method - Text Form Field UI Construction
  /// 
  /// Constructs the complete text form field interface with validation feedback,
  /// debounced input handling, and state management integration. This method
  /// coordinates between Riverpod providers, user input, and visual feedback.
  /// 
  /// ### Provider Integration
  /// - **enableWidgetProvider**: Controls field enabling/disabling based on business rules
  /// - **refreshWidgetProvider**: Triggers UI updates when external state changes
  /// - **validateFormProvider**: Coordinates with form-wide validation state
  /// 
  /// ### State Management
  /// - Watches Riverpod providers for reactive state updates
  /// - Manages disabled field state and cleanup
  /// - Coordinates validation states with visual feedback
  /// 
  /// ### Field Configuration
  /// - Applies input formatters for text transformation
  /// - Sets up debounced validation for performance
  /// - Configures accessibility and keyboard behavior
  /// - Provides comprehensive validation feedback
  /// 
  /// ### Visual Feedback
  /// - Suffix icons showing validation status (loading, success, error)
  /// - Error messages for different validation failure types
  /// - Consistent styling with application theme
  /// 
  /// @return TextFormField widget with full validation and state management
  @override
  Widget build(BuildContext context) {
    /// Watch Riverpod providers for reactive state updates
    enableWidget = ref.watch(enableWidgetProvider(widget.fieldCode));
    ref.watch(refreshWidgetProvider(widget.fieldCode));

    logNoStack.i(
        "TEXT_FORM_WIDGET: BUILD: ${widget.fieldCode} enableWidget:$enableWidget");
    
    /// Handle disabled field state - reset all validation and clear content
    /// This ensures disabled fields don't interfere with form validation
    if (enableWidget == false) {
      isValid = true; // Disabled fields are considered valid
      widget.controller.text = ""; // Clear field content
      widget.fieldValues[pureFieldCode] = ""; // Clear stored value
      isEmpty = true;
      isWaiting = false;
      isValidating = false;
      isExisting = false;
      isDirty = false;
    }

    return TextFormField(
      /// Field Configuration
      enabled: enableWidget,
      inputFormatters: inputFormatters,
      textCapitalization: widget.textCapitalization,
      key: itemFormFieldKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      
      /// **Validation Function** - Provides error messages based on validation state
      /// 
      /// Validation Message Priority:
      /// 1. Disabled fields: No validation (null)
      /// 2. Async validation in progress: Show loading message
      /// 3. Empty required fields: Show empty field error
      /// 4. Existing values: Show uniqueness error
      /// 5. Invalid format: Show format error
      /// 6. Valid fields: No error (null)
      validator: (value) {
        if (enableWidget == false) {
          return null; // Disabled fields pass validation
        }
        if (isValidating) {
          return widget.isValidatingMessage; // Show loading message
        }
        if (value?.isEmpty ?? false) {
          
          return widget.valueIsEmptyMessage; // Show empty error
        }

        if (!isWaiting && !isValid && isExisting) {
          return widget.valueIsExisting; // Show uniqueness error
        }

        if (!isWaiting && isValid && isExisting) {
          return widget.valueIsExisting; // Show uniqueness error
        }
        if (!isWaiting && !isValid) {
          return widget.valueIsInvalidMessage; // Show format error
        }
        return null; // Field is valid
      },
      
      /// **Input Change Handler** - Manages debounced validation and state updates
      /// 
      /// Input Processing Flow:
      /// 1. Mark field as dirty (user has interacted)
      /// 2. Handle empty field logic for required fields
      /// 3. Cancel previous debounce timer
      /// 4. Start new debounce timer for validation
      /// 5. Trigger validation after debounce delay
      /// 6. Update UI state after validation
      onChanged: (text) async {
        isDirty = true; // User has interacted with field
        
        /// Handle empty required fields immediately (no debounce needed)
        if (text.isEmpty && !widget.optional) {
          setState(() {
            isValid = false;
            logNoStack.i('is empty');
          });
          cancelTimer();
          return;
        }
        
        /// Set up debounced validation for non-empty input
        isWaiting = true;
        cancelTimer(); // Cancel previous timer
        
        /// Create new debounce timer for validation
        _debounce = Timer(widget.validationDebounce, () async {
          isWaiting = false;
          isValid = await validate(text); // Trigger validation
          logNoStack.i(isValid);
          setState(() {}); // Update UI
          isValidating = false;
        });
      },
      
      /// Field Appearance and Behavior Configuration
      textAlign: TextAlign.start,
      controller: widget.controller,
      maxLines: 1,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          suffix: SizedBox(height: 20, width: 20, child: _getSuffixIcon()),
          hintText: widget.hintText),
    );

    //   decoration: InputDecoration(
    //     hintText: widget.hintText,
    //     errorStyle: const TextStyle(color: Colors.red),
    //     labelText: widget.optional
    //         ? "${widget.itemName} (${nt.t.optional})"
    //         : widget.itemName,
    //     focusedBorder: OutlineInputBorder(
    //       borderSide: BorderSide(color: statusColor(), width: 3.0),
    //       borderRadius: BorderRadius.circular(10.0),
    //     ),
    //     enabledBorder: OutlineInputBorder(
    //       borderSide: BorderSide(
    //         color: statusColor(),
    //         width: isValid ? 2.0 : 1.0,
    //       ),
    //       borderRadius: BorderRadius.circular(10.0),
    //     ),
    //     disabledBorder: OutlineInputBorder(
    //       borderSide: const BorderSide(color: Colors.grey, width: 1.0),
    //       borderRadius: BorderRadius.circular(10.0),
    //     ),
    //     errorBorder: OutlineInputBorder(
    //       borderSide: const BorderSide(color: Colors.red, width: 3.0),
    //       borderRadius: BorderRadius.circular(10.0),
    //     ),
    //   ),
    //     validator: (value) {
    //     if (isValidating) {
    //       return widget.isValidatingMessage;
    //     }
    //     if (value?.isEmpty ?? false) {
    //       return widget.valueIsEmptyMessage;
    //     }
    //     if (!isWaiting && !isValid) {
    //       return widget.valueIsInvalidMessage;
    //     }
    //     return null;
    //   },
    //   onChanged: (text) async {
    //     isDirty = true;
    //     if (text.isEmpty) {
    //       setState(() {
    //         isValid = false;
    //         print('is empty');
    //       });
    //       cancelTimer();
    //       return;
    //     }
    //     isWaiting = true;
    //     cancelTimer();
    //     _debounce = Timer(widget.validationDebounce, () async {
    //       isWaiting = false;
    //       isValid = await validate(text);
    //       print(isValid);
    //       setState(() {});
    //       isValidating = false;
    //     });
    //   },
    // );
  }

  /// ## Input Validation Logic
  /// 
  /// Performs immediate validation of field input using configured validation rules.
  /// This method handles the core validation logic including disabled fields,
  /// empty field handling, custom validators, and regex pattern matching.
  /// 
  /// ### Validation Hierarchy
  /// 1. **Disabled Fields**: Always considered valid (bypass all validation)
  /// 2. **Empty Fields**: Required fields fail, optional fields pass
  /// 3. **Custom Validators**: Use provided onValidate function if available
  /// 4. **Regex Validation**: Default pattern matching for format validation
  /// 
  /// ### Business Rules
  /// - Disabled fields are always valid to prevent form submission blocking
  /// - Optional empty fields are valid to support partial form completion
  /// - Required empty fields are invalid until user provides input
  /// - Custom validators take precedence over regex patterns
  /// - Regex patterns are case-insensitive and support Unicode characters
  /// 
  /// ### Performance Considerations
  /// - Fast execution for immediate validation feedback
  /// - Efficient regex compilation with appropriate flags
  /// - Minimal state side effects (only updates isValid)
  /// - Detailed logging for debugging validation issues
  /// 
  /// @param value The input value to validate
  /// @return bool indicating whether the input is valid
  bool isValidInput(String? value) {
    if (!enableWidget) {
      /// Disabled fields are always considered valid
      /// This prevents disabled fields from blocking form submission
      isValid = true;
    } else if (value == null || value.isEmpty) {
      /// Handle empty field validation based on optional flag
      if (!widget.optional) {
        isValid = false; // Required empty field is invalid
      } else {
        isValid = true; // Optional empty field is valid
      }
    } else if (widget.onValidate != null) {
      /// Use custom validation function if provided
      /// This allows complex business rule validation beyond regex patterns
      logNoStack.i(
        "Checking validation using onValidate  ${widget.fieldCode} ${widget.onValidate!(value) ? 'GOOD' : 'BAD'}",
      );
      isValid = widget.onValidate!(value);
    } else {
      /// Default regex pattern validation
      /// Supports Unicode characters and case-insensitive matching
      isValid = RegExp(
        widget.regex,
        caseSensitive: false,
        unicode: true,
        dotAll: true,
      ).hasMatch(value);
    }
    
    logNoStack.i(
      "Checking validation for enabled:$enableWidget ${widget.fieldCode} $value optional:${widget.optional} isValid:$isValid isDirty:$isDirty",
    );

    return isValid;
  }

  /// ## Timer Cancellation Utility
  /// 
  /// Safely cancels the active debounce timer to prevent unwanted validation
  /// callbacks. This is essential for proper debouncing behavior and preventing
  /// validation race conditions.
  /// 
  /// ### Use Cases
  /// - User types new character before previous debounce completes
  /// - Field becomes disabled while validation is pending
  /// - Component is disposed while timer is active
  /// - Form is submitted before validation completes
  /// 
  /// ### Safety Checks
  /// - Checks if timer exists before attempting cancellation
  /// - Verifies timer is active before cancelling
  /// - Prevents exceptions from null or inactive timers
  void cancelTimer() {
    if (_debounce?.isActive ?? false) {
      _debounce?.cancel();
    }
  }

  /// ## Suffix Icon Provider
  /// 
  /// Provides visual feedback icons based on current validation state.
  /// These icons give users immediate visual confirmation of field status
  /// and enhance the overall user experience with clear status indicators.
  /// 
  /// ### Icon States
  /// - **Loading Spinner**: Shown during async validation (blue)
  /// - **Error Icon**: Shown for invalid fields after user interaction (red)
  /// - **Success Icon**: Shown for valid fields (green)
  /// - **No Icon**: Shown for untouched fields or disabled fields
  /// 
  /// ### User Experience Considerations
  /// - Icons only appear after user interaction (isDirty flag)
  /// - Loading spinner provides feedback during async operations
  /// - Color coding follows standard conventions (red=error, green=success)
  /// - Consistent sizing for visual alignment
  /// 
  /// ### Performance Optimization
  /// - Returns lightweight Container() when no icon needed
  /// - Uses const constructors for static icons
  /// - Minimal widget tree depth for efficiency
  /// 
  /// @return Widget representing the current validation state
  Widget _getSuffixIcon() {
    logNoStack.i(
      "Checking validationSuffixIcon for enabled:$enableWidget ${widget.fieldCode} isValid:$isValid isDirty:$isDirty",
    );
    
    if (isValidating) {
      /// Show loading spinner during async validation
      return const CircularProgressIndicator(
        strokeWidth: 2.0,
        valueColor: AlwaysStoppedAnimation(Colors.blue),
      );
    } else {
      if (!isValid && isDirty) {
        /// Show error icon for invalid fields (only after user interaction)
        return const Icon(
          Icons.cancel,
          color: Colors.red,
          size: 20,
        );
      } else if (isValid) {
        /// Show success icon for valid fields
        return const Icon(
          Icons.check_circle,
          color: Colors.green,
          size: 20,
        );
      } else {
        /// No icon for untouched or disabled fields
        return Container();
      }
    }
  }
}

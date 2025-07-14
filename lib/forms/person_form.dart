/// # Person Creation Form Module
/// 
/// This file contains the person creation form functionality for the Notifi application.
/// It provides a comprehensive dialog form that allows administrators and authorized users
/// to create new person records with organization associations and email validation.
/// 
/// ## Business Context
/// The person creation form is a critical component of the user management system within Notifi.
/// It enables the creation of new person records with proper validation, organization assignment,
/// and integration with the notification system. Created persons can receive notifications
/// and be associated with multiple organizations for access control and targeting.
/// 
/// ## Key Features
/// - Real-time email validation with uniqueness checking
/// - Given name and family name validation with proper formatting
/// - Multi-organization selection with checkbox interface
/// - Comprehensive form validation with debouncing
/// - API integration for person creation with organization assignment
/// - User feedback through status alerts and form state management
/// - Responsive dialog layout with scroll support and height constraints
/// 
/// ## Form Fields
/// - **Email**: Required unique email address with RFC compliance validation
/// - **Given Name**: Required first name with character set validation
/// - **Family Name**: Required last name with character set validation
/// - **Organizations**: Multi-select organization assignment interface
/// 
/// ## Validation Rules
/// - Email: Must be unique, valid email format, and not exist in system
/// - Given Name: Must be non-empty and match NAME_REGEX pattern
/// - Family Name: Must be non-empty and match NAME_REGEX pattern
/// - Organizations: At least one organization must be selected for person creation
/// 
/// ## API Integration
/// The form submits to: `/persons/invite?orgid={id1}&orgid={id2}...`
/// Person data is sent as JSON payload with email, firstname, and lastname fields.
/// Authentication is handled through the NestAuth provider with Bearer token authorization.
/// 
/// ## Business Rules
/// - All person records must have unique email addresses
/// - Person creation triggers an invitation process
/// - Organizations are assigned at creation time and determine access permissions
/// - Form validation prevents duplicate email submissions
/// - Successful creation invalidates person cache and closes dialog
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart' as logger;
import 'package:notifi/api_utils.dart';
import 'package:notifi/credentials.dart';
import 'package:notifi/forms/cancel_button_widget.dart';
import 'package:notifi/forms/org_list.dart';
import 'package:notifi/forms/text_form_widget.dart';
import 'package:notifi/forms/validations.dart/email_validation.dart';
import 'package:notifi/forms/validations.dart/name_validation.dart';
import 'package:notifi/i18n/strings.g.dart' as nt;
import 'package:notifi/models/person.dart';
import 'package:notifi/persons/src/features/persons/data/persons_repository.dart';
import 'package:notifi/riverpod/validate_form.dart';
import 'package:notifi/state/nest_auth2.dart';
import 'package:status_alert/status_alert.dart';

var log = logger.Logger(
  printer: logger.PrettyPrinter(),
  level: logger.Level.info,
);

var logNoStack = logger.Logger(
  printer: logger.PrettyPrinter(methodCount: 0),
  level: logger.Level.info,
);

/// ## CreatePersonForm Widget
/// 
/// A comprehensive dialog form widget that enables authorized users to create new person
/// records within the Notifi system. This form handles person data collection, email
/// uniqueness validation, organization assignment, and integration with the invitation system.
/// 
/// ### Business Rules
/// - All person records must have unique email addresses across the system
/// - Email validation includes both format validation and uniqueness checking via API
/// - Given name and family name are required with proper character validation
/// - At least one organization must be selected for person creation
/// - Person creation triggers an automated invitation process
/// - Form validation occurs in real-time with debouncing to prevent excessive API calls
/// 
/// ### Form State Management
/// - Uses Riverpod for state management and form validation coordination
/// - Field values are stored in a centralized Map for flexible data handling
/// - Form validation state is managed through the validateFormProvider
/// - Organization selection is handled through dedicated OrganizationListWidget
/// - Email uniqueness is validated asynchronously against the backend API
/// 
/// ### User Experience Features
/// - Responsive dialog with height constraints for better mobile experience
/// - Real-time validation feedback with visual indicators
/// - Smooth animations for form size changes during validation
/// - Clear error messages and success confirmations
/// - Organization selection with multi-checkbox interface
/// - Cancel/Submit button states based on comprehensive form validity
/// 
/// ### Integration Points
/// - Person creation API endpoint with organization assignment
/// - Email validation API for uniqueness checking
/// - Organization data provider for selection interface
/// - Person repository invalidation for cache management
/// - Status alert system for user feedback
class CreatePersonForm extends ConsumerStatefulWidget {
  CreatePersonForm({super.key, required this.formCode});

  /// Unique identifier for this form instance, used for validation state management
  /// and distinguishing between multiple form instances in the application
  String formCode;

  @override
  _CreatePersonFormState createState() => _CreatePersonFormState();
}

/// ## CreatePersonForm State Management
/// 
/// Manages the state for the person creation form including form validation,
/// field values, organization selection, and user interaction handling.
/// This class coordinates between the UI components, validation logic,
/// and the backend API for person creation and invitation processing.
class _CreatePersonFormState extends ConsumerState<CreatePersonForm> {
  /// Form key for managing form validation state and triggering validation
  /// Used to programmatically validate the entire form before submission
  final _formKey = GlobalKey<FormState>();

  /// Central storage for all form field values including organization selections
  /// Maps field names to their current values for API submission
  /// Key format: 'email', 'given_name', 'family_name', 'orgIds'
  final Map<String, dynamic> fieldValues = {};

  /// Text controllers for managing form field input state
  /// These controllers handle text input, cursor position, selection,
  /// and are used for programmatic text manipulation and clearing
  final givenNameController = TextEditingController();
  final familyNameController = TextEditingController();
  final emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialize form state - controllers are created above
    // Field values and organization selections will be populated as user interacts
  }

  @override
  void dispose() {
    // Clean up text controllers to prevent memory leaks
    // This is critical for preventing memory leaks in Flutter applications
    emailController.dispose();
    familyNameController.dispose();
    givenNameController.dispose();
    super.dispose();
  }

  /// Default validation function placeholder
  /// Currently returns true for all inputs - specific validation
  /// is handled by individual field validators and async email checking
  /// 
  /// @param value The input value to validate
  /// @return Always returns true (placeholder implementation)
  Future<bool> defaultValidate(String value) async {
    return true;
  }

  /// ## Build Method - Person Creation Form UI
  /// 
  /// Constructs the complete person creation form interface with all required fields,
  /// validation logic, organization selection, and submission handling. The form is
  /// presented as a constrained dialog with responsive design and smooth animations.
  /// 
  /// ### Form Structure
  /// - **Dialog Container**: Provides modal presentation with height constraints
  /// - **ConstrainedBox**: Limits dialog height to 80% of screen for mobile compatibility
  /// - **Form Widget**: Manages overall form state and validation
  /// - **AnimatedSize**: Provides smooth transitions when form content changes
  /// - **Column Layout**: Vertical arrangement of form fields and controls
  /// 
  /// ### Field Configuration
  /// Each field is configured with:
  /// - Comprehensive validation rules (email uniqueness, name patterns)
  /// - Input formatters for data consistency and user experience
  /// - Localized labels and error messages
  /// - Real-time validation with debouncing for performance
  /// - Integration with central field values map
  /// 
  /// ### Organization Selection
  /// - Multi-select checkbox interface for organization assignment
  /// - Required selection validation (at least one organization)
  /// - Integration with organization data provider
  /// - Dynamic loading and selection state management
  /// 
  /// ### User Experience Features
  /// - Responsive dialog sizing with screen height constraints
  /// - Smooth animations during validation state changes
  /// - Clear visual feedback for validation states
  /// - Consistent spacing and typography
  /// - Accessibility-friendly form structure
  /// - Scroll support for smaller screens
  @override
  Widget build(BuildContext context) {
    var currentUser = ref.read(nestAuthProvider.notifier).currentUser;
    String capitalizedItem = nt.t.person_capitalized;
    logNoStack.i("PERSON_FORM: BUILD ");
    
    /// Calculate maximum dialog height as 80% of screen height
    /// This ensures the dialog remains usable on smaller screens
    /// while providing enough space for all form fields and organization list
    final maximumHeightOfDialog = MediaQuery.of(context).size.height * 0.8;
    
    return Dialog(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: maximumHeightOfDialog,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Flexible(
                    child: AnimatedSize(
                      // Animate changes in form size when validation states change
                      // This provides smooth transitions when error messages appear/disappear
                      // and when organization list expands/contracts
                      duration: const Duration(milliseconds: 200),
                      child: Column(
                        children: [
                          /// Form title - clearly identifies the form purpose with localized text
                          Text(
                            nt.t.form.create(item: capitalizedItem),
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          
                          /// **Email Field** - Required unique email address with comprehensive validation
                          /// 
                          /// Business Rules:
                          /// - Required field (cannot be empty)
                          /// - Must be a valid email format (RFC compliant)
                          /// - Must be unique across the entire system (async validation)
                          /// - Automatically formatted to lowercase for consistency
                          /// - Character filtering ensures only valid email characters
                          /// 
                          /// Validation Process:
                          /// 1. Real-time format validation using EMAIL_REGEX
                          /// 2. Asynchronous uniqueness check via validateEmail function
                          /// 3. Server-side validation against existing person records
                          /// 4. User feedback during validation process
                          /// 
                          /// User Experience:
                          /// - Email keyboard type for mobile devices
                          /// - Lowercase input formatting
                          /// - Clear validation status indicators
                          /// - Helpful error messages for format and uniqueness issues
                          TextFormFieldWidget(
                            controller: emailController,
                            fieldValues: fieldValues,
                            isValidatingMessage:
                                nt.t.form.validating(field: nt.t.form.email),
                            valueIsExisting: nt.t.form.already_exists(
                                item: nt.t.person_capitalized,
                                field: nt.t.form.email),
                            formCode: widget.formCode,
                            fieldCode: "true-email",
                            enabled: true,
                            itemCategory: nt.t.person,
                            itemName: nt.t.form.email,
                            itemValidation: nt.t.form.email_validation(
                              item: nt.t.person_capitalized,
                            ),
                            hintText: nt.t.form.email_hint,
                            onValidate: validateEmail,
                            regex: EMAIL_REGEX,
                            inputFormatters: emailInputFormatter,
                          ),
                          const SizedBox(height: 16),
                          
                          /// **Given Name Field** - Required first name with character validation
                          /// 
                          /// Business Rules:
                          /// - Required field (cannot be empty)
                          /// - Must match NAME_REGEX pattern for allowed characters
                          /// - Supports international character sets including accented letters
                          /// - Debounced validation to prevent excessive processing
                          /// - Proper case formatting encouraged through hints
                          /// 
                          /// Validation: NAME_REGEX allows letters, spaces, apostrophes, hyphens, and periods
                          /// User Experience: Sentence case capitalization, clear formatting hints
                          TextFormFieldWidget(
                            controller: givenNameController,
                            validationDebounce:
                                const Duration(milliseconds: 500),
                            fieldValues: fieldValues,
                            formCode: widget.formCode,
                            fieldCode: "true-given_name",
                            itemCategory: nt.t.person,
                            itemName: nt.t.form.given_name,
                            itemValidation: nt.t.form.given_name_validation(
                              item: nt.t.person_capitalized,
                            ),
                            hintText: nt.t.form.given_name_hint,
                            regex: NAME_REGEX,
                          ),
                          const SizedBox(height: 16),
                          
                          /// **Family Name Field** - Required last name with character validation
                          /// 
                          /// Business Rules:
                          /// - Required field (cannot be empty)
                          /// - Must match NAME_REGEX pattern for allowed characters
                          /// - Supports international character sets including accented letters
                          /// - Consistent validation with given name field
                          /// - Proper case formatting encouraged through hints
                          /// 
                          /// Validation: NAME_REGEX allows letters, spaces, apostrophes, hyphens, and periods
                          /// User Experience: Sentence case capitalization, clear formatting hints
                          TextFormFieldWidget(
                            controller: familyNameController,
                            fieldValues: fieldValues,
                            formCode: widget.formCode,
                            fieldCode: "true-family_name",
                            itemCategory: nt.t.person,
                            itemName: nt.t.form.family_name,
                            itemValidation: nt.t.form.family_name_validation(
                              item: nt.t.person_capitalized,
                            ),
                            hintText: nt.t.form.family_name_hint,
                            regex: NAME_REGEX,
                          ),
                          const SizedBox(height: 16),
                          
                          /// **Organization Selection Widget** - Multi-select organization assignment
                          /// 
                          /// Business Rules:
                          /// - At least one organization must be selected for person creation
                          /// - Organizations determine access permissions and notification targeting
                          /// - Selection state is managed independently from other form fields
                          /// - Organization data is loaded dynamically from the backend
                          /// 
                          /// Features:
                          /// - Checkbox-based multi-selection interface
                          /// - Scrollable list for handling many organizations
                          /// - Real-time selection state feedback
                          /// - Integration with form validation system
                          /// 
                          /// Data Flow:
                          /// - Selected organization IDs are stored in fieldValues['orgIds']
                          /// - Used in API call for person-organization association
                          /// - Validates that at least one organization is selected
                          OrganizationListWidget(
                              formKey: _formKey,
                              formCode: widget.formCode,
                              fieldValues: fieldValues,
                              fieldCode: "orgids"),
                          /// **Form Action Buttons** - Cancel and Submit controls
                          /// 
                          /// Layout: Right-aligned horizontal row with proper spacing
                          /// User Experience: Clear visual hierarchy with primary action emphasis
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              /// Cancel button - allows users to dismiss the form without saving
                              /// Always enabled, closes dialog immediately without validation
                              CancelButtonWidget(
                                  formKey: _formKey, formCode: widget.formCode),
                              const SizedBox(width: 16),
                              
                              /// **Submit Button** - Handles person creation with comprehensive validation
                              /// 
                              /// Button State Management:
                              /// - Disabled when form validation fails
                              /// - Enabled only when all required fields are valid and at least one organization is selected
                              /// - Uses Consumer to reactively update based on validation state
                              /// 
                              /// Submission Process:
                              /// 1. Final form validation check
                              /// 2. Create Person object from validated field values
                              /// 3. Construct organization query parameters
                              /// 4. Make authenticated API call with person data
                              /// 5. Handle success/error responses with user feedback
                              /// 6. Invalidate person cache and close dialog on success
                              Consumer(builder: (context, watch, child) {
                                /// Real-time validation state from Riverpod provider
                                /// This ensures submit button is only enabled when all fields are valid
                                /// and at least one organization is selected
                                bool isValid = ref.watch(
                                    validateFormProvider(widget.formCode));
                                logNoStack.i("NPERSON_FORM: isValid $isValid");
                                
                                return ElevatedButton(
                                  key: const Key("person-submit"),
                                  
                                  /// Button is disabled when validation fails
                                  /// This prevents invalid submissions and provides clear user feedback
                                  onPressed: !isValid
                                      ? null
                                      : () async {
                                          /// Double-check form validation before submission
                                          /// This is a final safety check before making the API call
                                          if (_formKey.currentState != null &&
                                              _formKey.currentState!
                                                  .validate()) {
                                            
                                            /// **Person Object Creation**
                                            /// 
                                            /// Create Person instance from validated form field values
                                            /// Maps form field names to Person model properties
                                            Person person = Person(
                                              firstname: fieldValues['given_name'], 
                                              lastname: fieldValues['family_name'], 
                                              email: fieldValues['email'],
                                              i18n: currentUser.i18n,  // use the same language for now as user...

                                            );
                                            
                                            logNoStack.i(
                                                'person form: ${fieldValues['orgIds']}');
                                            
                                            /// **Organization Query Parameters Construction**
                                            /// 
                                            /// Build query string with multiple orgid parameters
                                            /// Format: orgid=1&orgid=2&orgid=3 (removes trailing &)
                                            /// Each selected organization will be associated with the new person
                                            String queryParmOrgIds = "";
                                            for (int orgId
                                                in fieldValues['orgIds']) {
                                              queryParmOrgIds +=
                                                  "orgid=$orgId&";
                                            }
                                            queryParmOrgIds =
                                                queryParmOrgIds.substring(0,
                                                    queryParmOrgIds.length - 1);
                                            
                                            /// Get authentication token for API call
                                            /// Uses NestAuth provider for secure token management
                                            var token = ref
                                                .read(nestAuthProvider.notifier)
                                                .token;
                                            
                                            /// Construct API endpoint with organization parameters
                                            /// Format: /persons/invite?orgid={id1}&orgid={id2}...
                                            /// The 'invite' endpoint creates a person and sends invitation
                                            var apiPath =
                                                "$defaultAPIBaseUrl$defaultApiPrefixPath/persons/invite?$queryParmOrgIds";

                                            logNoStack.i(
                                                "PERSON_FORM: sending $person to $apiPath");
                                            
                                            /// **API Call with Success/Error Handling**
                                            /// 
                                            /// Make authenticated POST request to create person with organization assignments
                                            /// Handle both success and error cases with appropriate user feedback
                                            apiPostDataNoLocaleRaw(
                                                    token!, apiPath, person)
                                                .then((result) {
                                              logNoStack.i("result is $result");

                                              /// Success case - Show confirmation and close dialog
                                              StatusAlert.show(
                                                context,
                                                duration:
                                                    const Duration(seconds: 2),
                                                title: nt.t.person,
                                                subtitle: nt.t.form.saved,
                                                configuration:
                                                    const IconConfiguration(
                                                        icon: Icons.done),
                                                maxWidth: 300,
                                              );
                                              
                                              /// Invalidate person cache to refresh data
                                              /// This ensures the UI shows the newly created person
                                              ref.invalidate(
                                                  fetchPersonsProvider);
                                              
                                              /// Close dialog after successful submission
                                              Navigator.of(context).pop();
                                            }, onError: (error) {
                                              /// Error case - Show error message but keep dialog open
                                              /// This allows user to correct issues and retry
                                              logNoStack.e("error is $error");
                                              StatusAlert.show(
                                                context,
                                                duration:
                                                    const Duration(seconds: 2),
                                                title: nt.t.person,
                                                subtitle:
                                                    nt.t.form.error_saving,
                                                configuration:
                                                    const IconConfiguration(
                                                        icon: Icons.error),
                                                maxWidth: 300,
                                              );
                                            });
                                          }
                                        },
                                  child: Text(nt.t.response.submit),
                                );
                              })
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

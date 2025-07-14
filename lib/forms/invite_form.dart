/// # Invite Form Module
/// 
/// This file contains the invitation form functionality for the Notifi application.
/// It provides a comprehensive dialog form that allows authorized users to invite
/// new people to join organizations by email address with conditional field display
/// based on email validation results.
/// 
/// ## Business Context
/// The invitation form is a critical component of the user onboarding system within Notifi.
/// It enables authorized users to invite new people to their organizations through a
/// progressive disclosure interface that first validates email addresses before showing
/// additional fields for new user creation.
/// 
/// ## Key Features
/// - Progressive form disclosure based on email validation
/// - Real-time email validation with existence checking via validateEmailAsync2
/// - Conditional firstname/surname fields for new users only
/// - Multi-organization selection for invitation targeting
/// - Comprehensive form validation with debouncing
/// - API integration for person invitation with organization assignment
/// - User feedback through status alerts and form state management
/// - Responsive dialog layout with scroll support and height constraints
/// 
/// ## Form Flow
/// 1. **Email Entry**: User enters invitee's email address
/// 2. **Email Validation**: System checks if email exists via validateEmailAsync2
/// 3. **Conditional Fields**: If email doesn't exist, show firstname/surname fields
/// 4. **Organization Selection**: Show organizations that inviter belongs to
/// 5. **Submission**: Create Person object and submit invitation
/// 
/// ## Form Fields
/// - **Email**: Required email address with existence validation
/// - **Firstname**: Required for new users (shown conditionally)
/// - **Surname**: Required for new users (shown conditionally)
/// - **Organizations**: Multi-select organization assignment interface
/// 
/// ## Validation Rules
/// - Email: Must be valid format, existence checked via validateEmailAsync2
/// - Firstname: Required when email doesn't exist, must match NAME_REGEX
/// - Surname: Required when email doesn't exist, must match NAME_REGEX
/// - Organizations: At least one organization must be selected for invitation
/// 
/// ## API Integration
/// The form submits to: `/persons/invite?orgid={id1}&orgid={id2}...`
/// Person data is sent as JSON payload with email, firstname, and surname fields.
/// Authentication is handled through the NestAuth provider with Bearer token authorization.
library;

import 'dart:async';
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

/// ## InviteForm Widget
/// 
/// A progressive disclosure form widget that enables authorized users to invite new people
/// to organizations within the Notifi system. This form handles email validation first,
/// then conditionally shows additional fields for new user creation.
/// 
/// ### Business Rules
/// - Email addresses are validated for existence before showing additional fields
/// - New users require firstname and surname fields
/// - Existing users only need organization selection
/// - At least one organization must be selected for invitation
/// - Form validation occurs in real-time with debouncing to prevent excessive API calls
/// 
/// ### Form State Management
/// - Uses Riverpod for state management and form validation coordination
/// - Field values are stored in a centralized Map for flexible data handling
/// - Form validation state is managed through the validateFormProvider
/// - Organization selection is handled through dedicated OrganizationListWidget
/// - Email existence is validated asynchronously using validateEmailAsync2
/// 
/// ### User Experience Features
/// - Progressive disclosure - additional fields appear based on email validation
/// - Responsive dialog with height constraints for better mobile experience
/// - Real-time validation feedback with visual indicators
/// - Smooth animations for form size changes during validation
/// - Clear error messages and success confirmations
/// - Organization selection with multi-checkbox interface
/// - Cancel/Submit button states based on comprehensive form validity
/// 
/// ### Integration Points
/// - Person invitation API endpoint with organization assignment
/// - Email validation API for existence checking via validateEmailAsync2
/// - Organization data provider for selection interface
/// - Person repository invalidation for cache management
/// - Status alert system for user feedback
class InviteForm extends ConsumerStatefulWidget {
  InviteForm({super.key, required this.formCode});

  /// Unique identifier for this form instance, used for validation state management
  /// and distinguishing between multiple form instances in the application
  String formCode;

  @override
  _InviteFormState createState() => _InviteFormState();
}

/// ## InviteForm State Management
/// 
/// Manages the state for the invitation form including progressive disclosure,
/// field validation, organization selection, and user interaction handling.
/// This class coordinates between the UI components, validation logic,
/// and the backend API for person invitation processing.
class _InviteFormState extends ConsumerState<InviteForm> {
  /// Form key for managing form validation state and triggering validation
  /// Used to programmatically validate the entire form before submission
  final _formKey = GlobalKey<FormState>();

  /// Central storage for all form field values including organization selections
  /// Maps field names to their current values for API submission
  /// Key format: 'email', 'firstname', 'surname', 'orgIds'
  final Map<String, dynamic> fieldValues = {};

  /// Text controllers for managing form field input state
  /// These controllers handle text input, cursor position, selection,
  /// and are used for programmatic text manipulation and clearing
  final firstnameController = TextEditingController();
  final surnameController = TextEditingController();
  final emailController = TextEditingController();

  /// State flag to control conditional field display
  /// When true, firstname and surname fields are shown
  /// When false, only email and organization fields are shown
  bool _showNameFields = false;

  /// State flag to track email validation completion
  /// Used to determine when to show organization selection
  bool _emailValidated = false;

  @override
  void initState() {
    super.initState();
    // Initialize form state - controllers are created above
    // Field values and organization selections will be populated as user interacts
    
    // Add listener to email controller for progressive disclosure logic
    emailController.addListener(_onEmailChanged);
  }

  /// Timer for debouncing email validation to prevent excessive API calls
  Timer? _emailValidationTimer;

  /// Handles email field changes with debouncing for async validation
  void _onEmailChanged() {
    // Cancel previous timer
    _emailValidationTimer?.cancel();
    
    // Set up debounced validation
    _emailValidationTimer = Timer(const Duration(milliseconds: 1000), () {
      final email = emailController.text.trim();
      if (email.isNotEmpty && validateEmail(email)) {
        validateEmailAndUpdateState(email);
      } else {
        setState(() {
          _showNameFields = false;
          _emailValidated = false;
        });
      }
    });
  }

  @override
  void dispose() {
    // Clean up text controllers to prevent memory leaks
    // This is critical for preventing memory leaks in Flutter applications
    _emailValidationTimer?.cancel();
    emailController.removeListener(_onEmailChanged);
    emailController.dispose();
    firstnameController.dispose();
    surnameController.dispose();
    super.dispose();
  }

  /// Email validation function that determines conditional field display
  /// This function uses validateEmailAsync2 to check if the email exists
  /// and updates the UI state accordingly
  /// 
  /// @param email The email address to validate
  /// @return Future<bool> true if email is valid and doesn't exist (new user)
  Future<void> validateEmailAndUpdateState(String email) async {
    if (email.isEmpty) {
      setState(() {
        _showNameFields = false;
        _emailValidated = false;
      });
      return;
    }

    // Use the existing validateEmailAsync2 function to check email existence
    bool emailDoesNotExist = await validateEmailAsync2(ref, context, email);
    
    setState(() {
      _emailValidated = true;
      _showNameFields = emailDoesNotExist; // Show name fields only for new users
    });
    
    // Store the email validation result for form submission logic
    fieldValues['email_exists'] = !emailDoesNotExist;
  }

  /// Synchronous email format validation for the onValidate parameter
  /// This is used by TextFormFieldWidget for immediate validation feedback
  bool validateEmailFormat(String value) {
    return validateEmail(value);
  }

  /// ## Build Method - Invitation Form UI
  /// 
  /// Constructs the progressive disclosure invitation form interface with conditional
  /// field display based on email validation results. The form presents different
  /// sets of fields depending on whether the invitee is a new or existing user.
  /// 
  /// ### Progressive Disclosure Logic
  /// 1. **Email Field**: Always shown first for invitee email entry
  /// 2. **Name Fields**: Shown only when email doesn't exist (new user)
  /// 3. **Organization Selection**: Shown after email validation completes
  /// 4. **Submit Button**: Enabled when all required fields are valid
  /// 
  /// ### Form Structure
  /// - **Dialog Container**: Provides modal presentation with height constraints
  /// - **ConstrainedBox**: Limits dialog height to 80% of screen for mobile compatibility
  /// - **Form Widget**: Manages overall form state and validation
  /// - **AnimatedSize**: Provides smooth transitions when conditional fields appear/disappear
  /// - **Column Layout**: Vertical arrangement of form fields and controls
  /// 
  /// ### Field Configuration
  /// Each field is configured with:
  /// - Comprehensive validation rules appropriate to field type
  /// - Input formatters for data consistency and user experience
  /// - Localized labels and error messages
  /// - Real-time validation with debouncing for performance
  /// - Integration with central field values map
  @override
  Widget build(BuildContext context) {
    var currentUser = ref.read(nestAuthProvider.notifier).currentUser;
    logNoStack.i("INVITE_FORM: BUILD ");
    
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
                      // Animate changes in form size when conditional fields appear/disappear
                      // This provides smooth transitions when name fields are shown/hidden
                      // and when organization list expands/contracts
                      duration: const Duration(milliseconds: 300),
                      child: Column(
                        children: [
                          /// Form title - clearly identifies the form purpose with localized text
                          Text(
                            nt.t.form.invite_person,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          
                          /// **Email Field** - Required email address with existence validation
                          /// 
                          /// This is the primary field that drives the progressive disclosure logic.
                          /// Uses validateEmailAsync2 to determine if additional fields should be shown.
                          /// 
                          /// Business Rules:
                          /// - Required field (cannot be empty)
                          /// - Must be a valid email format (RFC compliant)
                          /// - Existence is checked via validateEmailAsync2 function
                          /// - Automatically formatted to lowercase for consistency
                          /// - Character filtering ensures only valid email characters
                          /// 
                          /// Progressive Disclosure Logic:
                          /// - If email exists: only show organization selection
                          /// - If email doesn't exist: show firstname/surname fields + organizations
                          /// 
                          /// User Experience:
                          /// - Email keyboard type for mobile devices
                          /// - Lowercase input formatting
                          /// - Clear validation status indicators
                          /// - Helpful messaging about new vs existing users
                          TextFormFieldWidget(
                            controller: emailController,
                            fieldValues: fieldValues,
                            isValidatingMessage:
                                nt.t.form.validating(field: nt.t.form.email),
                            valueIsExisting: _showNameFields 
                                ? nt.t.form.new_user_detected
                                : nt.t.form.existing_user_detected,
                            formCode: widget.formCode,
                            fieldCode: "true-email",
                            enabled: true,
                            itemCategory: nt.t.form.invitation,
                            itemName: nt.t.form.email,
                            itemValidation: nt.t.form.email_validation(
                              item: nt.t.form.invitation,
                            ),
                            hintText: nt.t.form.email_hint,
                            onValidate: validateEmailFormat,
                            regex: EMAIL_REGEX,
                            inputFormatters: emailInputFormatter,
                          ),
                          const SizedBox(height: 16),
                          
                          /// **Conditional Name Fields** - Shown only for new users
                          /// 
                          /// These fields appear with smooth animation when validateEmailAsync2
                          /// indicates the email address doesn't exist in the system.
                          /// Both fields are required when visible.
                          if (_showNameFields) ...[
                            /// **Firstname Field** - Required for new users
                            /// 
                            /// Business Rules:
                            /// - Required field when visible (new user detected)
                            /// - Must match NAME_REGEX pattern for allowed characters
                            /// - Supports international character sets including accented letters
                            /// - Debounced validation to prevent excessive processing
                            /// - Proper case formatting encouraged through hints
                            /// 
                            /// Validation: NAME_REGEX allows letters, spaces, apostrophes, hyphens, and periods
                            /// User Experience: Sentence case capitalization, clear formatting hints
                            TextFormFieldWidget(
                              controller: firstnameController,
                              validationDebounce: const Duration(milliseconds: 500),
                              fieldValues: fieldValues,
                              formCode: widget.formCode,
                              fieldCode: "true-firstname",
                              itemCategory: nt.t.form.invitation,
                              itemName: nt.t.form.first_name,
                              itemValidation: nt.t.form.given_name_validation(
                                item: nt.t.form.invitation,
                              ),
                              hintText: nt.t.form.given_name_hint,
                              regex: NAME_REGEX,
                            ),
                            const SizedBox(height: 16),
                            
                            /// **Surname Field** - Required for new users
                            /// 
                            /// Business Rules:
                            /// - Required field when visible (new user detected)
                            /// - Must match NAME_REGEX pattern for allowed characters
                            /// - Supports international character sets including accented letters
                            /// - Consistent validation with firstname field
                            /// - Proper case formatting encouraged through hints
                            /// 
                            /// Validation: NAME_REGEX allows letters, spaces, apostrophes, hyphens, and periods
                            /// User Experience: Sentence case capitalization, clear formatting hints
                            TextFormFieldWidget(
                              controller: surnameController,
                              fieldValues: fieldValues,
                              formCode: widget.formCode,
                              fieldCode: "true-surname",
                              itemCategory: nt.t.form.invitation,
                              itemName: nt.t.form.last_name,
                              itemValidation: nt.t.form.family_name_validation(
                                item: nt.t.form.invitation,
                              ),
                              hintText: nt.t.form.family_name_hint,
                              regex: NAME_REGEX,
                            ),
                            const SizedBox(height: 16),
                          ],
                          
                          /// **Organization Selection Widget** - Shown after email validation
                          /// 
                          /// This widget appears after email validation completes, regardless
                          /// of whether the user is new or existing. Shows organizations that
                          /// the current user (inviter) belongs to.
                          /// 
                          /// Business Rules:
                          /// - At least one organization must be selected for invitation
                          /// - Only shows organizations that the inviter is a member of
                          /// - Organizations determine access permissions for the invitee
                          /// - Selection state is managed independently from other form fields
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
                          if (_emailValidated) ...[
                            Text(
                              nt.t.form.select_organizations,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 8),
                            OrganizationListWidget(
                              formKey: _formKey,
                              formCode: widget.formCode,
                              fieldValues: fieldValues,
                              fieldCode: "true-orgids",
                            ),
                          ],
                          
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
                                formKey: _formKey, 
                                formCode: widget.formCode,
                              ),
                              const SizedBox(width: 16),
                              
                              /// **Submit Button** - Handles invitation with comprehensive validation
                              /// 
                              /// Button State Management:
                              /// - Disabled when form validation fails
                              /// - Enabled only when email is validated and organizations are selected
                              /// - For new users: also requires firstname and surname
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
                                /// This ensures submit button is only enabled when all required fields are valid
                                /// and at least one organization is selected
                                bool isValid = ref.watch(
                                    validateFormProvider(widget.formCode));
                                
                                logNoStack.i("INVITE_FORM: isValid $isValid, emailValidated: $_emailValidated");
                                
                                // Additional validation: email must be validated and for new users, name fields must be filled
                                bool canSubmit = isValid && _emailValidated && 
                                    (!_showNameFields || (fieldValues['firstname'] != null && fieldValues['surname'] != null));
                                
                                return ElevatedButton(
                                  key: const Key("true-submit"),
                                  
                                  /// Button is disabled when validation fails
                                  /// This prevents invalid submissions and provides clear user feedback
                                  onPressed: !canSubmit
                                      ? null
                                      : () async {
                                          /// Double-check form validation before submission
                                          /// This is a final safety check before making the API call
                                          if (_formKey.currentState != null &&
                                              _formKey.currentState!.validate()) {
                                            
                                            /// **Person Object Creation**
                                            /// 
                                            /// Create Person instance from validated form field values
                                            /// For existing users, firstname/surname may be null
                                            /// For new users, all fields are required
                                            Person person = Person(
                                              email: fieldValues['email'],
                                              firstname: _showNameFields ? fieldValues['firstname'] : null,
                                              lastname: _showNameFields ? fieldValues['surname'] : null,
                                              i18n: currentUser.i18n, // Use same language as inviter
                                            );
                                            
                                            logNoStack.i('invite form: person=$person, orgIds=${fieldValues['orgids']}');
                                            
                                            /// **Organization Query Parameters Construction**
                                            /// 
                                            /// Build query string with multiple orgid parameters
                                            /// Format: orgid=1&orgid=2&orgid=3 (removes trailing &)
                                            /// Each selected organization will be associated with the invited person
                                            String queryParmOrgIds = "";
                                            for (int orgId in fieldValues['orgids']) {
                                              queryParmOrgIds += "orgid=$orgId&";
                                            }
                                            if (queryParmOrgIds.isNotEmpty) {
                                              queryParmOrgIds = queryParmOrgIds.substring(0, queryParmOrgIds.length - 1);
                                            }
                                            
                                            /// Get authentication token for API call
                                            /// Uses NestAuth provider for secure token management
                                            var token = ref.read(nestAuthProvider.notifier).token;
                                            
                                            /// Construct API endpoint with organization parameters
                                            /// Format: /persons/invite?orgid={id1}&orgid={id2}...
                                            /// The 'invite' endpoint creates/updates person and sends invitation
                                            var apiPath = "$defaultAPIBaseUrl$defaultApiPrefixPath/persons/invite?$queryParmOrgIds";

                                            logNoStack.i("INVITE_FORM: sending $person to $apiPath");
                                            
                                            /// **API Call with Success/Error Handling**
                                            /// 
                                            /// Make authenticated POST request to invite person with organization assignments
                                            /// Handle both success and error cases with appropriate user feedback
                                            apiPostDataNoLocaleRaw(token!, apiPath, person)
                                                .then((result) {
                                              logNoStack.i("invite result: $result");

                                              /// Success case - Show confirmation and close dialog
                                              StatusAlert.show(
                                                context,
                                                duration: const Duration(seconds: 2),
                                                title: nt.t.form.invitation,
                                                subtitle: nt.t.form.invitation_sent,
                                                configuration: const IconConfiguration(icon: Icons.done),
                                                maxWidth: 300,
                                              );
                                              
                                              /// Invalidate person cache to refresh data
                                              /// This ensures the UI shows the newly invited person
                                              ref.invalidate(fetchPersonsProvider);
                                              
                                              /// Close dialog after successful submission
                                              Navigator.of(context).pop();
                                            }, onError: (error) {
                                              /// Error case - Show error message but keep dialog open
                                              /// This allows user to correct issues and retry
                                              logNoStack.e("invite error: $error");
                                              StatusAlert.show(
                                                context,
                                                duration: const Duration(seconds: 3),
                                                title: nt.t.form.invitation,
                                                subtitle: nt.t.form.error_sending_invitation,
                                                configuration: const IconConfiguration(icon: Icons.error),
                                                maxWidth: 300,
                                              );
                                            });
                                          }
                                        },
                                  child: Text(nt.t.form.send_invitation),
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
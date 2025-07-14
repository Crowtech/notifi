# InviteForm Widget Documentation

## Overview

The `InviteForm` widget provides a comprehensive invitation system for the Notifi application. It allows authorized users (inviters) to invite new people (invitees) to join organizations through a progressive disclosure interface that adapts based on email validation results.

## Key Features

- **Progressive Disclosure**: Form fields appear conditionally based on email validation
- **Email Validation**: Uses `validateEmailAsync2` to check if email addresses exist in the system
- **Conditional Fields**: Shows firstname/surname fields only for new users
- **Organization Selection**: Multi-select interface for organization assignment
- **Real-time Validation**: Comprehensive form validation with debouncing
- **Responsive Design**: Adaptive dialog layout with mobile-friendly constraints
- **Internationalization**: Full i18n support with localized error messages

## User Flow

1. **Email Entry**: Inviter enters the invitee's email address
2. **Email Validation**: System validates email format and checks existence via `validateEmailAsync2`
3. **Conditional Display**:
   - If email exists: Show organization selection only
   - If email doesn't exist: Show firstname, surname, and organization selection
4. **Organization Selection**: Display organizations that the inviter belongs to with checkbox interface
5. **Submission**: Create Person object and submit invitation to backend

## API Integration

### Endpoints Used

- **Email Validation**: `/resources/check/email/{email}` (via `validateEmailAsync2`)
- **Person Invitation**: `/persons/invite?orgid={id1}&orgid={id2}...`

### Request Format

```json
{
  "email": "invitee@example.com",
  "firstname": "John",     // Only for new users
  "lastname": "Doe",       // Only for new users
  "i18n": "en"            // Inherited from inviter
}
```

## Form Fields

### Email Field
- **Required**: Yes
- **Validation**: Email format + existence check via `validateEmailAsync2`
- **Behavior**: Triggers progressive disclosure logic
- **Input Formatting**: Lowercase, email-only characters

### Firstname Field (Conditional)
- **Required**: Yes (when visible)
- **Visibility**: Shown only when email doesn't exist in system
- **Validation**: NAME_REGEX pattern (letters, spaces, apostrophes, hyphens, periods)
- **Animation**: Smooth appearance with AnimatedSize

### Surname Field (Conditional)
- **Required**: Yes (when visible)
- **Visibility**: Shown only when email doesn't exist in system
- **Validation**: NAME_REGEX pattern (letters, spaces, apostrophes, hyphens, periods)
- **Animation**: Smooth appearance with AnimatedSize

### Organization Selection
- **Required**: At least one organization must be selected
- **Interface**: Multi-select checkboxes via `OrganizationListWidget`
- **Data Source**: Organizations that the current user belongs to
- **Visibility**: Shown after email validation completes

## State Management

### Form State Variables

```dart
Map<String, dynamic> fieldValues = {}; // Central storage for all field values
bool _showNameFields = false;          // Controls firstname/surname visibility
bool _emailValidated = false;          // Tracks email validation completion
```

### Validation State

The form uses Riverpod's `validateFormProvider` for centralized validation state management:

```dart
bool isValid = ref.watch(validateFormProvider(widget.formCode));
```

### Field Value Keys

- `'email'`: Email address
- `'firstname'`: First name (conditional)
- `'surname'`: Last name (conditional)
- `'orgIds'`: Array of selected organization IDs

## Usage Examples

### Basic Dialog Usage

```dart
void showInviteForm(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return InviteForm(
        formCode: 'invite_${DateTime.now().millisecondsSinceEpoch}',
      );
    },
  );
}
```

### Integration with FloatingActionButton

```dart
FloatingActionButton(
  onPressed: () => showInviteForm(context),
  tooltip: 'Invite Person',
  child: Icon(Icons.person_add),
)
```

### Page Embedding

```dart
Scaffold(
  body: Padding(
    padding: EdgeInsets.all(16.0),
    child: InviteForm(
      formCode: 'invite_page_${DateTime.now().millisecondsSinceEpoch}',
    ),
  ),
)
```

## Form Validation Rules

### Email Validation
1. Format validation using EMAIL_REGEX
2. Existence check via `validateEmailAsync2` function
3. Updates progressive disclosure state based on result

### Name Field Validation (when visible)
1. Required field validation
2. Character pattern validation using NAME_REGEX
3. Debounced validation (500ms) to prevent excessive API calls

### Organization Selection Validation
1. At least one organization must be selected
2. Integrated with central form validation system

### Submit Button State
- Disabled when form validation fails
- Enabled only when:
  - Email is validated
  - For new users: firstname and surname are provided
  - At least one organization is selected

## Internationalization

### Required Translation Keys

Add these keys to your `strings.i18n.json`:

```json
{
  "form": {
    "invite_person": "Invite Person",
    "invitation": "Invitation",
    "first_name": "First Name",
    "last_name": "Last Name",
    "new_user_detected": "New user - please provide name details",
    "existing_user_detected": "Existing user found",
    "select_organizations": "Select Organizations",
    "send_invitation": "Send Invitation",
    "invitation_sent": "Invitation sent successfully",
    "error_sending_invitation": "Error sending invitation"
  }
}
```

## Error Handling

### Validation Errors
- Real-time field validation with visual feedback
- Localized error messages for each validation rule
- Form submission prevention when validation fails

### API Errors
- Network error handling with user-friendly messages
- Success/failure feedback via StatusAlert
- Form remains open on error for retry capability

### Email Validation Errors
- Invalid format feedback
- Existence check error handling
- Loading states during async validation

## Performance Considerations

### Debouncing
- Name field validation debounced to 500ms
- Email validation triggered on field blur or submission
- Prevents excessive API calls during typing

### Animation Performance
- AnimatedSize for smooth field appearance/disappearance
- 300ms duration for optimal user experience
- Height-constrained dialog prevents layout issues

### Memory Management
- Text controllers properly disposed in dispose() method
- Form state cleaned up when widget is destroyed
- Riverpod providers automatically managed

## Dependencies

### Required Packages
- `flutter_riverpod`: State management
- `logger`: Logging functionality
- `status_alert`: User feedback alerts
- `email_validator`: Email format validation

### Internal Dependencies
- `validateEmailAsync2`: Email existence validation
- `OrganizationListWidget`: Organization selection interface
- `TextFormFieldWidget`: Standardized form fields
- `CancelButtonWidget`: Cancel functionality
- NestAuth provider: Authentication management

## Testing Considerations

### Unit Testing
- Test email validation logic
- Test progressive disclosure state changes
- Test form validation rules
- Mock `validateEmailAsync2` function

### Widget Testing
- Test form field visibility logic
- Test user interaction flows
- Test validation error states
- Test submission success/failure scenarios

### Integration Testing
- Test complete invitation flow
- Test API integration
- Test organization selection
- Test different user scenarios (new vs existing)

## Security Considerations

### Authentication
- All API calls use Bearer token authentication
- Token managed through NestAuth provider
- Proper error handling for authentication failures

### Input Validation
- Server-side validation in addition to client-side
- Input sanitization and formatting
- Protection against injection attacks

### Authorization
- Users can only invite to organizations they belong to
- Organization membership verified server-side
- Proper access control enforcement

## Customization Options

### Styling
- Follows Material Design guidelines
- Customizable through Flutter theme system
- Responsive design for different screen sizes

### Behavior
- Configurable validation debounce timing
- Customizable dialog constraints
- Extensible validation rules

### Localization
- Full i18n support through slang package
- RTL language support
- Customizable error messages

## Migration Notes

### From person_form.dart
- Similar architecture and patterns
- Enhanced with progressive disclosure
- Conditional field display based on email validation
- Same API endpoint for consistency

### Breaking Changes
- None - this is a new form widget
- Can be used alongside existing person_form.dart
- Uses same backend API endpoints

## Troubleshooting

### Common Issues

1. **Email validation not working**
   - Check `validateEmailAsync2` function implementation
   - Verify API endpoint accessibility
   - Check authentication token validity

2. **Organization list not loading**
   - Verify `OrganizationListWidget` integration
   - Check organization data provider
   - Ensure user has organization memberships

3. **Form validation not updating**
   - Check `validateFormProvider` setup
   - Verify field value updates in central map
   - Ensure form code uniqueness

4. **Translation keys missing**
   - Run `dart run slang` to regenerate translations
   - Check `strings.i18n.json` for required keys
   - Verify build process includes translation generation

### Debug Logging

The form includes comprehensive logging:
- Form state changes
- Validation results
- API call details
- Error conditions

Enable debug logging by setting logger level to debug in your app configuration.
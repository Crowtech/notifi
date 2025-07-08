/// Widget keys and identifiers used throughout the Notifi application.
///
/// This file centralizes all string-based keys used for widget identification,
/// testing, analytics tracking, and navigation within the application. These
/// keys serve multiple purposes:
/// 
/// 1. **Widget Testing**: Enable reliable widget finding in automated tests
/// 2. **Analytics Tracking**: Provide consistent identifiers for user interaction tracking
/// 3. **Navigation**: Support deep linking and navigation state management
/// 4. **Debugging**: Facilitate debugging by providing semantic identifiers
/// 5. **Accessibility**: Support screen readers and accessibility tools
///
/// Key Categories:
/// - Authentication keys: For sign-in and authentication flows
/// - Navigation keys: For tabs, screens, and navigation elements
/// - UI Component keys: For buttons, dialogs, and interactive elements
///
/// Usage Example:
/// ```dart
/// // In widget definitions
/// ElevatedButton(
///   key: Key(Keys.logout),
///   onPressed: () => handleLogout(),
///   child: Text('Logout'),
/// )
/// 
/// // In tests
/// await tester.tap(find.byKey(Key(Keys.logout)));
/// ```
///
/// Best Practices:
/// - Use descriptive, kebab-case naming for consistency
/// - Group related keys together logically
/// - Keep keys stable - changing them breaks tests and analytics
/// - Use semantic names that clearly indicate the widget's purpose
///
/// Important: These keys are used across the entire application ecosystem
/// (app, tests, analytics). Changes should be coordinated across all systems.
class Keys {
  // Authentication and Sign-in Keys
  // These keys identify authentication-related widgets and flows
  
  /// Key for email/password authentication method selection.
  /// 
  /// Used in sign-in flows where users can choose between different
  /// authentication methods. This key identifies the email/password
  /// option specifically, enabling targeted testing and analytics
  /// for this authentication path.
  static const String emailPassword = 'email-password';

  /// Key for anonymous authentication method selection.
  /// 
  /// Used in sign-in flows for users who want to access the app
  /// without creating an account. This key tracks anonymous user
  /// onboarding and helps measure conversion rates from anonymous
  /// to authenticated users.
  static const String anonymous = 'anonymous';

  // Navigation and Tab Bar Keys
  // These keys identify main navigation elements and tabs
  
  /// Key for the main application tab bar widget.
  /// 
  /// This key identifies the primary navigation tab bar that allows
  /// users to switch between main sections of the app. Used for
  /// navigation testing and tracking user movement between sections.
  static const String tabBar = 'tabBar';

  /// Key for the Jobs tab in the main navigation.
  /// 
  /// Identifies the tab that leads to the jobs/work-related section
  /// of the application. This key enables specific testing of job
  /// functionality and analytics tracking of job-related user engagement.
  static const String jobsTab = 'jobsTab';

  /// Key for the Entries tab in the main navigation.
  /// 
  /// Identifies the tab that leads to the entries/records section
  /// of the application. This key supports testing of entry management
  /// features and tracking user interaction with entry-related content.
  static const String entriesTab = 'entriesTab';

  /// Key for the Account tab in the main navigation.
  /// 
  /// Identifies the tab that leads to user account settings and
  /// profile management. This key enables testing of account features
  /// and measuring user engagement with account management functionality.
  static const String accountTab = 'accountTab';

  // Action and Dialog Keys
  // These keys identify interactive elements and dialogs
  
  /// Key for logout action buttons and functionality.
  /// 
  /// Used to identify logout buttons, menu items, or any UI element
  /// that triggers the logout process. This key is crucial for
  /// testing authentication flows and measuring user session patterns.
  static const String logout = 'logout';

  /// Key for default/primary action buttons in alert dialogs.
  /// 
  /// Used to identify the primary action button in confirmation dialogs,
  /// alert messages, and other modal interactions. This key enables
  /// consistent testing of dialog interactions and user decision tracking.
  static const String alertDefault = 'alertDefault';

  /// Key for cancel action buttons in alert dialogs.
  /// 
  /// Used to identify cancel/dismiss buttons in confirmation dialogs
  /// and alert messages. This key supports testing of dialog cancellation
  /// flows and tracking user behavior in decision-making scenarios.
  static const String alertCancel = 'alertCancel';
}

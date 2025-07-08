/// Centralized string constants and localization keys for the Notifi application.
///
/// This file contains all user-facing text strings used throughout the application,
/// organized by functional areas and features. These strings serve as the foundation
/// for the app's user interface text and support future internationalization (i18n)
/// efforts.
///
/// String Organization:
/// - **Generic strings**: Common UI elements used across multiple screens
/// - **Authentication strings**: Sign-in, sign-up, and logout related text
/// - **Navigation strings**: Screen titles, tab labels, and navigation elements
/// - **Error messages**: User-friendly error descriptions and notifications
/// - **Success messages**: Confirmation and success feedback text
///
/// Usage Guidelines:
/// - Always use these constants instead of hardcoded strings in UI code
/// - Keep strings concise and user-friendly
/// - Use consistent terminology throughout the app
/// - Consider accessibility and screen reader compatibility
/// - Maintain consistent tone and voice across all user-facing text
///
/// Usage Example:
/// ```dart
/// // In widget code
/// ElevatedButton(
///   onPressed: () => handleSignIn(),
///   child: Text(Strings.signIn),
/// )
/// 
/// // In dialogs
/// showDialog(
///   context: context,
///   builder: (context) => AlertDialog(
///     title: Text(Strings.logout),
///     content: Text(Strings.logoutAreYouSure),
///     actions: [
///       TextButton(
///         onPressed: () => Navigator.pop(context),
///         child: Text(Strings.cancel),
///       ),
///       TextButton(
///         onPressed: () => performLogout(),
///         child: Text(Strings.ok),
///       ),
///     ],
///   ),
/// );
/// ```
///
/// Localization Considerations:
/// - These strings are the default (English) values
/// - String keys should remain stable to support translation workflows
/// - Consider text length variations in different languages
/// - Account for right-to-left (RTL) language support
/// - Avoid concatenating strings - use parameterized strings instead
///
/// Important: When adding new strings, follow the existing naming conventions
/// and group them logically. Changes to existing strings should be reviewed
/// for consistency across the entire user experience.
class Strings {
  // Generic and Common UI Strings
  // These strings are used across multiple screens and components
  // for consistent user experience and interaction patterns
  
  /// Standard confirmation button text.
  /// 
  /// Used in dialogs, alerts, and confirmation screens where users
  /// need to acknowledge or confirm an action. This provides a
  /// consistent confirmation experience across the app.
  static const String ok = 'OK';

  /// Standard cancellation button text.
  /// 
  /// Used in dialogs, forms, and modal screens where users can
  /// cancel or dismiss an action. This provides a consistent
  /// way to exit or cancel operations throughout the app.
  static const String cancel = 'Cancel';

  // Authentication and Session Management Strings
  // These strings support user authentication, session management,
  // and account-related functionality throughout the app
  
  /// Primary logout action text.
  /// 
  /// Used on buttons, menu items, and other UI elements that
  /// trigger the logout process. This text should be clear and
  /// direct to avoid user confusion about the action.
  static const String logout = 'Logout';

  /// Logout confirmation dialog message.
  /// 
  /// Presented to users when they attempt to logout to ensure
  /// they intended to end their session. This helps prevent
  /// accidental logouts and provides a clear confirmation step.
  static const String logoutAreYouSure =
      'Are you sure that you want to logout?';

  /// Logout failure error message.
  /// 
  /// Displayed when the logout process fails due to network issues,
  /// server errors, or other technical problems. This provides
  /// clear feedback about the unsuccessful logout attempt.
  static const String logoutFailed = 'Logout failed';

  // Sign-In and Authentication Flow Strings
  // These strings guide users through the authentication process
  // and provide clear options for different sign-in methods
  
  /// Primary sign-in action text.
  /// 
  /// Used on the main sign-in button and as screen titles for
  /// the authentication flow. This text should be welcoming
  /// and clearly indicate the authentication action.
  static const String signIn = 'Sign in';

  /// Email and password authentication method label.
  /// 
  /// Used to identify the traditional email/password sign-in
  /// option when multiple authentication methods are available.
  /// This helps users choose their preferred authentication method.
  static const String signInWithEmailPassword = 'Sign in with email & password';

  /// Anonymous access option label.
  /// 
  /// Used for the anonymous authentication option that allows
  /// users to access the app without creating an account.
  /// This provides a low-friction entry point for new users.
  static const String goAnonymous = 'Go anonymous';

  /// Separator text between authentication options.
  /// 
  /// Used to visually separate different authentication methods
  /// on the sign-in screen. This provides clear visual hierarchy
  /// and helps users understand their options.
  static const String or = 'or';

  /// Authentication failure error message.
  /// 
  /// Displayed when sign-in attempts fail due to invalid credentials,
  /// network issues, or other authentication problems. This provides
  /// clear feedback about unsuccessful authentication attempts.
  static const String signInFailed = 'Sign in failed';

  // Screen Titles and Navigation Labels
  // These strings provide consistent labeling for main application
  // screens and navigation elements throughout the user interface
  
  /// Home screen title and navigation label.
  /// 
  /// Used as the title for the main home screen and in navigation
  /// elements that lead to the home section. This provides users
  /// with a clear understanding of the app's main landing area.
  static const String homePage = 'Home Page';

  /// Jobs section title and navigation label.
  /// 
  /// Used as the title for the jobs/work-related section of the app
  /// and in navigation elements. This helps users identify and
  /// access job-related functionality within the application.
  static const String jobs = 'Jobs';

  /// Entries section title and navigation label.
  /// 
  /// Used as the title for the entries/records section of the app
  /// and in navigation elements. This helps users identify and
  /// access entry management functionality within the application.
  static const String entries = 'Entries';

  /// Account section navigation label.
  /// 
  /// Used in navigation elements that lead to account settings
  /// and profile management. This provides a clear, concise
  /// label for account-related functionality.
  static const String account = 'Account';

  /// Account screen title.
  /// 
  /// Used as the title for the account settings and profile
  /// management screen. This provides users with clear context
  /// about the current screen's purpose and functionality.
  static const String accountPage = 'Account Page';
}

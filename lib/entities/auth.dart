import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth.freezed.dart';

/// **Authentication Domain Entity**
/// 
/// Represents the authentication state of a user in the Notifi application.
/// This is a core domain entity that encapsulates the user's authentication
/// status and associated credentials when authenticated.
/// 
/// The entity follows a union type pattern using Freezed, providing two
/// distinct states: authenticated (SignedIn) and unauthenticated (SignedOut).
/// This design ensures type safety and prevents invalid state combinations.
/// 
/// **Business Rules:**
/// - A user can only be in one authentication state at a time
/// - When signed in, all user credentials must be present and valid
/// - Authentication state transitions are handled through the application's
///   authentication service layer
/// 
/// **Usage:**
/// ```dart
/// // Creating an authenticated user
/// final auth = Auth.signedIn(
///   id: 123,
///   displayName: 'John Doe',
///   email: 'john@example.com',
///   resourcecode: 'USER_001',
///   token: 'jwt_token_here'
/// );
/// 
/// // Creating an unauthenticated state
/// final auth = Auth.signedOut();
/// ```
@freezed
sealed class Auth with _$Auth {
  /// **Authenticated User State**
  /// 
  /// Represents a successfully authenticated user with full credentials.
  /// This state contains all necessary information to identify and authorize
  /// the user throughout the application.
  /// 
  /// **Properties:**
  /// - [id]: Unique numerical identifier for the user in the system
  /// - [displayName]: Human-readable name shown in the UI
  /// - [email]: User's email address, used for communication and identification
  /// - [resourcecode]: Internal resource identifier for access control
  /// - [token]: JWT or similar authentication token for API requests
  /// 
  /// **Business Rules:**
  /// - All properties are required and must be non-null
  /// - The token should be validated and not expired
  /// - The email should be a valid email format
  /// - The resourcecode follows the organization's naming conventions
  const factory Auth.signedIn({
    /// Unique identifier for the authenticated user
    /// 
    /// This ID is used throughout the application to reference the user
    /// in database operations, API calls, and business logic.
    required int id,
    
    /// Display name shown in the user interface
    /// 
    /// This is the human-readable name that appears in the UI, notifications,
    /// and other user-facing elements. It may differ from the user's legal name.
    required String displayName,
    
    /// User's email address
    /// 
    /// Primary email for the user account, used for:
    /// - Account identification and login
    /// - Communication and notifications
    /// - Password recovery and security alerts
    required String email,
    
    /// Internal resource code for access control
    /// 
    /// This identifier is used internally for resource access control,
    /// permissions management, and organizational hierarchy.
    required String resourcecode,
    
    /// Authentication token for API requests
    /// 
    /// JWT or similar token that provides authentication and authorization
    /// for API calls. Should be included in request headers for secured endpoints.
    required String token,
  }) = SignedIn;
  
  /// Private constructor for Freezed code generation
  /// 
  /// This enables the generated code to create instances with custom methods
  /// while maintaining immutability and the union type pattern.
  const Auth._();
  
  /// **Unauthenticated State**
  /// 
  /// Represents a user who is not currently authenticated.
  /// This is the default state when the application starts or after logout.
  /// 
  /// **Business Rules:**
  /// - No user credentials are stored in this state
  /// - The user has limited access to application features
  /// - Most authenticated operations should redirect to login
  const factory Auth.signedOut() = SignedOut;
  
  /// **Authentication Status Checker**
  /// 
  /// Convenience getter that returns true if the user is authenticated,
  /// false otherwise. This provides a simple way to check authentication
  /// status without pattern matching.
  /// 
  /// **Returns:**
  /// - `true` when the user is in [SignedIn] state
  /// - `false` when the user is in [SignedOut] state
  /// 
  /// **Usage:**
  /// ```dart
  /// if (auth.isAuth) {
  ///   // User is authenticated, proceed with secured operations
  ///   navigateToMainScreen();
  /// } else {
  ///   // User is not authenticated, redirect to login
  ///   navigateToLoginScreen();
  /// }
  /// ```
  bool get isAuth => switch (this) {
        SignedIn() => true,
        SignedOut() => false,
      };
}

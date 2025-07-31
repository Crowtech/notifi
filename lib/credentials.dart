/// Configuration and credential management for the Notifi library.
/// 
/// This module centralizes all environment-based configuration including
/// authentication settings, API endpoints, feature flags, and theming.
/// All values are loaded from environment variables at compile time.
library;

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart' as logger;

/// Logger instance with full stack trace for debugging
var log = logger.Logger(
  printer: logger.PrettyPrinter(),
  level: logger.Level.info,
);

/// Logger instance without stack trace for cleaner output
var logNoStack = logger.Logger(
  printer: logger.PrettyPrinter(methodCount: 0),
  level: logger.Level.info,
);

// Authentication Configuration
/// Keycloak/OIDC realm name for authentication
const _defaultRealm =
    String.fromEnvironment('AUTH_REALM', defaultValue: "crowtech");

/// Base URL for authentication services
const _defaultAuthBaseUrl = "https://${String.fromEnvironment('AUTH_BASE_URL',
    defaultValue: 'https://auth.crowtech.com.au')}";

// API Endpoints
/// Base URL for backend API services
const _defaultAPIBaseUrl = String.fromEnvironment('API_BASE_URL');

/// OpenID Connect discovery URL for authentication
const  _defaultDiscoveryUrl = "https://${String.fromEnvironment('AUTH_OPENID_URL')}";

/// OAuth2/OIDC client identifier
const _defaultClientId = String.fromEnvironment('AUTH_OPENID_CLIENT_ID');

/// OAuth2/OIDC client secret (should be secured in production)
const _defaultClientSecret =
    String.fromEnvironment('AUTH_OPENID_CLIENT_SECRET', defaultValue: "setme");

/// Path for mobile app redirects
const _defaultMobilePath = String.fromEnvironment('MOBILE_PATH');

/// OAuth2 redirect URL for authentication callbacks
const _defaultRedirectUrl = String.fromEnvironment('AUTH_OPENID_REDIRECT_URL');

/// Base URL for the authentication realm
const _defaultRealmBaseUrl = String.fromEnvironment('AUTH_REALM_BASE_URL');

/// Authorization endpoint URL for OAuth2 flow
const _defaultAuthEndpointUrl =
    "https://${String.fromEnvironment('AUTHORIZATION_ENDPOINT_URL')}";

// External Service Endpoints
/// MinIO object storage endpoint URL
const _defaultMinioEndpointUrl = String.fromEnvironment('MINIO_ENDPOINT_URL');

/// Image proxy service URL for secure image loading
const _defaultImageProxyUrl = String.fromEnvironment('IMAGE_PROXY_URL');

/// Tile server URL for map services
const _defaultTileServerUrl = String.fromEnvironment('TILE_SERVER_URL');

// Analytics and Third-Party Services
/// Flag to enable/disable PostHog analytics
const _enablePosthog = bool.fromEnvironment('ENABLE_POSTHOG');

/// PostHog project API key
const _posthogKey = String.fromEnvironment('POSTHOG_KEY');

/// Transistorsoft license key for background geolocation
const _transistorsoftKey = String.fromEnvironment('TRANSISTORSOFT_KEY');

/// VAPID key for web push notifications (FCM)
const _vapidKey = String.fromEnvironment('VAPID_KEY');

/// Display name for the application
const _displayName = String.fromEnvironment('DISPLAY_NAME');

/// iOS App Store ID for app updates and ratings
const _iosAppStoreId = String.fromEnvironment('APPSTOREID');

// API Configuration
/// API path prefix (e.g., '/api/v1')
const _defaultApiPrefixPath = String.fromEnvironment('API_PREFIX_PATH');

// Feature Flags
/// Skip login for development/testing
const _skipLogin = bool.fromEnvironment('SKIP_LOGIN', defaultValue: false);

/// Enable camera functionality
const _enableCamera =
    bool.fromEnvironment('ENABLE_CAMERA', defaultValue: false);

/// Enable location/GPS features
const _enableLocation =
    bool.fromEnvironment('ENABLE_LOCATION', defaultValue: false);

/// Enable push notifications
const _enableNotifications =
    bool.fromEnvironment('ENABLE_NOTIFICATIONS', defaultValue: false);

// Development/Testing Credentials
/// Test username for skip login mode
const _testUsername =
    String.fromEnvironment('TEST_USERNAME', defaultValue: "crowtech");

/// Test password for skip login mode
const _testPassword =
    String.fromEnvironment('TEST_PASSWORD', defaultValue: "password");

// Security
/// Default encryption key for local storage (should be changed in production)
const _defaultEncryptionKey =
    String.fromEnvironment('ENCRYPTION_KEY', defaultValue: "crowtech123456789");

// Theme Configuration
/// Primary theme color in hex format (ARGB)
const _seedColourHex =
    String.fromEnvironment('SEED_COLOUR_HEX', defaultValue: "#FF370883");

/// Hover/interaction color in hex format (ARGB)
const _hoverColourHex =
    String.fromEnvironment('HOVER_COLOUR_HEX', defaultValue: "#FF087F83");

// OAuth2/OIDC Configuration
/// Default audience for JWT tokens
const _defaultAudience = ["fieldservice"];

// Legal URLs
/// Privacy policy URL for the application
const _defaultPrivacyPolicyUrl = String.fromEnvironment('PRIVACY_POLICY_URL');

/// Terms and conditions URL for the application
const _defaultTermsAndConditionsUrl =
    String.fromEnvironment('TERMS_AND_CONDITIONS_URL');

/// OAuth2/OIDC scopes requested during authentication
const _defaultscopes = [
  "openid",      // Required for OIDC
  "profile",     // User profile information
  "email",       // Email address access
  "address",     // Physical address information
  "offline_access" // Refresh token support
];

// Public Getters for Authentication Configuration
/// Keycloak/OIDC realm name
String get defaultRealm => _defaultRealm;

/// Base URL for authentication services
String get defaultAuthBaseUrl => (_defaultAuthBaseUrl.contains('localhost')?'http':'https')+_defaultAuthBaseUrl.substring('https'.length);

/// OpenID Connect discovery URL
String get defaultDiscoveryUrl => (_defaultDiscoveryUrl.contains('localhost')?'http':'https')+_defaultDiscoveryUrl.substring('https'.length);

/// OAuth2/OIDC client ID
String get defaultClientId => _defaultClientId;

/// OAuth2/OIDC client secret
String get defaultClientSecret => _defaultClientSecret;

/// Mobile redirect path
String get defaultMobilePath => _defaultMobilePath;

/// OAuth2 redirect URL
String get defaultRedirectUrl => _defaultRedirectUrl;

/// Authentication realm base URL
String get defaultRealmBaseUrl => _defaultRealmBaseUrl;

/// Authorization endpoint URL
String get defaultAuthEndpointUrl => (_defaultAuthEndpointUrl.contains('localhost')?'http':'https')+_defaultAuthEndpointUrl.substring('https'.length);

// Public Getters for API Configuration
/// Backend API base URL
String get defaultAPIBaseUrl => _defaultAPIBaseUrl;

/// MinIO object storage endpoint
String get defaultMinioEndpointUrl => _defaultMinioEndpointUrl;

/// Image proxy service URL
String get defaultImageProxyUrl => _defaultImageProxyUrl;

/// Map tile server URL
String get defaultTileServerUrl => _defaultTileServerUrl;

/// iOS App Store identifier
String get iosAppStoreId => _iosAppStoreId;

// Public Getters for Feature Flags
/// Whether to skip login during development
bool get skipLogin => _skipLogin;

/// Whether camera features are enabled
bool get enableCamera => _enableCamera;

/// Whether location features are enabled
bool get enableLocation => _enableLocation;

/// Whether push notifications are enabled
bool get enableNotifications => _enableNotifications;

// Public Getters for Development Configuration
/// Test username for skip login mode
String get testUsername => _testUsername;

/// Test password for skip login mode
String get testPassword => _testPassword;

/// Encryption key for local storage
String get defaultEncryptionKey => _defaultEncryptionKey;

// Public Getters for OAuth2/OIDC Configuration
/// JWT token audience
List<String> get defaultAudience => _defaultAudience;

/// OAuth2 scopes
List<String> get defaultscopes => _defaultscopes;

/// API path prefix
String get defaultApiPrefixPath => _defaultApiPrefixPath;

// Public Getters for Third-Party Services
/// PostHog analytics enabled flag
bool get enablePosthog => _enablePosthog;

/// PostHog API key
String get posthogKey => _posthogKey;

/// Transistorsoft license key
String get transistorsoftKey => _transistorsoftKey;

/// Web push VAPID key
String get vapidKey => _vapidKey;

/// Application display name
String get displayName => _displayName;

// Public Getters for Legal URLs
/// Privacy policy URL
String get defaultPrivacyPolicyUrl => _defaultPrivacyPolicyUrl;

/// Terms and conditions URL
String get defaultTermsAndConditionsUrl => _defaultTermsAndConditionsUrl;

// Theme Color Getters
/// Primary theme color parsed from hex string
/// Converts ARGB hex format (e.g., #FF370883) to Color object
Color get colorSeed =>
    Color(int.parse(_seedColourHex.substring(1, 9), radix: 16));

/// Hover/interaction color parsed from hex string
/// Converts ARGB hex format (e.g., #FF087F83) to Color object
Color get colorHover =>
    Color(int.parse(_hoverColourHex.substring(1, 9), radix: 16));

/// Logs all configuration settings for debugging purposes.
/// 
/// This function outputs all environment-based configuration values
/// to help with debugging deployment issues and verifying settings.
/// Should only be called in development/debug builds.
/// 
/// **Security Note:** Be careful not to log sensitive values like
/// client secrets in production environments.
void showDefaultSettings() {
  logNoStack.i("Main:default Realm = $defaultRealm\n"
          "Main:default Auth Base URL = $defaultAuthBaseUrl\n"
          "Main:default Discovery URL = $defaultDiscoveryUrl\n" "Main:default ClientId = $defaultClientId\n" "Main:default Client Secret = $defaultClientSecret\n" "Main:default Redirect URL = $defaultRedirectUrl\n" "Main:default API Base URL = $defaultAPIBaseUrl\n" "Main:default API path prefix = $defaultApiPrefixPath\n" "Main:default Mobile Path = $defaultMobilePath\n" "Main:default Auth Endpoint URL = $defaultAuthEndpointUrl\n" "Main:defaultMinio URL = $defaultMinioEndpointUrl\n" "Main:defaultImageProxy URL = $defaultImageProxyUrl\n" "Main:defaultTileServer URL = $defaultTileServerUrl\n" "Main:vapidKey = $vapidKey\n" "Main:appStoreId = $iosAppStoreId\n" "Main: skip Login = ${skipLogin ? 'ON' : 'OFF'}\n" "Main: skip Login  username = $testUsername\n" "Main: skip Login  password = $testPassword\n" "Main: enable Camera = ${enableCamera ? 'ON' : 'OFF'}\n" "Main: enable Location = ${enableLocation ? 'ON' : 'OFF'}\n" "Main: enable Notifications = ${enableNotifications ? 'ON' : 'OFF'}\n" "Main: Ts & C url = $defaultTermsAndConditionsUrl\n" "Main: Privacy url = $defaultPrivacyPolicyUrl\n" "");
}

// Third-Party API Keys
/// The Movie Database (TMDB) API key for movie data
/// Used in the parking/movies demo feature
const String TMDB="257b974c5c902e99c85715956c8a0790";

/// The Movie Database (TMDB) read access token
/// JWT token for authenticated API requests to TMDB
const String TMDB_KEY="eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIyNTdiOTc0YzVjOTAyZTk5Yzg1NzE1OTU2YzhhMDc5MCIsIm5iZiI6MTY4MTM1OTQ0My40MzIsInN1YiI6IjY0Mzc4MjUzMzdiM2E5MDExMjAyMmVjYyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.mCOnpAvRuOUlTD6GGF7sIafKCfnrhHHVNTe4suz-ifU";

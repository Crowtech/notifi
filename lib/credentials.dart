import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart' as logger;

var log = logger.Logger(
  printer: logger.PrettyPrinter(),
  level: logger.Level.info,
);

var logNoStack = logger.Logger(
  printer: logger.PrettyPrinter(methodCount: 0),
  level: logger.Level.info,
);

const _defaultRealm =
    String.fromEnvironment('AUTH_REALM', defaultValue: "crowtech");

const _defaultAuthBaseUrl = String.fromEnvironment('AUTH_BASE_URL',
    defaultValue: 'https://auth.crowtech.com.au');

const _defaultAPIBaseUrl = String.fromEnvironment('API_BASE_URL');
const _defaultDiscoveryUrl = String.fromEnvironment('AUTH_OPENID_URL');

const _defaultClientId = String.fromEnvironment('AUTH_OPENID_CLIENT_ID');

const _defaultClientSecret =
    String.fromEnvironment('AUTH_OPENID_CLIENT_SECRET', defaultValue: "setme");

const _defaultMobilePath = String.fromEnvironment('MOBILE_PATH');

const _defaultRedirectUrl = String.fromEnvironment('AUTH_OPENID_REDIRECT_URL');

const _defaultRealmBaseUrl = String.fromEnvironment('AUTH_REALM_BASE_URL');

const _defaultAuthEndpointUrl =
    String.fromEnvironment('AUTHORIZATION_ENDPOINT_URL');

const _defaultMinioEndpointUrl = String.fromEnvironment('MINIO_ENDPOINT_URL');
const _defaultImageProxyUrl = String.fromEnvironment('IMAGE_PROXY_URL');
const _defaultTileServerUrl = String.fromEnvironment('TILE_SERVER_URL');

const _enablePosthog = bool.fromEnvironment('ENABLE_POSTHOG');
const _posthogKey = String.fromEnvironment('POSTHOG_KEY');
const _transistorsoftKey = String.fromEnvironment('TRANSISTORSOFT_KEY');
const _vapidKey = String.fromEnvironment('VAPID_KEY');
const _displayName = String.fromEnvironment('DISPLAY_NAME');
const _iosAppStoreId = String.fromEnvironment('IO_APPSTORE_ID');

const _defaultApiPrefixPath = String.fromEnvironment('API_PREFIX_PATH');

const _skipLogin = bool.fromEnvironment('SKIP_LOGIN', defaultValue: false);
const _enableCamera =
    bool.fromEnvironment('ENABLE_CAMERA', defaultValue: false);
const _enableLocation =
    bool.fromEnvironment('ENABLE_LOCATION', defaultValue: false);
const _enableNotifications =
    bool.fromEnvironment('ENABLE_NOTIFICATIONS', defaultValue: false);
const _testUsername =
    String.fromEnvironment('TEST_USERNAME', defaultValue: "crowtech");
const _testPassword =
    String.fromEnvironment('TEST_PASSWORD', defaultValue: "password");

const _defaultEncryptionKey =
    String.fromEnvironment('ENCRYPTION_KEY', defaultValue: "crowtech123456789");

const _seedColourHex =
    String.fromEnvironment('SEED_COLOUR_HEX', defaultValue: "#FF370883");
const _hoverColourHex =
    String.fromEnvironment('HOVER_COLOUR_HEX', defaultValue: "#FF087F83");

const _defaultAudience = ["fieldservice"];

const _defaultPrivacyPolicyUrl = String.fromEnvironment('PRIVACY_POLICY_URL');

const _defaultTermsAndConditionsUrl =
    String.fromEnvironment('TERMS_AND_CONDITIONS_URL');

const _defaultscopes = [
  "openid",
  "profile",
  "email",
  "address",
  "offline_access"
];

String get defaultRealm => _defaultRealm;
String get defaultAuthBaseUrl => _defaultAuthBaseUrl;
String get defaultDiscoveryUrl => _defaultDiscoveryUrl;
String get defaultClientId => _defaultClientId;
String get defaultClientSecret => _defaultClientSecret;
String get defaultMobilePath => _defaultMobilePath;
String get defaultRedirectUrl => _defaultRedirectUrl;
String get defaultRealmBaseUrl => _defaultRealmBaseUrl;
String get defaultAuthEndpointUrl => _defaultAuthEndpointUrl;
String get defaultAPIBaseUrl => _defaultAPIBaseUrl;
String get defaultMinioEndpointUrl => _defaultMinioEndpointUrl;
String get defaultImageProxyUrl => _defaultImageProxyUrl;
String get defaultTileServerUrl => _defaultTileServerUrl;
String get iosAppStoreId => _iosAppStoreId;

bool get skipLogin => _skipLogin;
bool get enableCamera => _enableCamera;
bool get enableLocation => _enableLocation;
bool get enableNotifications => _enableNotifications;

String get testUsername => _testUsername;
String get testPassword => _testPassword;
String get defaultEncryptionKey => _defaultEncryptionKey;

List<String> get defaultAudience => _defaultAudience;
List<String> get defaultscopes => _defaultscopes;
String get defaultApiPrefixPath => _defaultApiPrefixPath;
bool get enablePosthog => _enablePosthog;
String get posthogKey => _posthogKey;
String get transistorsoftKey => _transistorsoftKey;
String get vapidKey => _vapidKey;
String get displayName => _displayName;

String get defaultPrivacyPolicyUrl => _defaultPrivacyPolicyUrl;
String get defaultTermsAndConditionsUrl => _defaultTermsAndConditionsUrl;

Color get colorSeed =>
    Color(int.parse(_seedColourHex.substring(1, 9), radix: 16));
Color get colorHover =>
    Color(int.parse(_hoverColourHex.substring(1, 9), radix: 16));

void showDefaultSettings() {
  logNoStack.i("Main:default Realm = $defaultRealm\n"
          "Main:default Auth Base URL = $defaultAuthBaseUrl\n"
          "Main:default Discovery URL = $defaultDiscoveryUrl\n" "Main:default ClientId = $defaultClientId\n" "Main:default Client Secret = $defaultClientSecret\n" "Main:default Redirect URL = $defaultRedirectUrl\n" "Main:default API Base URL = $defaultAPIBaseUrl\n" "Main:default API path prefix = $defaultApiPrefixPath\n" "Main:default Mobile Path = $defaultMobilePath\n" "Main:default Auth Endpoint URL = $defaultAuthEndpointUrl\n" "Main:defaultMinio URL = $defaultMinioEndpointUrl\n" "Main:defaultImageProxy URL = $defaultImageProxyUrl\n" "Main:defaultTileServer URL = $defaultTileServerUrl\n" "Main:vapidKey = $vapidKey\n" "Main:appStoreId = $iosAppStoreId\n" "Main: skip Login = ${skipLogin ? 'ON' : 'OFF'}\n" "Main: skip Login  username = $testUsername\n" "Main: skip Login  password = $testPassword\n" "Main: enable Camera = ${enableCamera ? 'ON' : 'OFF'}\n" "Main: enable Location = ${enableLocation ? 'ON' : 'OFF'}\n" "Main: enable Notifications = ${enableNotifications ? 'ON' : 'OFF'}\n" +
      "Main: Ts & C url = $defaultTermsAndConditionsUrl\n" +
      "Main: Privacy url = $defaultPrivacyPolicyUrl\n" +
      "");
}

final _defaultRealm =
    const String.fromEnvironment('AUTH_REALM', defaultValue: "crowtech");

final _defaultAuthBaseUrl = const String.fromEnvironment('AUTH_BASE_URL',
    defaultValue: 'https://auth.crowtech.com.au');

final _defaultDiscoveryUrl = String.fromEnvironment('AUTH_OPENID_URL',
    defaultValue:
        '${defaultAuthBaseUrl}/realms/$defaultRealm/.well-known/openid-configuration');

final _defaultClientId = const String.fromEnvironment('AUTH_OPENID_CLIENT_ID',
    defaultValue: "panta");

final _defaultClientSecret = const String.fromEnvironment(
    'AUTH_OPENID_CLIENT_SECRET',
    defaultValue: "setme");

final _defaultRedirectUrl = const String.fromEnvironment(
    'AUTH_OPENID_REDIRECT_URL',
    defaultValue: "https://app.pantagroup.org/callback.html");

final _defaultRealmBaseUrl = String.fromEnvironment('AUTH_REALM_BASE_URL',
    defaultValue: '$defaultAuthBaseUrl/realms/$defaultRealm');

final _defaultAuthEndpointUrl = String.fromEnvironment(
    'AUTHORIZATION_ENDPOINT_URL',
    defaultValue: '$defaultRealmBaseUrl/protocol/openid-connect/auth');

final _defaultAPIBaseUrl = const String.fromEnvironment('API_BASE_URL',
    defaultValue: "https://api.pantagroup.org");

final _testUsername =
    const String.fromEnvironment('TEST_USERNAME', defaultValue: "crowtech");
final _testPassword =
    const String.fromEnvironment('TEST_PASSWORD', defaultValue: "password");

final _defaultEncryptionKey = const String.fromEnvironment('ENCRYPTION_KEY',
    defaultValue: "crowtech123456789");
final _defaultAudience = const ["fieldservice"];

final _defaultscopes = [
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
String get defaultRedirectUrl => _defaultRedirectUrl;
String get defaultRealmBaseUrl => _defaultRealmBaseUrl;
String get defaultAuthEndpointUrl => _defaultAuthEndpointUrl;
String get defaultAPIBaseUrl => _defaultAPIBaseUrl;
String get testUsername => _testUsername;
String get testPassword => _testPassword;
String get defaultEncryptionKey => _defaultEncryptionKey;
List<String> get defaultAudience => _defaultAudience;
List<String> get defaultscopes => _defaultscopes;

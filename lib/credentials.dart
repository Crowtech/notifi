import 'dart:ui';
import 'package:flutter/material.dart';

const _defaultRealm =
     String.fromEnvironment('AUTH_REALM', defaultValue: "crowtech");

const _defaultAuthBaseUrl = String.fromEnvironment('AUTH_BASE_URL',
    defaultValue: 'https://auth.crowtech.com.au');

const _defaultDiscoveryUrl = String.fromEnvironment('AUTH_OPENID_URL');

const _defaultClientId = String.fromEnvironment('AUTH_OPENID_CLIENT_ID');

const _defaultClientSecret = String.fromEnvironment(
    'AUTH_OPENID_CLIENT_SECRET',
    defaultValue: "setme");

const _defaultMobilePath = String.fromEnvironment(
    'MOBILE_PATH');

const _defaultRedirectUrl = String.fromEnvironment(
    'AUTH_OPENID_REDIRECT_URL');

const _defaultRealmBaseUrl = String.fromEnvironment('AUTH_REALM_BASE_URL');


const _defaultAuthEndpointUrl = String.fromEnvironment(
    'AUTHORIZATION_ENDPOINT_URL');

const _defaultMinioEndpointUrl = String.fromEnvironment(
    'MINIO_ENDPOINT_URL');

const _posthogKey = String.fromEnvironment('POSTHOG_KEY');
const _transistorsoftKey=String.fromEnvironment('TRANSISTORSOFT_KEY');
const _vapidKey=String.fromEnvironment('VAPID_KEY');
const _displayName=String.fromEnvironment('DISPLAY_NAME');

const _defaultAPIBaseUrl = String.fromEnvironment('API_BASE_URL');

const _defaultApiPrefixPath = String.fromEnvironment('API_PREFIX_PATH');

const _skipLogin = bool.fromEnvironment('SKIP_LOGIN', defaultValue: false);
const _enableCamera = bool.fromEnvironment('ENABLE_CAMERA', defaultValue: false);
const _testUsername = String.fromEnvironment('TEST_USERNAME', defaultValue: "crowtech");
const _testPassword = String.fromEnvironment('TEST_PASSWORD', defaultValue: "password");

const _defaultEncryptionKey = String.fromEnvironment('ENCRYPTION_KEY',
    defaultValue: "crowtech123456789");

const _seedColourHex = int.fromEnvironment('SEED_COLOUR_HEX', defaultValue: 0xffb74093);

const _defaultAudience = ["fieldservice"];

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

bool get skipLogin => _skipLogin;
bool get enableCamera => _enableCamera;
String get testUsername => _testUsername;
String get testPassword => _testPassword;
String get defaultEncryptionKey => _defaultEncryptionKey;

int get seedColourHex => _seedColourHex;

List<String> get defaultAudience => _defaultAudience;
List<String> get defaultscopes => _defaultscopes;
String get defaultApiPrefixPath => _defaultApiPrefixPath;
String get posthogKey => _posthogKey;
String get transistorsoftKey => _transistorsoftKey;
String get vapidKey => _vapidKey;
String get displayName => _displayName;

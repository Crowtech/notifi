import 'package:flutter/foundation.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../credentials.dart';
import 'dart:convert';
import 'package:universal_html/html.dart' as html;

class AuthService extends ChangeNotifier {
  final FlutterAppAuth _appAuth = const FlutterAppAuth();
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  
  String? _accessToken;
  String? _refreshToken;
  Map<String, dynamic>? _idToken;
  Map<String, dynamic>? _userInfo;
  
  static const String _accessTokenKey = 'access_token';
  static const String _refreshTokenKey = 'refresh_token';
  static const String _idTokenKey = 'id_token';
  static const String _userInfoKey = 'user_info';
  
  String get issuer => '$defaultAuthBaseUrl/realms/$defaultRealm';
  String get clientId => defaultClientId;
  String get redirectUrl {
    if (kIsWeb) {
      // For web, use the current origin
      final origin = html.window.location.origin ?? '';
      return '$origin/callback';
    }
    return defaultRedirectUrl;
  }
  
  bool get isAuthenticated => _accessToken != null;
  String? get accessToken => _accessToken;
  Map<String, dynamic>? get userInfo => _userInfo;
  
  String get userDisplayName {
    if (_userInfo != null) {
      final firstName = _userInfo!['given_name'] ?? _userInfo!['firstname'] ?? '';
      final lastName = _userInfo!['family_name'] ?? _userInfo!['lastname'] ?? '';
      if (firstName.isNotEmpty || lastName.isNotEmpty) {
        return '$firstName $lastName'.trim();
      }
      return _userInfo!['name'] ?? _userInfo!['preferred_username'] ?? 'User';
    }
    return 'User';
  }
  
  String get userEmail => _userInfo?['email'] ?? '';
  
  AuthService() {
    _loadStoredTokens();
  }
  
  Future<void> _loadStoredTokens() async {
    try {
      if (kIsWeb) {
        // For web, use localStorage
        _accessToken = html.window.localStorage[_accessTokenKey];
        _refreshToken = html.window.localStorage[_refreshTokenKey];
        final idTokenStr = html.window.localStorage[_idTokenKey];
        final userInfoStr = html.window.localStorage[_userInfoKey];
        
        if (idTokenStr != null) {
          _idToken = json.decode(idTokenStr);
        }
        if (userInfoStr != null) {
          _userInfo = json.decode(userInfoStr);
        }
      } else {
        // For mobile, use secure storage
        _accessToken = await _secureStorage.read(key: _accessTokenKey);
        _refreshToken = await _secureStorage.read(key: _refreshTokenKey);
        final idTokenStr = await _secureStorage.read(key: _idTokenKey);
        final userInfoStr = await _secureStorage.read(key: _userInfoKey);
        
        if (idTokenStr != null) {
          _idToken = json.decode(idTokenStr);
        }
        if (userInfoStr != null) {
          _userInfo = json.decode(userInfoStr);
        }
      }
      
      if (_accessToken != null) {
        // Verify token is still valid
        await _verifyToken();
      }
      
      notifyListeners();
    } catch (e) {
      print('Error loading stored tokens: $e');
    }
  }
  
  Future<bool> login() async {
    try {
      print('=== Mobile Authentication Login Started ===');
      print('Timestamp: ${DateTime.now().toIso8601String()}');
      print('Platform: ${kIsWeb ? 'Web' : 'Mobile'}');
      
      print('\n--- OAuth Configuration ---');
      print('Client ID: $clientId');
      print('Redirect URL: $redirectUrl');
      print('Issuer: $issuer');
      print('Scopes: [openid, profile, email]');
      
      print('\n--- Starting OAuth Flow ---');
      final stopwatch = Stopwatch()..start();
      
      final AuthorizationTokenResponse? result = await _appAuth.authorizeAndExchangeCode(
        AuthorizationTokenRequest(
          clientId,
          redirectUrl,
          issuer: issuer,
          scopes: ['openid', 'profile', 'email'],
          promptValues: ['login'],
        ),
      );
      
      stopwatch.stop();
      print('OAuth flow completed in: ${stopwatch.elapsedMilliseconds}ms');
      
      if (result != null) {
        print('\n--- OAuth Response Success ---');
        print('Access token received: ${result.accessToken != null ? 'Yes' : 'No'}');
        print('Refresh token received: ${result.refreshToken != null ? 'Yes' : 'No'}');
        print('ID token received: ${result.idToken != null ? 'Yes' : 'No'}');
        
        _accessToken = result.accessToken;
        _refreshToken = result.refreshToken;
        
        if (_accessToken != null) {
          print('Access token length: ${_accessToken!.length}');
          print('Access token preview: ${_accessToken!.substring(0, 50)}...');
        }
        
        // Parse ID token
        if (result.idToken != null) {
          print('\n--- Parsing ID Token ---');
          _idToken = _parseJwt(result.idToken!);
          _userInfo = _idToken;
          
          print('User info extracted:');
          print('  - Sub: ${_userInfo?['sub']}');
          print('  - Name: ${_userInfo?['name']}');
          print('  - Email: ${_userInfo?['email']}');
          print('  - Preferred username: ${_userInfo?['preferred_username']}');
          print('  - Roles: ${_userInfo?['realm_access']?['roles']}');
        }
        
        print('\n--- Saving Tokens ---');
        await _saveTokens();
        print('Tokens saved successfully');
        
        notifyListeners();
        print('\n=== Mobile Login Successful ===\n');
        return true;
      } else {
        print('\n--- OAuth Response Failed ---');
        print('Result is null - user may have cancelled or error occurred');
      }
      
      return false;
    } catch (e, stackTrace) {
      print('\n=== Mobile Login Error ===');
      print('Error type: ${e.runtimeType}');
      print('Error message: $e');
      print('\n--- Stack Trace ---');
      print(stackTrace.toString().split('\n').take(10).join('\n'));
      print('\n=== End Mobile Login Error ===\n');
      return false;
    }
  }
  
  Future<void> logout() async {
    try {
      // Clear tokens
      _accessToken = null;
      _refreshToken = null;
      _idToken = null;
      _userInfo = null;
      
      // Clear storage
      if (kIsWeb) {
        html.window.localStorage.remove(_accessTokenKey);
        html.window.localStorage.remove(_refreshTokenKey);
        html.window.localStorage.remove(_idTokenKey);
        html.window.localStorage.remove(_userInfoKey);
      } else {
        await _secureStorage.delete(key: _accessTokenKey);
        await _secureStorage.delete(key: _refreshTokenKey);
        await _secureStorage.delete(key: _idTokenKey);
        await _secureStorage.delete(key: _userInfoKey);
      }
      
      notifyListeners();
      
      // Redirect to Keycloak logout
      if (kIsWeb) {
        final origin = html.window.location.origin ?? '';
        final logoutUrl = '$issuer/protocol/openid-connect/logout?redirect_uri=${Uri.encodeComponent(origin)}';
        html.window.location.href = logoutUrl;
      }
    } catch (e) {
      print('Logout error: $e');
    }
  }
  
  Future<bool> refreshAccessToken() async {
    print('\n=== Mobile Token Refresh Started ===');
    print('Timestamp: ${DateTime.now().toIso8601String()}');
    
    if (_refreshToken == null) {
      print('ERROR: No refresh token available');
      return false;
    }
    
    print('Refresh token available: Yes');
    print('Refresh token length: ${_refreshToken!.length}');
    
    try {
      print('\n--- Token Refresh Request ---');
      print('Client ID: $clientId');
      print('Redirect URL: $redirectUrl');
      print('Issuer: $issuer');
      
      final stopwatch = Stopwatch()..start();
      
      final TokenResponse? result = await _appAuth.token(
        TokenRequest(
          clientId,
          redirectUrl,
          issuer: issuer,
          refreshToken: _refreshToken,
        ),
      );
      
      stopwatch.stop();
      print('Token refresh completed in: ${stopwatch.elapsedMilliseconds}ms');
      
      if (result != null && result.accessToken != null) {
        print('\n--- Token Refresh Success ---');
        print('New access token received: ${result.accessToken != null ? 'Yes' : 'No'}');
        print('New refresh token received: ${result.refreshToken != null ? 'Yes' : 'No'}');
        
        _accessToken = result.accessToken;
        if (result.refreshToken != null) {
          _refreshToken = result.refreshToken;
          print('Refresh token updated');
        }
        
        await _saveTokens();
        notifyListeners();
        print('\n=== Mobile Token Refresh Successful ===\n');
        return true;
      } else {
        print('\n--- Token Refresh Failed ---');
        print('Result is null or access token missing');
      }
      
      return false;
    } catch (e, stackTrace) {
      print('\n=== Mobile Token Refresh Error ===');
      print('Error: $e');
      print('Stack trace (first 5 lines):');
      print(stackTrace.toString().split('\n').take(5).join('\n'));
      print('\n=== End Mobile Token Refresh Error ===\n');
      return false;
    }
  }
  
  Future<void> _saveTokens() async {
    try {
      if (kIsWeb) {
        if (_accessToken != null) {
          html.window.localStorage[_accessTokenKey] = _accessToken!;
        }
        if (_refreshToken != null) {
          html.window.localStorage[_refreshTokenKey] = _refreshToken!;
        }
        if (_idToken != null) {
          html.window.localStorage[_idTokenKey] = json.encode(_idToken);
        }
        if (_userInfo != null) {
          html.window.localStorage[_userInfoKey] = json.encode(_userInfo);
        }
      } else {
        if (_accessToken != null) {
          await _secureStorage.write(key: _accessTokenKey, value: _accessToken);
        }
        if (_refreshToken != null) {
          await _secureStorage.write(key: _refreshTokenKey, value: _refreshToken);
        }
        if (_idToken != null) {
          await _secureStorage.write(key: _idTokenKey, value: json.encode(_idToken));
        }
        if (_userInfo != null) {
          await _secureStorage.write(key: _userInfoKey, value: json.encode(_userInfo));
        }
      }
    } catch (e) {
      print('Error saving tokens: $e');
    }
  }
  
  Future<void> _verifyToken() async {
    // Simple token verification - check if expired
    if (_idToken != null && _idToken!['exp'] != null) {
      final exp = _idToken!['exp'] as int;
      final now = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      
      if (now >= exp) {
        // Token expired, try to refresh
        final refreshed = await refreshAccessToken();
        if (!refreshed) {
          // Refresh failed, clear tokens
          await logout();
        }
      }
    }
  }
  
  Map<String, dynamic> _parseJwt(String token) {
    final parts = token.split('.');
    if (parts.length != 3) {
      throw Exception('Invalid token');
    }
    
    final payload = _decodeBase64(parts[1]);
    final payloadMap = json.decode(payload);
    if (payloadMap is! Map<String, dynamic>) {
      throw Exception('Invalid payload');
    }
    
    return payloadMap;
  }
  
  String _decodeBase64(String str) {
    String output = str.replaceAll('-', '+').replaceAll('_', '/');
    switch (output.length % 4) {
      case 0:
        break;
      case 2:
        output += '==';
        break;
      case 3:
        output += '=';
        break;
      default:
        throw Exception('Invalid base64 string');
    }
    return utf8.decode(base64Url.decode(output));
  }
}
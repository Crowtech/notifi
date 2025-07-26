import 'package:flutter/foundation.dart';
import '../credentials.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:universal_html/html.dart' as html;

class WebAuthService extends ChangeNotifier {
  final Dio _dio = Dio();
  
  String? _accessToken;
  String? _refreshToken;
  Map<String, dynamic>? _userInfo;
  
  static const String _accessTokenKey = 'access_token';
  static const String _refreshTokenKey = 'refresh_token';
  static const String _userInfoKey = 'user_info';
  
  String get keycloakUrl => defaultAuthBaseUrl;
  String get realm => defaultRealm;
  String get clientId => defaultClientId;
  
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
  
  WebAuthService() {
    _loadStoredTokens();
  }
  
  Future<void> _loadStoredTokens() async {
    try {
      if (kIsWeb) {
        _accessToken = html.window.localStorage[_accessTokenKey];
        _refreshToken = html.window.localStorage[_refreshTokenKey];
        final userInfoStr = html.window.localStorage[_userInfoKey];
        
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
  
  Future<bool> login(String username, String password) async {
    try {
      print('=== Web Authentication Login Started ===');
      print('Timestamp: ${DateTime.now().toIso8601String()}');
      print('Username: $username');
      print('Password length: ${password.length} characters');
      
      // Log environment configuration
      print('\n--- Environment Configuration ---');
      print('Keycloak URL: $keycloakUrl');
      print('Realm: $realm');
      print('Client ID: $clientId');
      
      // Validate configuration
      if (keycloakUrl.isEmpty || realm.isEmpty || clientId.isEmpty) {
        print('ERROR: Missing required configuration');
        print('  - keycloakUrl empty: ${keycloakUrl.isEmpty}');
        print('  - realm empty: ${realm.isEmpty}');
        print('  - clientId empty: ${clientId.isEmpty}');
        return false;
      }
      
      // Direct token request to Keycloak - following the same pattern as gettoken.sh
      final tokenUrl = '$keycloakUrl/realms/$realm/protocol/openid-connect/token';
      print('\n--- Token Request ---');
      print('Token URL: $tokenUrl');
      
      print('Request method: POST');
      print('Content-Type: application/x-www-form-urlencoded');
      print('Request payload:');
      print('  - grant_type: password');
      print('  - client_id: $clientId');
      print('  - username: $username');
      print('  - password: [REDACTED]');
      print('  - client_secret: [EMPTY]');
      
      final stopwatch = Stopwatch()..start();
      
      final response = await _dio.post(
        tokenUrl,
        data: {
          'grant_type': 'password',
          'client_id': clientId,
          'username': username,
          'password': password,
          'client_secret': '', // May be required by some Keycloak configurations
        },
        options: Options(
          headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
          },
          validateStatus: (status) => status != null && status < 500,
        ),
      );
      
      stopwatch.stop();
      print('\n--- Response ---');
      print('Response time: ${stopwatch.elapsedMilliseconds}ms');
      print('Status code: ${response.statusCode}');
      print('Status message: ${response.statusMessage}');
      
      if (response.statusCode == 200) {
        print('\n--- Token Response Success ---');
        final data = response.data;
        print('Access token received: ${data['access_token'] != null ? 'Yes' : 'No'}');
        print('Refresh token received: ${data['refresh_token'] != null ? 'Yes' : 'No'}');
        print('Token type: ${data['token_type'] ?? 'Not specified'}');
        print('Expires in: ${data['expires_in'] ?? 'Not specified'} seconds');
        
        _accessToken = data['access_token'];
        _refreshToken = data['refresh_token'];
        
        if (_accessToken != null) {
          print('Access token length: ${_accessToken!.length}');
          print('Access token preview: ${_accessToken!.substring(0, 50)}...');
        }
        
        // Parse user info from access token
        if (_accessToken != null) {
          print('\n--- Parsing Access Token ---');
          _userInfo = _parseJwt(_accessToken!);
          
          print('User info extracted:');
          print('  - Sub: ${_userInfo?['sub']}');
          print('  - Name: ${_userInfo?['name']}');
          print('  - Email: ${_userInfo?['email']}');
          print('  - Preferred username: ${_userInfo?['preferred_username']}');
          print('  - Roles: ${_userInfo?['realm_access']?['roles']}');
          print('  - Expires at: ${DateTime.fromMillisecondsSinceEpoch((_userInfo?['exp'] ?? 0) * 1000)}');
        }
        
        print('\n--- Saving Tokens ---');
        await _saveTokens();
        print('Tokens saved successfully');
        
        notifyListeners();
        print('\n=== Login Successful ===\n');
        return true;
      } else {
        print('\n--- Login Failed ---');
        print('Response body: ${response.data}');
        print('Headers: ${response.headers}');
      }
      
      print('Login failed with status: ${response.statusCode}');
      return false;
    } catch (e, stackTrace) {
      print('\n=== Login Error ===');
      print('Error type: ${e.runtimeType}');
      print('Error message: $e');
      
      if (e is DioException) {
        print('\n--- DioException Details ---');
        print('Type: ${e.type}');
        print('Message: ${e.message}');
        print('Response status: ${e.response?.statusCode}');
        print('Response data: ${e.response?.data}');
        print('Request URI: ${e.requestOptions.uri}');
        print('Request method: ${e.requestOptions.method}');
        print('Request headers: ${e.requestOptions.headers}');
        print('Request data: ${e.requestOptions.data}');
      }
      
      print('\n--- Stack Trace ---');
      print(stackTrace.toString().split('\n').take(10).join('\n'));
      print('\n=== End Login Error ===\n');
      return false;
    }
  }
  
  Future<void> logout() async {
    try {
      // Clear tokens
      _accessToken = null;
      _refreshToken = null;
      _userInfo = null;
      
      // Clear storage
      if (kIsWeb) {
        html.window.localStorage.remove(_accessTokenKey);
        html.window.localStorage.remove(_refreshTokenKey);
        html.window.localStorage.remove(_userInfoKey);
      }
      
      notifyListeners();
      
      print('Logout successful');
    } catch (e) {
      print('Logout error: $e');
    }
  }
  
  Future<bool> refreshAccessToken() async {
    print('\n=== Token Refresh Started ===');
    print('Timestamp: ${DateTime.now().toIso8601String()}');
    
    if (_refreshToken == null) {
      print('ERROR: No refresh token available');
      return false;
    }
    
    print('Refresh token available: Yes');
    print('Refresh token length: ${_refreshToken!.length}');
    
    try {
      final tokenUrl = '$keycloakUrl/realms/$realm/protocol/openid-connect/token';
      print('\n--- Refresh Request ---');
      print('Token URL: $tokenUrl');
      print('Client ID: $clientId');
      print('Grant type: refresh_token');
      
      final stopwatch = Stopwatch()..start();
      
      final response = await _dio.post(
        tokenUrl,
        data: {
          'grant_type': 'refresh_token',
          'client_id': clientId,
          'refresh_token': _refreshToken,
        },
        options: Options(
          headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
          },
          validateStatus: (status) => status != null && status < 500,
        ),
      );
      
      stopwatch.stop();
      print('\n--- Refresh Response ---');
      print('Response time: ${stopwatch.elapsedMilliseconds}ms');
      print('Status code: ${response.statusCode}');
      
      if (response.statusCode == 200) {
        print('Token refresh successful');
        final data = response.data;
        print('New access token received: ${data['access_token'] != null ? 'Yes' : 'No'}');
        print('New refresh token received: ${data['refresh_token'] != null ? 'Yes' : 'No'}');
        
        _accessToken = data['access_token'];
        if (data['refresh_token'] != null) {
          _refreshToken = data['refresh_token'];
          print('Refresh token updated');
        }
        
        // Update user info
        if (_accessToken != null) {
          _userInfo = _parseJwt(_accessToken!);
          print('User info updated from new token');
        }
        
        await _saveTokens();
        notifyListeners();
        print('\n=== Token Refresh Successful ===\n');
        return true;
      } else {
        print('\n--- Token Refresh Failed ---');
        print('Response data: ${response.data}');
      }
      
      return false;
    } catch (e, stackTrace) {
      print('\n=== Token Refresh Error ===');
      print('Error: $e');
      if (e is DioException) {
        print('DioException type: ${e.type}');
        print('Response status: ${e.response?.statusCode}');
        print('Response data: ${e.response?.data}');
      }
      print('Stack trace (first 5 lines):');
      print(stackTrace.toString().split('\n').take(5).join('\n'));
      print('\n=== End Token Refresh Error ===\n');
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
        if (_userInfo != null) {
          html.window.localStorage[_userInfoKey] = json.encode(_userInfo);
        }
      }
    } catch (e) {
      print('Error saving tokens: $e');
    }
  }
  
  Future<void> _verifyToken() async {
    // Simple token verification - check if expired
    if (_userInfo != null && _userInfo!['exp'] != null) {
      final exp = _userInfo!['exp'] as int;
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
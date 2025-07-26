import 'package:dio/dio.dart';
import 'package:notifi/models/person.dart';
import '../credentials.dart';
import '../models/paginated_response.dart';

import 'auth_service.dart';
import 'web_auth_service.dart';

class ApiService {
  late final Dio _dio;
  final AuthService? _authService;
  final WebAuthService? _webAuthService;
  
  String get baseUrl => '$defaultAPIBaseUrl$defaultApiPrefixPath';
  
  // Constructor for regular AuthService
  ApiService(this._authService) : _webAuthService = null {
    _initializeDio();
  }
  
  // Constructor for WebAuthService
  ApiService.fromWebAuth(this._webAuthService) : _authService = null {
    _initializeDio();
  }
  
  void _initializeDio() {
    _dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ));
    
    // Add auth interceptor
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = _authService?.accessToken ?? _webAuthService?.accessToken;
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
          print('API Request: ${options.method} ${options.uri}');
          print('  - Authorization: Bearer ${token.substring(0, 50)}...');
        } else {
          print('API Request: ${options.method} ${options.uri}');
          print('  - No authorization token available');
        }
        handler.next(options);
      },
      onError: (error, handler) async {
        print('\n--- API Error ---');
        print('Request: ${error.requestOptions.method} ${error.requestOptions.uri}');
        print('Status: ${error.response?.statusCode}');
        print('Message: ${error.message}');
        
        if (error.response?.statusCode == 401) {
          print('\n--- 401 Unauthorized - Attempting Token Refresh ---');
          // Try to refresh token
          bool refreshed = false;
          if (_authService != null) {
            print('Using mobile auth service for refresh');
            refreshed = await _authService.refreshAccessToken();
          } else if (_webAuthService != null) {
            print('Using web auth service for refresh');
            refreshed = await _webAuthService.refreshAccessToken();
          }
          
          print('Token refresh result: ${refreshed ? 'Success' : 'Failed'}');
          
          if (refreshed) {
            // Retry the request
            try {
              final newToken = _authService?.accessToken ?? _webAuthService?.accessToken;
              print('\n--- Retrying Request with New Token ---');
              print('New token length: ${newToken?.length ?? 0}');
              
              final response = await _dio.request(
                error.requestOptions.path,
                options: Options(
                  method: error.requestOptions.method,
                  headers: {
                    ...error.requestOptions.headers,
                    'Authorization': 'Bearer $newToken',
                  },
                ),
                data: error.requestOptions.data,
                queryParameters: error.requestOptions.queryParameters,
              );
              
              print('Retry successful: ${response.statusCode}');
              handler.resolve(response);
              return;
            } catch (e) {
              print('Retry failed: $e');
              handler.reject(error);
              return;
            }
          } else {
            print('Token refresh failed - rejecting request');
          }
        } else {
          print('Non-401 error or no auth service available');
        }
        
        print('--- End API Error ---\n');
        handler.reject(error);
      },
    ));
    
    // Add logging interceptor in debug mode
    _dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
      error: true,
    ));
  }
  
  // Convert query params to Nest filter format
  Map<String, dynamic> _buildNestFilter({
    int? page,
    int? size,
    String? search,
    String? sort,
    bool includeGPS = false,
  }) {
    String query = '';
    if (search != null && search.isNotEmpty) {
      if (search.contains(':') || search.contains('=')) {
        // Person provided a specific Nest filter query
        query = search;
      } else {
        // Search in NAME field (most common search case)
        query = ';NAME:$search';
      }
      print('Search input: "$search" -> Nest query: "$query"');
    }
    
    String sortBy = '';
    if (sort != null && sort.isNotEmpty) {
      final parts = sort.split(',');
      if (parts.isNotEmpty) {
        final field = parts[0];
        final direction = parts.length > 1 ? parts[1].toUpperCase() : 'ASC';
        sortBy = '$field $direction';
      }
    }
    
    final filter = {
      'query': query,
      'limit': size ?? 10,
      'offset': ((page ?? 0) * (size ?? 10)),
      'sortby': sortBy,
      'caseinsensitive': true,
      'orgIdList': [],
      'resourceCodeList': [],
      'deviceCodeList': [],
      'resourceIdList': [],
    };
    
    if (includeGPS) {
      filter['includeGPS'] = true;
    }
    
    print('Nest filter: $filter');
    return filter;
  }
  
  // Person endpoints
  Future<PaginatedResponse<Person>> getPersons({
    int? page,
    int? size,
    String? search,
    String? sort,
  }) async {
    try {
      final response = await _dio.post(
        '/resources/targets/0',
        data: _buildNestFilter(
          page: page,
          size: size,
          search: search,
          sort: sort,
          includeGPS: true,
        ),
      );
      
      return PaginatedResponse.fromApiResponse(
        response.data,
        (json) => Person.fromJson(json as Map<String, dynamic>),
      );
    } catch (e) {
      print('Error fetching users: $e');
      rethrow;
    }
  }
  
  Future<Person> getPerson(String id) async {
    try {
      // Try different query formats to fetch user with GPS data
      final queryFormats = [
        ';ID:$id',
        'ID:$id',
        ';id:$id',
        'id:$id',
        ';RESOURCE_ID:$id',
        'RESOURCE_ID:$id',
      ];
      
      for (final queryFormat in queryFormats) {
        try {
          final response = await _dio.post(
            '/resources/targets/0',
            data: _buildNestFilter(
              page: 0,
              size: 1,
              search: queryFormat,
              includeGPS: true,
            ),
          );
          
          final paginated = PaginatedResponse.fromApiResponse(
            response.data,
            (json) => Person.fromJson(json as Map<String, dynamic>),
          );
          
          if (paginated.content.isNotEmpty) {
            return paginated.content.first;
          }
        } catch (e) {
          // Try next format
        }
      }
      
      // Fallback to direct person endpoint
      final response = await _dio.get('/persons/$id');
      return Person.fromJson(response.data);
    } catch (e) {
      print('Error fetching user $id: $e');
      rethrow;
    }
  }
  
  Future<void> createPerson(Map<String, dynamic> userData) async {
    try {
      await _dio.post('/persons', data: userData);
    } catch (e) {
      print('Error creating user: $e');
      rethrow;
    }
  }
  
  Future<void> updatePerson(String id, Map<String, dynamic> userData) async {
    try {
      await _dio.put('/persons/$id', data: userData);
    } catch (e) {
      print('Error updating user $id: $e');
      rethrow;
    }
  }
  
  Future<void> deletePerson(String id) async {
    try {
      await _dio.delete('/persons/$id');
    } catch (e) {
      print('Error deleting user $id: $e');
      rethrow;
    }
  }
  
  // Organization endpoints (similar pattern)
  Future<PaginatedResponse<Map<String, dynamic>>> getOrganizations({
    int? page,
    int? size,
    String? search,
    String? sort,
  }) async {
    try {
      final response = await _dio.post(
        '/organizations/get',
        data: _buildNestFilter(
          page: page,
          size: size,
          search: search,
          sort: sort,
        ),
      );
      
      return PaginatedResponse.fromApiResponse(
        response.data,
        (json) => json as Map<String, dynamic>,
      );
    } catch (e) {
      print('Error fetching organizations: $e');
      rethrow;
    }
  }
  
  // GPS endpoints
  Future<void> submitGpsLocation(Map<String, dynamic> locationData) async {
    try {
      await _dio.post('/gps/location', data: locationData);
    } catch (e) {
      print('Error submitting GPS location: $e');
      rethrow;
    }
  }
}
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'api_client.g.dart';

/// Provides a configured Dio instance for API calls
@Riverpod(keepAlive: true)
Dio apiClient(ApiClientRef ref) {
  final dio = Dio();
  
  // Configure base options
  dio.options = BaseOptions(
    connectTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 30),
    sendTimeout: const Duration(seconds: 30),
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
  );
  
  // Add interceptors
  dio.interceptors.addAll([
    _LoggingInterceptor(),
    _ErrorInterceptor(),
    _AuthInterceptor(ref),
  ]);
  
  return dio;
}

/// Logging interceptor for debugging API calls
class _LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print('API Request: ${options.method} ${options.uri}');
    if (options.data != null) {
      print('Request Data: ${_formatJson(options.data)}');
    }
    handler.next(options);
  }
  
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print('API Response: ${response.statusCode} ${response.requestOptions.uri}');
    if (response.data != null) {
      print('Response Data: ${_formatJson(response.data)}');
    }
    handler.next(response);
  }
  
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    print('API Error: ${err.type} ${err.requestOptions.uri}');
    print('Error: ${err.error}');
    if (err.stackTrace != null) {
      print('Stack trace: ${err.stackTrace}');
    }
    handler.next(err);
  }
  
  String _formatJson(dynamic data) {
    try {
      if (data is String) return data;
      return const JsonEncoder.withIndent('  ').convert(data);
    } catch (e) {
      return data.toString();
    }
  }
}

/// Error interceptor for handling common API errors
class _ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // Transform errors into user-friendly messages
    String message;
    
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        message = 'Connection timeout. Please check your internet connection.';
        break;
      case DioExceptionType.connectionError:
        message = 'Unable to connect. Please check your internet connection.';
        break;
      case DioExceptionType.badResponse:
        message = _handleBadResponse(err.response);
        break;
      case DioExceptionType.cancel:
        message = 'Request cancelled';
        break;
      default:
        message = 'An unexpected error occurred';
    }
    
    // Create a new error with the user-friendly message
    handler.next(
      DioException(
        requestOptions: err.requestOptions,
        response: err.response,
        type: err.type,
        error: message,
        stackTrace: err.stackTrace,
      ),
    );
  }
  
  String _handleBadResponse(Response? response) {
    if (response == null) return 'No response from server';
    
    // Try to extract error message from response
    try {
      if (response.data is Map) {
        final error = response.data['error'] ?? 
                     response.data['message'] ?? 
                     response.data['detail'];
        if (error != null) return error.toString();
      }
    } catch (e) {
      // Ignore parsing errors
    }
    
    // Default messages based on status code
    switch (response.statusCode) {
      case 400:
        return 'Invalid request';
      case 401:
        return 'Authentication required';
      case 403:
        return 'Access denied';
      case 404:
        return 'Resource not found';
      case 429:
        return 'Too many requests. Please try again later.';
      case 500:
        return 'Server error. Please try again later.';
      default:
        return 'Request failed with status ${response.statusCode}';
    }
  }
}

/// Authentication interceptor for adding auth headers
class _AuthInterceptor extends Interceptor {
  final Ref ref;
  
  _AuthInterceptor(this.ref);
  
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    // Skip auth for certain endpoints
    if (_shouldSkipAuth(options.uri.toString())) {
      handler.next(options);
      return;
    }
    
    try {
      // Get auth token from your auth provider
      // Example: final token = await ref.read(authTokenProvider.future);
      // if (token != null) {
      //   options.headers['Authorization'] = 'Bearer $token';
      // }
    } catch (e) {
      print('Error adding auth header: $e');
    }
    
    handler.next(options);
  }
  
  bool _shouldSkipAuth(String url) {
    const skipPaths = [
      '/auth/login',
      '/auth/register',
      '/auth/refresh',
      '/public',
    ];
    
    return skipPaths.any((path) => url.contains(path));
  }
}

/// Base class for API repositories
abstract class BaseApiRepository {
  final Dio dio;
  final String baseUrl;
  
  BaseApiRepository({
    required this.dio,
    required this.baseUrl,
  });
  
  /// Make a GET request
  Future<T> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await dio.get<T>(
        '$baseUrl$path',
        queryParameters: queryParameters,
        cancelToken: cancelToken,
      );
      return response.data as T;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }
  
  /// Make a POST request
  Future<T> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await dio.post<T>(
        '$baseUrl$path',
        data: data,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
      );
      return response.data as T;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }
  
  /// Make a PUT request
  Future<T> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await dio.put<T>(
        '$baseUrl$path',
        data: data,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
      );
      return response.data as T;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }
  
  /// Make a DELETE request
  Future<T> delete<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await dio.delete<T>(
        '$baseUrl$path',
        queryParameters: queryParameters,
        cancelToken: cancelToken,
      );
      return response.data as T;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }
  
  /// Handle Dio errors and convert to app exceptions
  Exception _handleError(DioException error) {
    final message = error.error?.toString() ?? 'Unknown error occurred';
    
    switch (error.type) {
      case DioExceptionType.cancel:
        return CancelledException(message);
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return TimeoutException(message);
      case DioExceptionType.connectionError:
        return NetworkException(message);
      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode ?? 0;
        if (statusCode == 401) {
          return UnauthorizedException(message);
        } else if (statusCode == 403) {
          return ForbiddenException(message);
        } else if (statusCode == 404) {
          return NotFoundException(message);
        } else if (statusCode >= 500) {
          return ServerException(message);
        }
        return BadRequestException(message);
      default:
        return AppException(message);
    }
  }
}

/// Base exception class
class AppException implements Exception {
  final String message;
  
  AppException(this.message);
  
  @override
  String toString() => message;
}

/// Specific exception types
class NetworkException extends AppException {
  NetworkException(super.message);
}

class TimeoutException extends AppException {
  TimeoutException(super.message);
}

class UnauthorizedException extends AppException {
  UnauthorizedException(super.message);
}

class ForbiddenException extends AppException {
  ForbiddenException(super.message);
}

class NotFoundException extends AppException {
  NotFoundException(super.message);
}

class BadRequestException extends AppException {
  BadRequestException(super.message);
}

class ServerException extends AppException {
  ServerException(super.message);
}

class CancelledException extends AppException {
  CancelledException(super.message);
}
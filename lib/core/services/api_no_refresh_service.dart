import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' show VoidCallback, kDebugMode;
import 'package:medi_care_hub/core/constants/api_constants.dart';
import 'package:medi_care_hub/core/errors/failures.dart';
import 'package:medi_care_hub/core/services/token_service.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiService {
  final Dio _dio = Dio();
  final TokenService _tokenService;
  final Completer<void> _initializationCompleter = Completer<void>();
  final String _baseUrl = ApiConstants.baseUrl;

  // Notification callbacks
  VoidCallback? onUnauthorized;
  VoidCallback? onTokenExpired;

  ApiService(this._tokenService) {
    _initializeDio().then((_) => _initializationCompleter.complete());
  }

  Future<void> _initializeDio() async {
    _dio.options = BaseOptions(
      baseUrl: _baseUrl,
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    );

    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final authHeader = await _getValidAuthorizationHeader();
        if (authHeader != null) {
          options.headers['Authorization'] = authHeader;
        }
        handler.next(options);
      },
      onError: (DioException error, handler) async {
        if (error.response?.statusCode == 401) {
          await _handleUnauthorizedError();
          handler.reject(error);
        } else {
          handler.next(error);
        }
      },
    ));

    if (kDebugMode) {
      _dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        compact: false,
      ));
    }
  }

  Future<String?> _getValidAuthorizationHeader() async {
    final token = await _tokenService.getToken("accessToken");

    // Optional: Proactive token expiration check
    if (token != null && _isTokenExpired(token)) {
      if (onTokenExpired != null) {
        onTokenExpired!();
        return null;
      }
    }

    return token != null ? 'Bearer $token' : null;
  }

  bool _isTokenExpired(String token) {
    try {
      final parts = token.split('.');
      if (parts.length != 3) return true;

      final payload = json.decode(utf8.decode(base64Url
          .decode(parts[1].padRight((parts[1].length + 3) ~/ 4 * 4, '='))));

      final expiration = payload['exp'] as int?;
      if (expiration == null) return true;

      return DateTime.now().millisecondsSinceEpoch >= expiration * 1000;
    } catch (_) {
      return true;
    }
  }

  Future<void> _handleUnauthorizedError() async {
    await _logout();
    if (onUnauthorized != null) onUnauthorized!();
  }

  Future<void> _logout() async {
    await _tokenService.deleteToken("accessToken");
    _dio.options.headers.removeWhere((key, _) => key == 'Authorization');
  }

  Future<T> get<T>({
    required String endpoint,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    CancelToken? cancelToken,
  }) async {
    await _initializationCompleter.future;
    try {
      final response = await _dio.get<T>(
        endpoint,
        queryParameters: queryParameters,
        options: Options(headers: headers),
        cancelToken: cancelToken,
      );
      return response.data as T;
    } on DioException catch (e) {
      throw Failure.handle(e);
    }
  }

  Future<T> post<T>({
    required String endpoint,
    dynamic data,
    Map<String, dynamic>? headers,
    CancelToken? cancelToken,
  }) async {
    await _initializationCompleter.future;
    try {
      final response = await _dio.post<T>(
        endpoint,
        data: data,
        options: Options(headers: headers),
        cancelToken: cancelToken,
      );
      return response.data as T;
    } on DioException catch (e) {
      throw Failure.handle(e);
    }
  }

  Future<T> put<T>({
    required String endpoint,
    dynamic data,
    Map<String, dynamic>? headers,
    CancelToken? cancelToken,
  }) async {
    await _initializationCompleter.future;
    try {
      final response = await _dio.put<T>(
        endpoint,
        data: data,
        options: Options(headers: headers),
        cancelToken: cancelToken,
      );

      return response.data as T;
    } on DioException catch (e) {
      throw Failure.handle(e);
    }
  }

  Future<T> delete<T>({
    required String endpoint,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    CancelToken? cancelToken,
  }) async {
    await _initializationCompleter.future;
    try {
      final response = await _dio.delete<T>(
        endpoint,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
        cancelToken: cancelToken,
      );
      return response.data as T;
    } on DioException catch (e) {
      throw Failure.handle(e);
    }
  }
}

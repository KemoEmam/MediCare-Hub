// import 'dart:async';
// import 'dart:math';

// import 'package:dio/dio.dart';
// import 'package:flutter/foundation.dart' show kDebugMode;
// import 'package:medi_care_hub/core/constants/api_constants.dart';
// import 'package:medi_care_hub/core/errors/error_model/error_model.dart';
// import 'package:medi_care_hub/core/errors/failures.dart';
// import 'package:medi_care_hub/core/services/token_service.dart';
// import 'package:pretty_dio_logger/pretty_dio_logger.dart';

// class ApiService {
//   final Dio _dio = Dio();
//   final TokenService _tokenService;
//   final Completer<void> _initializationCompleter = Completer<void>();
//   final _maxRetryAttempts = 3;
//   final _retryDelayBase = const Duration(seconds: 1);
//   bool _isRefreshing = false;
//   Completer<void>? _refreshCompleter;
//   final String _baseUrl = ApiConstants.baseUrl;

//   ApiService(this._tokenService) {
//     _initializeDio().then((_) => _initializationCompleter.complete());
//   }

//   Future<void> _initializeDio() async {
//     _dio.options = BaseOptions(
//       baseUrl: _baseUrl,
//       connectTimeout: const Duration(seconds: 20),
//       receiveTimeout: const Duration(seconds: 20),
//       headers: {
//         'Accept': 'application/json',
//         'Content-Type': 'application/json',
//       },
//     );

//     _dio.interceptors.add(InterceptorsWrapper(
//       onRequest: (options, handler) async {
//         options.headers['Authorization'] = await _getAuthorizationHeader();
//         handler.next(options);
//       },
//       onError: (DioException error, handler) async {
//         if (error.response?.statusCode == 401) {
//           if (ApiConstants.refreshTokenEP.isEmpty) {
//             await _logout();
//             handler.reject(error);
//             return;
//           }
//           await _handleUnauthorizedError(error, handler);
//         } else if (_shouldRetry(error)) {
//           await _handleRetry(error, handler);
//         } else {
//           handler.next(error);
//         }
//       },
//     ));

//     if (kDebugMode) {
//       _dio.interceptors.add(PrettyDioLogger(
//         requestHeader: true,
//         requestBody: true,
//         responseBody: true,
//         responseHeader: false,
//         compact: false,
//       ));
//     }
//   }

//   // ================== Token Management ==================
//   Future<String> _getAuthorizationHeader() async {
//     final token = await _tokenService.getToken("accessToken");
//     return token != null ? 'Bearer $token' : '';
//   }

//   Future<void> _refreshToken() async {
//     final refreshToken = await _tokenService.getToken("refreshToken");
//     if (refreshToken == null) {
//       throw const ErrorModel(message: 'No refresh token available');
//     }

//     try {
//       final response = await _dio.post<Map<String, dynamic>>(
//         ApiConstants.refreshTokenEP,
//         data: {'refresh_token': refreshToken},
//       );

//       final newAccessToken = response.data?['accessToken'];
//       final newRefreshToken = response.data?['refreshToken'];

//       if (newAccessToken == null || newRefreshToken == null) {
//         throw const ErrorModel(message: 'Invalid token response');
//       }

//       // Validate tokens before saving
//       _validateToken(newAccessToken);
//       _validateToken(newRefreshToken);

//       await _tokenService.saveToken("accessToken", newAccessToken);
//       await _tokenService.saveToken("refreshToken", newRefreshToken);
//     } on DioException catch (e) {
//       await _logout();
//       throw Failure.handle(e);
//     }
//   }

//   void _validateToken(String token) {
//     if (token.isEmpty || token.split('.').length != 3) {
//       throw const ErrorModel(message: 'Invalid token format');
//     }
//   }

//   Future<void> _logout() async {
//     try {
//       await _dio.post(ApiConstants.logoutEP);
//     } finally {
//       await _tokenService.deleteToken("accessToken");
//       await _tokenService.deleteToken("refreshToken");
//       _dio.options.headers.remove('Authorization');
//     }
//   }

//   // ================== HTTP Methods ==================
//   Future<T> get<T>({
//     required String endpoint,
//     Map<String, dynamic>? queryParameters,
//     Map<String, dynamic>? headers,
//     CancelToken? cancelToken,
//   }) async {
//     await _initializationCompleter.future;
//     try {
//       final response = await _dio.get<T>(
//         endpoint,
//         queryParameters: queryParameters,
//         options: Options(headers: headers),
//         cancelToken: cancelToken,
//       );
//       return response.data as T;
//     } on DioException catch (e) {
//       throw Failure.handle(e);
//     }
//   }

//   Future<T> post<T>({
//     required String endpoint,
//     dynamic data,
//     Map<String, dynamic>? headers,
//     CancelToken? cancelToken,
//   }) async {
//     await _initializationCompleter.future;
//     try {
//       final response = await _dio.post<T>(
//         endpoint,
//         data: data,
//         options: Options(headers: headers),
//         cancelToken: cancelToken,
//       );
//       return response.data as T;
//     } on DioException catch (e) {
//       throw Failure.handle(e);
//     }
//   }

//   Future<T> put<T>({
//     required String endpoint,
//     dynamic data,
//     Map<String, dynamic>? headers,
//     CancelToken? cancelToken,
//   }) async {
//     await _initializationCompleter.future;
//     try {
//       final response = await _dio.put<T>(
//         endpoint,
//         data: data,
//         options: Options(headers: headers),
//         cancelToken: cancelToken,
//       );

//       return response.data as T;
//     } on DioException catch (e) {
//       throw Failure.handle(e);
//     }
//   }

//   Future<T> delete<T>({
//     required String endpoint,
//     dynamic data,
//     Map<String, dynamic>? queryParameters,
//     Map<String, dynamic>? headers,
//     CancelToken? cancelToken,
//   }) async {
//     await _initializationCompleter.future;
//     try {
//       final response = await _dio.delete<T>(
//         endpoint,
//         data: data,
//         queryParameters: queryParameters,
//         options: Options(headers: headers),
//         cancelToken: cancelToken,
//       );
//       return response.data as T;
//     } on DioException catch (e) {
//       throw Failure.handle(e);
//     }
//   }

//   // ================== Error Handling ==================
//   Future<void> _handleUnauthorizedError(
//       DioException error, ErrorInterceptorHandler handler) async {
//     if (_isRefreshing) {
//       await _refreshCompleter?.future;
//     } else {
//       _isRefreshing = true;
//       _refreshCompleter = Completer<void>();
//       try {
//         await _refreshToken();
//         _refreshCompleter?.complete();
//       } catch (e) {
//         _refreshCompleter?.completeError(e);
//         await _logout();
//         handler.reject(error);
//         return;
//       } finally {
//         _isRefreshing = false;
//         _refreshCompleter = null;
//       }
//     }

//     try {
//       error.requestOptions.headers['Authorization'] =
//           await _getAuthorizationHeader();
//       final response = await _retryRequest(error.requestOptions);
//       handler.resolve(response);
//     } catch (e) {
//       handler.reject(error);
//     }
//   }

//   Future<void> _handleRetry(
//       DioException error, ErrorInterceptorHandler handler) async {
//     final retryCount = (error.requestOptions.extra['retry_count'] ?? 0) + 1;
//     if (retryCount > _maxRetryAttempts) {
//       handler.next(error);
//       return;
//     }

//     final delay = _retryDelayBase * pow(2, retryCount);
//     error.requestOptions.extra['retry_count'] = retryCount;

//     await Future.delayed(delay);
//     try {
//       handler.resolve(await _dio.fetch(error.requestOptions));
//     } catch (e) {
//       handler.next(error);
//     }
//   }

//   bool _shouldRetry(DioException error) {
//     return error.type == DioExceptionType.connectionTimeout ||
//         error.type == DioExceptionType.receiveTimeout ||
//         error.type == DioExceptionType.sendTimeout ||
//         error.response?.statusCode == 429 ||
//         error.response?.statusCode == 503;
//   }

//   Future<Response<T>> _retryRequest<T>(RequestOptions requestOptions) async {
//     return _dio.fetch<T>(requestOptions);
//   }
// }

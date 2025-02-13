import 'package:dio/dio.dart';
import 'package:medi_care_hub/core/errors/error_model/error_model.dart';

class Failure {
  static ErrorModel handle(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionError:
          return const ErrorModel(
              message:
                  "Connection error. Please check your connection and try again.");
        case DioExceptionType.receiveTimeout:
          return const ErrorModel(
              message:
                  "Receive timeout. Please check your connection and try again.");
        case DioExceptionType.sendTimeout:
          return const ErrorModel(
              message:
                  "Send timeout. Please check your connection and try again.");
        case DioExceptionType.badResponse:
          return _handleError(error.response?.data);
        case DioExceptionType.cancel:
          return const ErrorModel(
              message:
                  "Request canceled. Please check your connection and try again.");
        case DioExceptionType.unknown:
          return const ErrorModel(
              message:
                  "Unknown error. Please check your connection and try again.");
        default:
          return const ErrorModel(
              message:
                  "Something went wrong. Please check your connection and try again.");
      }
    } else {
      return const ErrorModel(message: "Unknown error occured");
    }
  }
}

ErrorModel _handleError(dynamic data) {
  return ErrorModel(
    message: data['message'] ?? "Unknown error occured",
    status: data['status'],
    code: data['code'],
    //'data' is changable according to api end point
    errors: _parseErrors(data['data']),
  );
}

dynamic _parseErrors(dynamic errorData) {
  if (errorData is Map || errorData is List) return errorData;
  return null;
}

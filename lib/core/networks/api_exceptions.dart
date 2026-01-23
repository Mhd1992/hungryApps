import 'package:dio/dio.dart';
import 'package:hungry/core/networks/api_error.dart';

class ApiException implements Exception {
  ///ToDo refactor enhance handling error based on error.Type
  static ApiError handleError(DioException error) {
    final statusCode = error.response?.statusCode;
    final data = error.response?.data;
    if (data['message'] != null) {
      if (statusCode == 500) {
        return ApiError(message: data['message'], statusCode: statusCode);
      } else if (statusCode == 429) {
        return ApiError(message: data['message'], statusCode: statusCode);
      } else if (statusCode == 401) {
        return ApiError(message: data['message'], statusCode: statusCode);
      } else {
        return ApiError(message: data['message'], statusCode: statusCode);
      }
    }
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return ApiError(message: 'Bad Connection');

      case DioExceptionType.badResponse:
        return ApiError(message: error.toString());

      case DioExceptionType.connectionError:
        return ApiError(message: 'Check you Connection');

      case DioExceptionType.sendTimeout:
        return ApiError(message: 'Request timed out while sending data');

      case DioExceptionType.badCertificate:
        return ApiError(message: 'Invalid or untrusted SSL certificate.');

      default:
        return ApiError(message: 'Something went wrong.');
    }
  }
}

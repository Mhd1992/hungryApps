import 'package:dio/dio.dart';
import 'package:hungry/core/networks/api_errors.dart';

class ApiException implements Exception {
  static ApiError handleError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return ApiError(
          message: 'Connection timeout. Please try again later.',
          code: error.response?.statusCode ?? -1,
        );

      case DioExceptionType.badResponse:
        return ApiError(
          message: 'Bad response from server. Please try again later.',
          code: error.response?.statusCode ?? -1,
        );

      default:
        return ApiError(
          message: 'An unknown error occurred.',
          code: error.response?.statusCode ?? -1,
        );
    }
  }
}

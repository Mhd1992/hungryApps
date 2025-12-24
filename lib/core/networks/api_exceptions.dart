import 'package:dio/dio.dart';
import 'package:hungry/core/networks/api_error.dart';

import 'exceptions/errors.dart';

class ApiException implements Exception {
  static ApiError handleError(DioException error) {
    final statusCode = error.response?.statusCode;
    final data = error.response?.data;

    /// not best practice but to keep it simple for now
    if (data['message'] != null && statusCode! < 500) {
      return ApiError(message: data['message'], statusCode: statusCode);
    }

    switch (statusCode) {
      case 400:
        return ApiError(message: 'bad request');
      case 401:
        return ApiError(message: 'unauthorized request');

      case 404:
        return ApiError(message: 'not found content');

      case 500:
        return ApiError(message: 'Error on Server');

      default:
        return ApiError(message: 'unknown error occurred');
    }

    /* switch (error.response) {
      case DioExceptionType.:
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
    }*/
  }
}

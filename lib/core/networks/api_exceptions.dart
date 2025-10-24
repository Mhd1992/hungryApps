import 'package:dio/dio.dart';
import 'package:hungry/core/networks/api_error.dart';

class ApiException implements Exception {
  static ApiError handleError(DioException error) {
    final statusCode = error.response?.statusCode;
    final data = error.response?.data;
    if (data is Map<String, dynamic> && data['message'] != null) {
      print(data['message']);
      return ApiError(message: data['message'], statusCode: statusCode);
    }
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return ApiError(message: 'Bad Connection');

      case DioExceptionType.badResponse:
        return ApiError(message: error.toString());

      default:
        return ApiError(message: 'Something went wrong.');
    }
  }
}

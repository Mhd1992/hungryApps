import 'package:hungry/core/utils/exported_file.dart';

class DioClient {
  // Implementation of DioClient
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://sonic-zdi0.onrender.com/api',
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  );

  DioClient() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // You can add common headers or logging here
          final token = 'your_auth_token';
          if (token.isNotEmpty) {
            options.headers["Authorization"] = "Bearer $token";
          }
          return handler.next(options);
        },
        onResponse: (response, handler) {
          // Handle responses globally
          return handler.next(response);
        },
        onError: (DioError e, handler) {
          // Handle errors globally
          return handler.next(e);
        },
      ),
    );
  }
  Dio get dio => _dio;
}

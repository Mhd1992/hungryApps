import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hungry/core/utils/pref_helpers.dart' show PrefHelper;

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://sonic-zdi0.onrender.com/api',
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  );

  // Optional: interceptors
  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        // You can add common headers or logging here
        final token = await PrefHelper.getToken();
        if (token != null && token.isNotEmpty) {
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

  return dio;
});

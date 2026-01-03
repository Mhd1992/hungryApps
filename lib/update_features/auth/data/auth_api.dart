import 'package:dio/dio.dart';
import 'package:hungry/core/networks/base_response.dart';
import 'package:retrofit/retrofit.dart';

import 'auth_model.dart';

part 'auth_api.g.dart';

@RestApi(baseUrl: "https://sonic-zdi0.onrender.com/api")
abstract class AuthApi {
  factory AuthApi(Dio dio, {String baseUrl}) = _AuthApi;

  @POST("/login")
  Future<BaseResponse<AuthModel>> login(@Body() Map<String, dynamic> body);

  @POST("/register")
  Future<BaseResponse<AuthModel>> register(@Body() Map<String, dynamic> body);
}

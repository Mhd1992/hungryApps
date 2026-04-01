import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/networks/retrofit/model/base_response.dart';
import '../../model/auth_model.dart';

part 'auth_api.g.dart';

@RestApi(baseUrl: "https://sonic-zdi0.onrender.com/api")
abstract class AuthApi {
  factory AuthApi(Dio dio, {String baseUrl}) = _AuthApi;

  @POST("/login")
  Future<BaseResponse<AuthModel>> login(@Body() Map<String, dynamic> body);

  @POST("/register")
  Future<BaseResponse<AuthModel>> register(@Body() Map<String, dynamic> body);
}

import 'package:dio/dio.dart';
import 'package:hungry/core/networks/base_response.dart';
import 'package:retrofit/retrofit.dart';
import 'package:hungry/update_features/user/data/user_model.dart';

part 'user_api.g.dart';

@RestApi(baseUrl: "https://sonic-zdi0.onrender.com/api")
abstract class UserApi {
  factory UserApi(Dio dio, {String baseUrl}) = _UserApi;

  @GET("/profile")
  Future<BaseResponse<UserModel>> getProfile();

  @POST("/update-profile")
  Future<BaseResponse<UserModel>> updateUserData(@Body() FormData body);

  @POST("/logout")
  Future<BaseResponse<UserModel>> logout();
}

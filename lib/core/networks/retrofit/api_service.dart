import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:hungry/core/utils/exported_file.dart';
import 'model/base_response.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: "https://sonic-zdi0.onrender.com/api")
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  // ✅ Login request
  @POST("/login")
  Future<BaseResponse<UserModel>> login(@Body() Map<String, dynamic> body);

  // ✅ Get all users
  @GET("/users")
  Future<BaseResponse<List<UserModel>>> getUsers();

  // ✅ PUT request (generic)
  @PUT("/{endPoint}")
  Future<BaseResponse<dynamic>> putData(
    @Path("endPoint") String endPoint,
    @Body() Map<String, dynamic> body,
  );

  // ✅ DELETE request (generic)
  @DELETE("/{endPoint}")
  Future<BaseResponse<dynamic>> deleteData(
    @Path("endPoint") String endPoint,
    @Body() Map<String, dynamic> body,
  );

  // ✅ POST request (generic)
  @POST("/{endPoint}")
  Future<BaseResponse<dynamic>> postData(
    @Path("endPoint") String endPoint,
    @Body() Map<String, dynamic> body,
  );
}

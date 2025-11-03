import 'package:hungry/core/networks/retrofit/model/category/category_model.dart';
import 'package:hungry/core/networks/retrofit/model/products/product_model.dart';
import 'package:hungry/core/networks/retrofit/model/side_option/side_option_model.dart';
import 'package:hungry/core/networks/retrofit/model/topping/topping_model.dart';
import 'package:retrofit/retrofit.dart';
import 'package:hungry/core/utils/exported_file.dart';
import 'package:retrofit/retrofit.dart';
part 'api_service.g.dart';

@RestApi(baseUrl: "https://sonic-zdi0.onrender.com/api")
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  // ✅ Login request
  @POST("/login")
  Future<BaseResponse<UserModel>> login(@Body() Map<String, dynamic> body);

  @POST("/logout")
  Future<BaseResponse<dynamic>> logout();

  @POST("/register")
  Future<BaseResponse<UserModel>> register(@Body() Map<String, dynamic> body);

  @GET("/{endPoint}")
  Future<BaseResponse<UserModel>> profile(@Path("endPoint") String endPoint);

  // ✅ Get all users
  @GET("/users")
  Future<BaseResponse<List<UserModel>>> getUsers();

  @GET("/categories")
  Future<BaseResponse<List<CategoryModel>>> getCategories();

  @GET("/products")
  Future<BaseResponse<List<ProductModel>>> getProducts();

  @GET("/toppings")
  Future<BaseResponse<List<ToppingModel>>> getToppings();

  @GET("/side-options")
  Future<BaseResponse<List<SideOptionModel>>> getSideOptions();
  // ✅ PUT request (generic)
  @PUT("/{endPoint}")
  Future<BaseResponse<dynamic>> putData(
    @Path("endPoint") String endPoint,
    @Body() Map<String, dynamic> body,
  );

  @POST("/update-profile")
  Future<BaseResponse<UserModel>> updateUserData(@Body() FormData body);

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

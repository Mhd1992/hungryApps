import 'package:hungry/core/networks/retrofit/model/cart/cart_model.dart';
import 'package:hungry/core/networks/retrofit/model/cart/request_cart/cart_item_model.dart';
import 'package:hungry/core/utils/exported_file.dart';
import 'package:retrofit/retrofit.dart';

import 'model/cart/items/item_model.dart';
import 'model/orders/order_model.dart';

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

  @GET("/profile")
  Future<BaseResponse<UserModel>> getProfile();

  // ✅ Get all users
  @GET("/users")
  Future<BaseResponse<List<UserModel>>> getUsers();

  @GET("/categories")
  Future<BaseResponse<List<CategoryModel>>> getCategories();

  @GET("/products")
  Future<BaseResponse<List<ProductModel>>> getProducts();

  @GET("/toppings")
  Future<BaseResponse<List<ToppingModel>>> getToppings();

  @GET("/toppings/{id}")
  Future<BaseResponse<ToppingModel>> loadToppings(@Path("id") int id);

  @GET("/side-options")
  Future<BaseResponse<List<SideOptionModel>>> getSideOptions();
  // ✅ PUT request (generic)
  @PUT("/{endPoint}")
  Future<BaseResponse<dynamic>> putData(
    @Path("endPoint") String endPoint,
    @Body() Map<String, dynamic> body,
  );

  @POST("/cart/add")
  Future<BaseResponse<dynamic>> addToCaret(@Body() CartRequest caretModel);

  @POST("/orders")
  Future<BaseResponse<OrderModel>> checkOut(@Body() CartRequest caretModel);

  @GET("/cart")
  Future<BaseResponse<CartItemModel>> getCartItem();

  @POST("/update-profile")
  Future<BaseResponse<UserModel>> updateUserData(@Body() FormData body);

  @DELETE("/cart/remove/{id}")
  Future<BaseResponse<String>> removeFromCart(@Path("id") int id);

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

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../../../../core/networks/retrofit/model/base_response.dart';
import '../../../../core/constants/app_strings.dart';
import '../../cart/items/item_model.dart';
import '../../cart/request_cart/cart_item_model.dart';

part 'cart_api.g.dart';

@RestApi(baseUrl: baseUrl)
abstract class CartApi {
  factory CartApi(Dio dio, {String baseUrl}) = _CartApi;

  @GET("/cart")
  Future<BaseResponse<CartItemModel>> loadCartItem();

  @POST("/cart/add")
  Future<BaseResponse<CartItemModel?>> addToCaretItem(
    @Body() CartRequest caretModel,
  );

  @DELETE("/cart/remove/{id}")
  Future<BaseResponse<String?>> removeFromCartItem(@Path("id") int id);
}

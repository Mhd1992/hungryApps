import 'package:dio/dio.dart';
import 'package:hungry/update_features/cart/cart/items/item_model.dart';
import 'package:hungry/update_features/checkout/model/orders/created_order_model.dart';
import 'package:hungry/update_features/checkout/model/orders/order_model.dart';
import 'package:retrofit/retrofit.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/networks/retrofit/model/base_response.dart';
import '../model/order_item/item_detail_model.dart';

part 'checkout_api.g.dart';

@RestApi(baseUrl: baseUrl)
abstract class CheckoutApi {
  factory CheckoutApi(Dio dio, {String baseUrl}) = _CheckoutApi;

  @GET("/orders")
  Future<BaseResponse<List<OrderModel>>> getOrders();

  @GET("/orders/{id}")
  Future<BaseResponse<ItemDetailModel>> getOrder(@Path("id") int id);

  @POST("/orders")
  Future<BaseResponse<CreatedOrderModel>> saveOrder(
    @Body() CartRequest checkoutModel,
  );
}

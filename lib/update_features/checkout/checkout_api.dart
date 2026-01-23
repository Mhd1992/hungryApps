import 'package:dio/dio.dart';
import 'package:hungry/update_features/cart/cart/items/item_model.dart';
import 'package:hungry/update_features/checkout/model/orders/created_order_model.dart';
import 'package:hungry/update_features/checkout/model/orders/order_model.dart';
import 'package:retrofit/retrofit.dart';

import '../../core/constants/app_strings.dart';
import '../../core/networks/retrofit/model/base_response.dart';
import 'checkout_model.dart';

part 'checkout_api.g.dart';

@RestApi(baseUrl: baseUrl)
abstract class CheckoutApi {
  factory CheckoutApi(Dio dio, {String baseUrl}) = _CheckoutApi;

  @GET("/orders")
  Future<BaseResponse<OrderModel>> getOrders();

  @POST("/orders/{id}")
  Future<BaseResponse<dynamic>> getOrder(
    @Path("id") CheckoutModel checkoutModel,
  );

  @POST("/orders")
  Future<BaseResponse<CreatedOrderModel>> saveOrder(
    @Body() CartRequest checkoutModel,
  );
}

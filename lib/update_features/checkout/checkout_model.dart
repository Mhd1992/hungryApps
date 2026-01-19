import 'package:hungry/core/networks/retrofit/model/cart/cart_model.dart';
import 'package:json_annotation/json_annotation.dart';

import 'model/order_item/order_item_model.dart';
part 'checkout_model.g.dart';

@JsonSerializable()
class CheckoutModel {
  @JsonKey(name: "items")
  final List<OrderItemModel> orderItems;

  CheckoutModel(this.orderItems);

  factory CheckoutModel.fromJson(Map<String, dynamic> json) =>
      _$CheckoutModelFromJson(json);

  Map<String, dynamic> toJson() => _$CheckoutModelToJson(this);
}

import 'package:hungry/core/networks/retrofit/model/cart/cart_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'item_model.g.dart';

@JsonSerializable()
class CartRequest {
  final List<CartModel> items;

  CartRequest(this.items);

  factory CartRequest.fromJson(Map<String, dynamic> json) =>
      _$CartRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CartRequestToJson(this);
}

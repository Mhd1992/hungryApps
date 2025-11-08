import 'package:json_annotation/json_annotation.dart';

import 'cart_items.dart';
part 'cart_item_model.g.dart';

@JsonSerializable()
class CartItemModel {
  final int id;
  @JsonKey(name: "total_price")
  final dynamic totalPrice;
  final List<CartItems> items;

  CartItemModel(this.items, this.id, this.totalPrice);

  factory CartItemModel.fromJson(Map<String, dynamic> json) =>
      _$CartItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$CartItemModelToJson(this);
}

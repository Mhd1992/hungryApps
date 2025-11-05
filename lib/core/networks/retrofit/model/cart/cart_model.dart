import 'package:json_annotation/json_annotation.dart';
part 'cart_model.g.dart';

@JsonSerializable()
class CartModel {
  @JsonKey(name: "product_id")
  final int productId;
  @JsonKey(name: "quantity")
  final int quantity;
  @JsonKey(name: "spicy")
  final double spicyLevel;
  @JsonKey(name: "toppings")
  final List<int> toppingIds;
  @JsonKey(name: "side_options")
  final List<int> optionIds;
  CartModel(
    this.productId,
    this.quantity,
    this.spicyLevel,
    this.toppingIds,
    this.optionIds,
  );

  factory CartModel.fromJson(Map<String, dynamic> json) =>
      _$CartModelFromJson(json);

  Map<String, dynamic> toJson() => _$CartModelToJson(this);
}

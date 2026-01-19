import 'package:json_annotation/json_annotation.dart';
part 'order_item_model.g.dart';

@JsonSerializable()
class OrderItemModel {
  @JsonKey(name: "product_id")
  final int productId;
  @JsonKey(name: "quantity")
  final dynamic quantity;
  @JsonKey(name: "spicy")
  final dynamic spicyLevel;
  @JsonKey(name: "toppings")
  final List<int> toppingIds;
  @JsonKey(name: "side_options")
  final List<int> optionIds;
  OrderItemModel(
    this.productId,
    this.quantity,
    this.spicyLevel,
    this.toppingIds,
    this.optionIds,
  );

  factory OrderItemModel.fromJson(Map<String, dynamic> json) =>
      _$OrderItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderItemModelToJson(this);
}

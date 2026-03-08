import 'package:json_annotation/json_annotation.dart';

import '../../../products/product_details/side_option/data/side_option_model.dart';
import '../../../products/product_details/topping/data/topping_model.dart';
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
  final List<ToppingModel> toppingIds;
  @JsonKey(name: "side_options")
  final List<SideOptionModel> optionIds;
  final String name;
  final String price;
  final String image;

  OrderItemModel(
    this.productId,
    this.name,
    this.image,
    this.price,
    this.quantity,
    this.spicyLevel,
    this.toppingIds,
    this.optionIds,
  );

  factory OrderItemModel.fromJson(Map<String, dynamic> json) =>
      _$OrderItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderItemModelToJson(this);
}

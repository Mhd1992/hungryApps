import 'package:hungry/core/networks/retrofit/model/side_option/side_option_model.dart';
import 'package:hungry/core/networks/retrofit/model/topping/topping_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cart_items.g.dart';

@JsonSerializable()
class CartItems {
  @JsonKey(name: "item_id")
  final int itemId;
  @JsonKey(name: "product_id")
  final int productId;
  final String name;
  final int quantity; // stays final ✅
  @JsonKey(name: 'image')
  final String imageUrl;
  final dynamic price;
  final dynamic spicy;
  @JsonKey(name: "toppings")
  final List<ToppingModel> toppingIds;
  @JsonKey(name: "side_options")
  final List<SideOptionModel> optionIds;

  CartItems(
    this.itemId,
    this.productId,
    this.name,
    this.quantity,
    this.imageUrl,
    this.price,
    this.spicy,
    this.toppingIds,
    this.optionIds,
  );

  factory CartItems.fromJson(Map<String, dynamic> json) =>
      _$CartItemsFromJson(json);

  Map<String, dynamic> toJson() => _$CartItemsToJson(this);

  CartItems copyWith({int? quantity}) {
    return CartItems(
      itemId,
      productId,
      name,
      quantity ?? this.quantity,
      imageUrl,
      price,
      spicy,
      toppingIds,
      optionIds,
    );
  }
}

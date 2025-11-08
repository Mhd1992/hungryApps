// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_items.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartItems _$CartItemsFromJson(Map<String, dynamic> json) => CartItems(
      (json['item_id'] as num).toInt(),
      (json['product_id'] as num).toInt(),
      json['name'] as String,
      (json['quantity'] as num).toInt(),
      json['image'] as String,
      json['price'],
      json['spicy'],
      (json['toppings'] as List<dynamic>)
          .map((e) => ToppingModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['side_options'] as List<dynamic>)
          .map((e) => SideOptionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CartItemsToJson(CartItems instance) => <String, dynamic>{
      'item_id': instance.itemId,
      'product_id': instance.productId,
      'name': instance.name,
      'quantity': instance.quantity,
      'image': instance.imageUrl,
      'price': instance.price,
      'spicy': instance.spicy,
      'toppings': instance.toppingIds,
      'side_options': instance.optionIds,
    };

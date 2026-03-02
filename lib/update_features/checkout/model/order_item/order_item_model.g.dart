// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderItemModel _$OrderItemModelFromJson(Map<String, dynamic> json) =>
    OrderItemModel(
      (json['product_id'] as num).toInt(),
      json['name'] as String,
      json['image'] as String,
      json['price'] as String,
      json['quantity'],
      json['spicy'],
      (json['toppings'] as List<dynamic>)
          .map((e) => ToppingModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['side_options'] as List<dynamic>)
          .map((e) => SideOptionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OrderItemModelToJson(OrderItemModel instance) =>
    <String, dynamic>{
      'product_id': instance.productId,
      'quantity': instance.quantity,
      'spicy': instance.spicyLevel,
      'toppings': instance.toppingIds,
      'side_options': instance.optionIds,
      'name': instance.name,
      'price': instance.price,
      'image': instance.image,
    };

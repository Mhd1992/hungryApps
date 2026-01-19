// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderItemModel _$OrderItemModelFromJson(Map<String, dynamic> json) =>
    OrderItemModel(
      (json['product_id'] as num).toInt(),
      json['quantity'],
      json['spicy'],
      (json['toppings'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      (json['side_options'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
    );

Map<String, dynamic> _$OrderItemModelToJson(OrderItemModel instance) =>
    <String, dynamic>{
      'product_id': instance.productId,
      'quantity': instance.quantity,
      'spicy': instance.spicyLevel,
      'toppings': instance.toppingIds,
      'side_options': instance.optionIds,
    };

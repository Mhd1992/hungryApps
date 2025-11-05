// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartModel _$CartModelFromJson(Map<String, dynamic> json) => CartModel(
      (json['product_id'] as num).toInt(),
      (json['quantity'] as num).toInt(),
      (json['spicy'] as num).toDouble(),
      (json['toppings'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      (json['side_options'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
    );

Map<String, dynamic> _$CartModelToJson(CartModel instance) => <String, dynamic>{
      'product_id': instance.productId,
      'quantity': instance.quantity,
      'spicy': instance.spicyLevel,
      'toppings': instance.toppingIds,
      'side_options': instance.optionIds,
    };

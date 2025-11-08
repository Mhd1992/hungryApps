// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartItemModel _$CartItemModelFromJson(Map<String, dynamic> json) =>
    CartItemModel(
      (json['items'] as List<dynamic>)
          .map((e) => CartItems.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['id'] as num).toInt(),
      json['total_price'],
    );

Map<String, dynamic> _$CartItemModelToJson(CartItemModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'total_price': instance.totalPrice,
      'items': instance.items,
    };

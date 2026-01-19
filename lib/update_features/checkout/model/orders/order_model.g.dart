// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderModel _$OrderModelFromJson(Map<String, dynamic> json) => OrderModel(
      (json['id'] as num).toInt(),
      $enumDecode(_$OrderStatusEnumMap, json['status']),
      json['total_price'] as String,
      json['created_at'] as String,
      json['product_image'] as String,
    );

Map<String, dynamic> _$OrderModelToJson(OrderModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'status': _$OrderStatusEnumMap[instance.status]!,
      'total_price': instance.totalPrice,
      'created_at': instance.createdAt,
      'product_image': instance.productImage,
    };

const _$OrderStatusEnumMap = {
  OrderStatus.confirmed: 'confirmed',
  OrderStatus.rejected: 'rejected',
  OrderStatus.pending: 'pending',
};

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemDetailModel _$ItemDetailModelFromJson(Map<String, dynamic> json) =>
    ItemDetailModel(
      (json['id'] as num).toInt(),
      $enumDecode(_$OrderStatusEnumMap, json['status']),
      json['total_price'] as String,
      json['created_at'] as String,
      (json['items'] as List<dynamic>)
          .map((e) => OrderItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ItemDetailModelToJson(ItemDetailModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'status': _$OrderStatusEnumMap[instance.status]!,
      'total_price': instance.totalPrice,
      'created_at': instance.createdAt,
      'items': instance.orderItems,
    };

const _$OrderStatusEnumMap = {
  OrderStatus.confirmed: 'confirmed',
  OrderStatus.rejected: 'rejected',
  OrderStatus.pending: 'pending',
};

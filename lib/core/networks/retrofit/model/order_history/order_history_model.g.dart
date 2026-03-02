// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_history_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderHistory _$OrderHistoryFromJson(Map<String, dynamic> json) => OrderHistory(
  (json['id'] as num).toInt(),
  json['total_price'] as String,
  json['status'] as String,
  json['created_at'] as String,
  json['product_image'] as String,
);

Map<String, dynamic> _$OrderHistoryToJson(OrderHistory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'total_price': instance.totalPrice,
      'status': instance.status,
      'created_at': instance.createdAt,
      'product_image': instance.productImage,
    };

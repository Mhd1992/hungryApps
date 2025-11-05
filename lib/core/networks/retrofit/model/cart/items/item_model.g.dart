// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartRequest _$CartRequestFromJson(Map<String, dynamic> json) => CartRequest(
      (json['items'] as List<dynamic>)
          .map((e) => CartModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CartRequestToJson(CartRequest instance) =>
    <String, dynamic>{
      'items': instance.items,
    };

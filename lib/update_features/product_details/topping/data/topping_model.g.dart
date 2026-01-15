// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'topping_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ToppingModel _$ToppingModelFromJson(Map<String, dynamic> json) => ToppingModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      imageUrl: json['image'] as String,
    );

Map<String, dynamic> _$ToppingModelToJson(ToppingModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image': instance.imageUrl,
    };

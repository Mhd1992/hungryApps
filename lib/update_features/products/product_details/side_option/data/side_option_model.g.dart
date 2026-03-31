// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'side_option_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SideOptionModel _$SideOptionModelFromJson(Map<String, dynamic> json) =>
    SideOptionModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      imageUrl: json['image'] as String,
    );

Map<String, dynamic> _$SideOptionModelToJson(SideOptionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image': instance.imageUrl,
    };

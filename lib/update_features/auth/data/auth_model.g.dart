// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthModel _$AuthModelFromJson(Map<String, dynamic> json) => AuthModel(
  name: json['name'] as String,
  email: json['email'] as String,
  token: json['token'] as String?,
  image: json['image'] as String?,
);

Map<String, dynamic> _$AuthModelToJson(AuthModel instance) => <String, dynamic>{
  'name': instance.name,
  'email': instance.email,
  'token': instance.token,
  'image': instance.image,
};

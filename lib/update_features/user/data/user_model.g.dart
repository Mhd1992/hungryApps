// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      name: json['name'] as String,
      email: json['email'] as String,
      token: json['token'] as String?,
      image: json['image'] as String?,
      visa: json['Visa'] as String?,
      address: json['address'] as String?,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'token': instance.token,
      'image': instance.image,
      'Visa': instance.visa,
      'address': instance.address,
    };

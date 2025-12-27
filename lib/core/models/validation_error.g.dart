// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'validation_error.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ValidationResponse _$ValidationResponseFromJson(Map<String, dynamic> json) =>
    ValidationResponse(
      type: json['type'] as String?,
      titleValue: json['title'] as String?,
      messageValue: json['message'] as String?,
      errors: (json['errors'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as List<dynamic>),
          ) ??
          {},
    );

Map<String, dynamic> _$ValidationResponseToJson(ValidationResponse instance) =>
    <String, dynamic>{
      'type': instance.type,
      'title': instance.titleValue,
      'message': instance.messageValue,
      'errors': instance.errors,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paged_data_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PagedDataResponse<T> _$PagedDataResponseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    PagedDataResponse<T>(
      results:
          (json['results'] as List<dynamic>?)?.map(fromJsonT).toList() ?? [],
      currentPage: (json['currentPage'] as num).toInt(),
      pageSize: (json['pageSize'] as num).toInt(),
      total: (json['total'] as num).toInt(),
      lastPage: (json['lastPage'] as num).toInt(),
    );

Map<String, dynamic> _$PagedDataResponseToJson<T>(
  PagedDataResponse<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'results': instance.results.map(toJsonT).toList(),
      'currentPage': instance.currentPage,
      'pageSize': instance.pageSize,
      'total': instance.total,
      'lastPage': instance.lastPage,
    };

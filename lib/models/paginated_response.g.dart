// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paginated_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaginatedResponse<T> _$PaginatedResponseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    PaginatedResponse<T>(
      content: (json['content'] as List<dynamic>).map(fromJsonT).toList(),
      totalElements: (json['totalElements'] as num).toInt(),
      totalPages: (json['totalPages'] as num).toInt(),
      size: (json['size'] as num).toInt(),
      number: (json['number'] as num).toInt(),
      first: json['first'] as bool,
      last: json['last'] as bool,
    );

Map<String, dynamic> _$PaginatedResponseToJson<T>(
  PaginatedResponse<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'content': instance.content.map(toJsonT).toList(),
      'totalElements': instance.totalElements,
      'totalPages': instance.totalPages,
      'size': instance.size,
      'number': instance.number,
      'first': instance.first,
      'last': instance.last,
    };

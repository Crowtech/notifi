// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nperson_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NPersonsResponseImpl _$$NPersonsResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$NPersonsResponseImpl(
      page: (json['startIndex'] as num).toInt(),
      results: (json['items'] as List<dynamic>)
          .map((e) => NPerson.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalResults: (json['resultCount'] as num).toInt(),
      totalPages: (json['totalItems'] as num).toInt(),
      errors: (json['errors'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$NPersonsResponseImplToJson(
        _$NPersonsResponseImpl instance) =>
    <String, dynamic>{
      'startIndex': instance.page,
      'items': instance.results,
      'resultCount': instance.totalResults,
      'totalItems': instance.totalPages,
      'errors': instance.errors,
    };

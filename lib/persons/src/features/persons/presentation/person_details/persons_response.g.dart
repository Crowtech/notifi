// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'persons_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PersonsResponse _$PersonsResponseFromJson(Map<String, dynamic> json) =>
    _PersonsResponse(
      startIndex: (json['startIndex'] as num?)?.toInt(),
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => Person.fromJson(e as Map<String, dynamic>))
          .toList(),
      resultCount: (json['resultCount'] as num?)?.toInt(),
      totalItems: (json['totalItems'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PersonsResponseToJson(_PersonsResponse instance) =>
    <String, dynamic>{
      'startIndex': instance.startIndex,
      'items': instance.items,
      'resultCount': instance.resultCount,
      'totalItems': instance.totalItems,
    };

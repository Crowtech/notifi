// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'npersons_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NPersonsResponse _$NPersonsResponseFromJson(Map<String, dynamic> json) =>
    NPersonsResponse(
      startIndex: (json['startIndex'] as num).toInt(),
      items: (json['items'] as List<dynamic>)
          .map((e) => NPerson.fromJson(e as Map<String, dynamic>))
          .toList(),
      resultCount: (json['resultCount'] as num).toInt(),
      totalItems: (json['totalItems'] as num).toInt(),
    );

Map<String, dynamic> _$NPersonsResponseToJson(NPersonsResponse instance) =>
    <String, dynamic>{
      'startIndex': instance.startIndex,
      'items': instance.items,
      'resultCount': instance.resultCount,
      'totalItems': instance.totalItems,
    };

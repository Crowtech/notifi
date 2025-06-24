// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'npersons_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NPersonsResponse _$NPersonsResponseFromJson(Map<String, dynamic> json) =>
    NPersonsResponse(
      page: (json['page'] as num).toInt(),
      results: (json['results'] as List<dynamic>)
          .map((e) => NPerson.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalResults: (json['totalResults'] as num).toInt(),
      totalPages: (json['totalPages'] as num).toInt(),
    );

Map<String, dynamic> _$NPersonsResponseToJson(NPersonsResponse instance) =>
    <String, dynamic>{
      'page': instance.page,
      'results': instance.results,
      'totalResults': instance.totalResults,
      'totalPages': instance.totalPages,
    };

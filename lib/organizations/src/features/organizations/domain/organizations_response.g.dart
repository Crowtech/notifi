// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'organizations_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrganizationsResponse _$OrganizationsResponseFromJson(
        Map<String, dynamic> json) =>
    OrganizationsResponse(
      page: (json['page'] as num).toInt(),
      results: (json['results'] as List<dynamic>)
          .map((e) => Organization.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalResults: (json['totalResults'] as num).toInt(),
      totalPages: (json['totalPages'] as num).toInt(),
    );

Map<String, dynamic> _$OrganizationsResponseToJson(
        OrganizationsResponse instance) =>
    <String, dynamic>{
      'page': instance.page,
      'results': instance.results,
      'totalResults': instance.totalResults,
      'totalPages': instance.totalPages,
    };

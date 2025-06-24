// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'organizations_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_OrganizationsResponse _$OrganizationsResponseFromJson(
        Map<String, dynamic> json) =>
    _OrganizationsResponse(
      page: (json['startIndex'] as num).toInt(),
      results: (json['items'] as List<dynamic>)
          .map((e) => Organization.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalResults: (json['resultCount'] as num).toInt(),
      totalPages: (json['totalItems'] as num).toInt(),
      errors: (json['errors'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$OrganizationsResponseToJson(
        _OrganizationsResponse instance) =>
    <String, dynamic>{
      'startIndex': instance.page,
      'items': instance.results,
      'resultCount': instance.totalResults,
      'totalItems': instance.totalPages,
      'errors': instance.errors,
    };

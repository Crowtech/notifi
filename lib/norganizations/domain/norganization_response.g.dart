// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'norganization_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_NOrganizationsResponse _$NOrganizationsResponseFromJson(
        Map<String, dynamic> json) =>
    _NOrganizationsResponse(
      page: (json['startIndex'] as num).toInt(),
      results: (json['items'] as List<dynamic>)
          .map((e) => NOrganization.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalResults: (json['resultCount'] as num).toInt(),
      totalPages: (json['totalItems'] as num).toInt(),
      errors: (json['errors'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$NOrganizationsResponseToJson(
        _NOrganizationsResponse instance) =>
    <String, dynamic>{
      'startIndex': instance.page,
      'items': instance.results,
      'resultCount': instance.totalResults,
      'totalItems': instance.totalPages,
      'errors': instance.errors,
    };

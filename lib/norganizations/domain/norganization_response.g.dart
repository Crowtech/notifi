// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'norganization_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_NOrganizationsResponse _$NOrganizationsResponseFromJson(
        Map<String, dynamic> json) =>
    _NOrganizationsResponse(
      startIndex: (json['startIndex'] as num).toInt(),
      items: (json['items'] as List<dynamic>)
          .map((e) => NOrganization.fromJson(e as Map<String, dynamic>))
          .toList(),
      resultCount: (json['resultCount'] as num).toInt(),
      totalItems: (json['totalItems'] as num).toInt(),
      errors: (json['errors'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$NOrganizationsResponseToJson(
        _NOrganizationsResponse instance) =>
    <String, dynamic>{
      'startIndex': instance.startIndex,
      'items': instance.items,
      'resultCount': instance.resultCount,
      'totalItems': instance.totalItems,
      'errors': instance.errors,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'organizations_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrganizationsResponse _$OrganizationsResponseFromJson(
        Map<String, dynamic> json) =>
    OrganizationsResponse(
      startIndex: (json['startIndex'] as num).toInt(),
      items: (json['items'] as List<dynamic>)
          .map((e) => Organization.fromJson(e as Map<String, dynamic>))
          .toList(),
      resultCount: (json['resultCount'] as num).toInt(),
      totalItems: (json['totalItems'] as num).toInt(),
    );

Map<String, dynamic> _$OrganizationsResponseToJson(
        OrganizationsResponse instance) =>
    <String, dynamic>{
      'startIndex': instance.startIndex,
      'items': instance.items,
      'resultCount': instance.resultCount,
      'totalItems': instance.totalItems,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'norganization.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NOrganization _$NOrganizationFromJson(Map<String, dynamic> json) =>
    NOrganization(
      orgid: (json['orgid'] as num?)?.toInt(),
      id: (json['id'] as num?)?.toInt(),
      code: json['code'] as String?,
      created: json['created'] == null
          ? null
          : DateTime.parse(json['created'] as String),
      updated: json['updated'] == null
          ? null
          : DateTime.parse(json['updated'] as String),
      name: json['name'] as String?,
      description: json['description'] as String?,
      location: json['location'] as String?,
      devicecode: json['devicecode'] as String?,
      avatarUrl: json['avatarUrl'] as String?,
      gps: json['gps'] == null
          ? null
          : GPS.fromJson(json['gps'] as Map<String, dynamic>),
      orgType: json['orgType'] as String,
      url: json['url'] as String,
    );

Map<String, dynamic> _$NOrganizationToJson(NOrganization instance) =>
    <String, dynamic>{
      'orgid': instance.orgid,
      'id': instance.id,
      'created': instance.created?.toIso8601String(),
      'code': instance.code,
      'updated': instance.updated?.toIso8601String(),
      'name': instance.name,
      'description': instance.description,
      'location': instance.location,
      'devicecode': instance.devicecode,
      'avatarUrl': instance.avatarUrl,
      'gps': instance.gps?.toJson(),
      'orgType': instance.orgType,
      'url': instance.url,
    };

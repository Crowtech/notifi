// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appversion.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppVersion _$AppVersionFromJson(Map<String, dynamic> json) => AppVersion(
      id: (json['id'] as num?)?.toInt(),
      code: json['code'] as String?,
      created: json['created'] == null
          ? null
          : DateTime.parse(json['created'] as String),
      updated: json['updated'] == null
          ? null
          : DateTime.parse(json['updated'] as String),
      name: json['name'] as String?,
      version: json['version'] as String?,
      buildNumber: json['buildNumber'] as String?,
      dockerId: json['dockerId'] as String?,
    );

Map<String, dynamic> _$AppVersionToJson(AppVersion instance) =>
    <String, dynamic>{
      'id': instance.id,
      'created': instance.created?.toIso8601String(),
      'code': instance.code,
      'updated': instance.updated?.toIso8601String(),
      'name': instance.name,
      'version': instance.version,
      'buildNumber': instance.buildNumber,
      'dockerId': instance.dockerId,
    };

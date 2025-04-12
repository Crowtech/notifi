// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'artifact.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Artifact _$ArtifactFromJson(Map<String, dynamic> json) => Artifact(
      id: (json['id'] as num?)?.toInt(),
      code: json['code'] as String?,
      created: json['created'] == null
          ? null
          : DateTime.parse(json['created'] as String),
      active: json['active'] as bool?,
      updated: json['updated'] == null
          ? null
          : DateTime.parse(json['updated'] as String),
      name: json['name'] as String?,
      description: json['description'] as String?,
      location: json['location'] as String?,
      devicecode: json['devicecode'] as String?,
      avatarUrl: json['avatarUrl'] as String?,
      author: Resource.fromJson(json['author'] as Map<String, dynamic>),
      expiry: DateTime.parse(json['expiry'] as String),
      gps: json['gps'] == null
          ? null
          : GPS.fromJson(json['gps'] as Map<String, dynamic>),
    )
      ..orgid = (json['orgid'] as num?)?.toInt()
      ..selected = json['selected'] as bool;

Map<String, dynamic> _$ArtifactToJson(Artifact instance) => <String, dynamic>{
      'orgid': instance.orgid,
      'id': instance.id,
      'created': instance.created?.toIso8601String(),
      'active': instance.active,
      'code': instance.code,
      'updated': instance.updated?.toIso8601String(),
      'name': instance.name,
      'description': instance.description,
      'location': instance.location,
      'devicecode': instance.devicecode,
      'avatarUrl': instance.avatarUrl,
      'author': instance.author.toJson(),
      'expiry': instance.expiry.toIso8601String(),
      'gps': instance.gps?.toJson(),
    };

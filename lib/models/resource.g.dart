// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'resource.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Resource _$ResourceFromJson(Map<String, dynamic> json) => Resource(
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
    );

Map<String, dynamic> _$ResourceToJson(Resource instance) => <String, dynamic>{
      'id': instance.id,
      'created': instance.created?.toIso8601String(),
      'code': instance.code,
      'updated': instance.updated?.toIso8601String(),
      'name': instance.name,
      'description': instance.description,
      'location': instance.location,
      'devicecode': instance.devicecode,
    };

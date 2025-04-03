// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nest_notifi.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NestNotifi _$NestNotifiFromJson(Map<String, dynamic> json) => NestNotifi(
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
      subject: json['subject'] as String?,
      imageUrl: json['imageUrl'] as String?,
      gps: json['gps'] == null
          ? null
          : GPS.fromJson(json['gps'] as Map<String, dynamic>),
      nestNotifiType: $enumDecodeNullable(
              _$NestNotifiTypeEnumMap, json['nestNotifiType']) ??
          NestNotifiType.undefined,
    );

Map<String, dynamic> _$NestNotifiToJson(NestNotifi instance) =>
    <String, dynamic>{
      'orgid': instance.orgid,
      'id': instance.id,
      'created': instance.created?.toIso8601String(),
      'code': instance.code,
      'updated': instance.updated?.toIso8601String(),
      'name': instance.name,
      'subject': instance.subject,
      'description': instance.description,
      'imageUrl': instance.imageUrl,
      'gps': instance.gps?.toJson(),
      'nestNotifiType': _$NestNotifiTypeEnumMap[instance.nestNotifiType],
    };

const _$NestNotifiTypeEnumMap = {
  NestNotifiType.undefined: 'undefined',
  NestNotifiType.gps: 'gps',
  NestNotifiType.status: 'status',
  NestNotifiType.addition: 'addition',
  NestNotifiType.removal: 'removal',
  NestNotifiType.message: 'message',
  NestNotifiType.alarm: 'alarm',
  NestNotifiType.update: 'update',
};

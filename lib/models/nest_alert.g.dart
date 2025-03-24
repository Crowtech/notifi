// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nest_alert.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NestAlert _$NestAlertFromJson(Map<String, dynamic> json) => NestAlert(
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
      nestAlertType:
          $enumDecodeNullable(_$NestAlertTypeEnumMap, json['nestAlertType']) ??
              NestAlertType.unknown,
    )..image_url = json['image_url'] as String?;

Map<String, dynamic> _$NestAlertToJson(NestAlert instance) => <String, dynamic>{
      'orgid': instance.orgid,
      'id': instance.id,
      'created': instance.created?.toIso8601String(),
      'code': instance.code,
      'updated': instance.updated?.toIso8601String(),
      'name': instance.name,
      'subject': instance.subject,
      'description': instance.description,
      'image_url': instance.image_url,
      'gps': instance.gps?.toJson(),
      'nestAlertType': _$NestAlertTypeEnumMap[instance.nestAlertType],
      'imageUrl': instance.imageUrl,
    };

const _$NestAlertTypeEnumMap = {
  NestAlertType.unknown: 'unknown',
  NestAlertType.gps: 'gps',
  NestAlertType.status: 'status',
  NestAlertType.addition: 'addition',
  NestAlertType.removal: 'removal',
  NestAlertType.message: 'message',
  NestAlertType.alarm: 'alarm',
  NestAlertType.update: 'update',
};

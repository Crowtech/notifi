// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'crowtech_object.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CrowtechObject _$CrowtechObjectFromJson(Map<String, dynamic> json) =>
    CrowtechObject(
      orgid: (json['orgid'] as num?)?.toInt(),
      id: (json['id'] as num?)?.toInt(),
      code: json['code'] as String?,
      created: json['created'] == null
          ? null
          : DateTime.parse(json['created'] as String),
      name: json['name'] as String?,
      updated: json['updated'] == null
          ? null
          : DateTime.parse(json['updated'] as String),
    );

Map<String, dynamic> _$CrowtechObjectToJson(CrowtechObject instance) =>
    <String, dynamic>{
      'orgid': instance.orgid,
      'id': instance.id,
      'created': instance.created?.toIso8601String(),
      'code': instance.code,
      'updated': instance.updated?.toIso8601String(),
      'name': instance.name,
    };

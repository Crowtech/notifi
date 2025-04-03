// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'crowtech_base.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CrowtechBase<T> _$CrowtechBaseFromJson<T>(Map<String, dynamic> json) =>
    CrowtechBase<T>(
      orgid: (json['orgid'] as num?)?.toInt(),
      id: (json['id'] as num?)?.toInt(),
      created: json['created'] == null
          ? null
          : DateTime.parse(json['created'] as String),
      code: json['code'] as String?,
    );

Map<String, dynamic> _$CrowtechBaseToJson<T>(CrowtechBase<T> instance) =>
    <String, dynamic>{
      'orgid': instance.orgid,
      'id': instance.id,
      'created': instance.created?.toIso8601String(),
      'code': instance.code,
    };

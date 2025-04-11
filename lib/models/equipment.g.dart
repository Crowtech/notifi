// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'equipment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Equipment _$EquipmentFromJson(Map<String, dynamic> json) =>
    Equipment(
        id: (json['id'] as num?)?.toInt(),
        code: json['code'] as String?,
        created:
            json['created'] == null
                ? null
                : DateTime.parse(json['created'] as String),
        updated:
            json['updated'] == null
                ? null
                : DateTime.parse(json['updated'] as String),
        active: json['active'] as bool?,
        name: json['name'] as String?,
        description: json['description'] as String?,
        location: json['location'] as String?,
        devicecode: json['devicecode'] as String?,
        avatarUrl: json['avatarUrl'] as String?,
        etype: json['etype'] as String,
        model: json['model'] as String,
        brand: json['brand'] as String,
        serialNumber: json['serialNumber'] as String,
        mac: json['mac'] as String,
        gps:
            json['gps'] == null
                ? null
                : GPS.fromJson(json['gps'] as Map<String, dynamic>),
      )
      ..orgid = (json['orgid'] as num?)?.toInt()
      ..selected = json['selected'] as bool;

Map<String, dynamic> _$EquipmentToJson(Equipment instance) => <String, dynamic>{
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
  'etype': instance.etype,
  'model': instance.model,
  'brand': instance.brand,
  'serialNumber': instance.serialNumber,
  'mac': instance.mac,
  'gps': instance.gps?.toJson(),
};

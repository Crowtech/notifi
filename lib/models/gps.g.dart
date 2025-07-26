// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gps.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GPS _$GPSFromJson(Map<String, dynamic> json) => GPS(
      id: (json['id'] as num?)?.toInt() ?? 0,
      code: json['code'] as String?,
      created: json['created'] == null
          ? null
          : DateTime.parse(json['created'] as String),
      active: json['active'] as bool? ?? true,
      resourcecode: json['resourcecode'] as String? ?? "",
      resourceid: (json['resourceid'] as num?)?.toInt() ?? 0,
      devicecode: json['devicecode'] as String?,
      timestamp: (json['timestamp'] as num?)?.toInt(),
      longitude: (json['longitude'] as num?)?.toDouble() ?? 0.0,
      latitude: (json['latitude'] as num?)?.toDouble() ?? 0.0,
      speed: (json['speed'] as num?)?.toDouble() ?? 0.0,
      heading: (json['heading'] as num?)?.toDouble() ?? 0.0,
      battery: (json['battery'] as num?)?.toDouble() ?? 0.0,
      charging: json['charging'] as bool? ?? false,
      moving: json['moving'] as bool? ?? false,
      person: json['person'] == null
          ? null
          : Person.fromJson(json['person'] as Map<String, dynamic>),
      accuracy: json['accuracy'] as String?,
      coords: json['coords'] == null
          ? null
          : GpsCoords.fromJson(json['coords'] as Map<String, dynamic>),
    )..orgid = (json['orgid'] as num?)?.toInt();

Map<String, dynamic> _$GPSToJson(GPS instance) => <String, dynamic>{
      'orgid': instance.orgid,
      'id': instance.id,
      'created': instance.created?.toIso8601String(),
      'active': instance.active,
      'code': instance.code,
      'resourcecode': instance.resourcecode,
      'resourceid': instance.resourceid,
      'devicecode': instance.devicecode,
      'timestamp': instance.timestamp,
      'longitude': instance.longitude,
      'latitude': instance.latitude,
      'speed': instance.speed,
      'heading': instance.heading,
      'battery': instance.battery,
      'charging': instance.charging,
      'moving': instance.moving,
      'person': instance.person?.toJson(),
      'accuracy': instance.accuracy,
      'coords': instance.coords?.toJson(),
    };

GpsCoords _$GpsCoordsFromJson(Map<String, dynamic> json) => GpsCoords(
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      accuracy: (json['accuracy'] as num?)?.toDouble(),
      speed: (json['speed'] as num?)?.toDouble(),
      heading: (json['heading'] as num?)?.toDouble(),
      bearing: (json['bearing'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$GpsCoordsToJson(GpsCoords instance) => <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'accuracy': instance.accuracy,
      'speed': instance.speed,
      'heading': instance.heading,
      'bearing': instance.bearing,
    };

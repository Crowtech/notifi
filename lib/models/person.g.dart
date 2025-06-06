// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'person.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Person _$PersonFromJson(Map<String, dynamic> json) => Person(
      isSignedIn: json['isSignedIn'] as bool? ?? false,
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
      username: json['username'] as String?,
      email: json['email'] as String,
      firstname: json['firstname'] as String,
      lastname: json['lastname'] as String,
      nickname: json['nickname'] as String?,
      gender: $enumDecodeNullable(_$GenderTypeEnumMap, json['gender']) ??
          GenderType.UNDEFINED,
      i18n: json['i18n'] as String?,
      country: json['country'] as String?,
      longitude: (json['longitude'] as num?)?.toDouble(),
      latitude: (json['latitude'] as num?)?.toDouble(),
      birthyear: (json['birthyear'] as num?)?.toInt(),
      fcm: json['fcm'] as String?,
      gps: json['gps'] == null
          ? null
          : GPS.fromJson(json['gps'] as Map<String, dynamic>),
    )
      ..orgid = (json['orgid'] as num?)?.toInt()
      ..zoneId = json['zoneId'] as String?
      ..selected = json['selected'] as bool
      ..token = json['token'] as String?;

Map<String, dynamic> _$PersonToJson(Person instance) => <String, dynamic>{
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
      'zoneId': instance.zoneId,
      'isSignedIn': instance.isSignedIn,
      'username': instance.username,
      'email': instance.email,
      'firstname': instance.firstname,
      'lastname': instance.lastname,
      'nickname': instance.nickname,
      'gender': _$GenderTypeEnumMap[instance.gender]!,
      'i18n': instance.i18n,
      'country': instance.country,
      'longitude': instance.longitude,
      'latitude': instance.latitude,
      'birthyear': instance.birthyear,
      'fcm': instance.fcm,
      'token': instance.token,
      'gps': instance.gps?.toJson(),
    };

const _$GenderTypeEnumMap = {
  GenderType.MALE: 'MALE',
  GenderType.FEMALE: 'FEMALE',
  GenderType.UNDEFINED: 'UNDEFINED',
  GenderType.NONBINARY_NONCONFORMING: 'NONBINARY_NONCONFORMING',
  GenderType.PREFER_NOT_TO_RESPOND: 'PREFER_NOT_TO_RESPOND',
};

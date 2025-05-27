// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'registration.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Registration _$RegistrationFromJson(Map<String, dynamic> json) => Registration(
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
      email: json['email'] as String,
      inviteeFirstname: json['inviteeFirstname'] as String,
      inviteeLastname: json['inviteeLastname'] as String,
      inviteeI18n: json['inviteeI18n'] as String?,
      organization: json['organization'] == null
          ? null
          : Organization.fromJson(json['organization'] as Map<String, dynamic>),
      orgId: (json['orgId'] as num?)?.toInt(),
      user: json['user'] == null
          ? null
          : Person.fromJson(json['user'] as Map<String, dynamic>),
      userId: (json['userId'] as num?)?.toInt(),
      inviter: json['inviter'] == null
          ? null
          : Person.fromJson(json['inviter'] as Map<String, dynamic>),
      inviterId: (json['inviterId'] as num?)?.toInt(),
      approver: json['approver'] == null
          ? null
          : Person.fromJson(json['approver'] as Map<String, dynamic>),
      approverId: (json['approverId'] as num?)?.toInt(),
      approvalNeeded: json['approvalNeeded'] as bool?,
      approved: json['approved'] as bool?,
      approvalDateTime: json['approvalDateTime'] == null
          ? null
          : DateTime.parse(json['approvalDateTime'] as String),
      approvalReason: json['approvalReason'] as String?,
      firstLogin: json['firstLogin'] == null
          ? null
          : DateTime.parse(json['firstLogin'] as String),
      joinCode: json['joinCode'] as String?,
    )
      ..orgid = (json['orgid'] as num?)?.toInt()
      ..gps = json['gps'] == null
          ? null
          : GPS.fromJson(json['gps'] as Map<String, dynamic>)
      ..zoneId = json['zoneId'] as String?
      ..selected = json['selected'] as bool;

Map<String, dynamic> _$RegistrationToJson(Registration instance) =>
    <String, dynamic>{
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
      'gps': instance.gps?.toJson(),
      'zoneId': instance.zoneId,
      'email': instance.email,
      'inviteeFirstname': instance.inviteeFirstname,
      'inviteeLastname': instance.inviteeLastname,
      'inviteeI18n': instance.inviteeI18n,
      'organization': instance.organization?.toJson(),
      'orgId': instance.orgId,
      'user': instance.user?.toJson(),
      'userId': instance.userId,
      'inviter': instance.inviter?.toJson(),
      'inviterId': instance.inviterId,
      'approver': instance.approver?.toJson(),
      'approverId': instance.approverId,
      'approvalNeeded': instance.approvalNeeded,
      'approved': instance.approved,
      'approvalDateTime': instance.approvalDateTime?.toIso8601String(),
      'approvalReason': instance.approvalReason,
      'firstLogin': instance.firstLogin?.toIso8601String(),
      'joinCode': instance.joinCode,
    };

import 'package:json_annotation/json_annotation.dart';

import 'package:logger/logger.dart';
import 'package:notifi/models/gps.dart';

import '../jwt_utils.dart';
import 'gendertype.dart';
import 'resource.dart';

part 'organization.g.dart';

var logger = Logger(
  printer: PrettyPrinter(),
);

@JsonSerializable(explicitToJson: true)
class Organization extends Resource {
  static String className = "Organization";
  static String tablename = className.toLowerCase();


  String orgType;
String url;

  Organization(
      {
      super.orgid,
      super.id,
      super.code,
      super.created,
      super.updated,
      super.name,
      super.description,
      super.location,
      super.devicecode,
      super.avatarUrl,
      super.gps,
      required this.orgType,
      required this.url,
      });

  factory Organization.fromJson(Map<String, dynamic> json) => _$OrganizationFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$OrganizationToJson(this);

  @override
  Organization fromJson(Map<String, dynamic> json) {
    return Organization.fromJson(json);
  }

  @override
  String toString() {
  
    return "Organization=>${super.toString()} $orgType $url ";
  }

  String toShortString() {
    return "Organization=>$name $orgType $url";
  }

  @override
  String getAvatarUrl() {

    if (avatarUrl == null) {
      return "https://gravatar.com/avatar/${generateMd5(email)}?s=64";
    } else {
      return avatarUrl!;
    }
  }

  String getInitials() {
    return "${name!.substring(0, 2).toUpperCase()}}";
  }
}

Organization defaultOrganization = Organization(
  orgid: 0,
  id: 0,
  code: "ORG_DEFAULT", // code
  created: DateTime.now(), // created
  updated: DateTime.now(), // updated
  name: "Default Organization", // name
  description: "This is a default Organization", // description
  location: "", // location
  devicecode: "DEVICE-CODE", // device code
  avatarUrl: "https://gravatar.com/avatar/${generateMd5("user@email.com")}",
  gps: defaultGPS,
  orgType: "group",
  url: "https://www.crowtech.com.au",
); //fcm

import 'package:json_annotation/json_annotation.dart';

import 'package:logger/logger.dart';
import 'package:notifi/credentials.dart';
import 'package:notifi/models/gps.dart';
import 'package:notifi/models/resource_type.dart';

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

  Organization({
    super.id,
    super.code,
    super.created,
    super.active,
    super.updated,
    super.name,
    super.description,
    super.location,
    super.devicecode,
    super.avatarUrl,
    super.gps,
    super.selected,
    required this.orgType,
    required this.url,
  }) {
    super.resourceType = ResourceType.organization;
  }

  factory Organization.fromJson(Map<String, dynamic> json) =>
      _$OrganizationFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$OrganizationToJson(this);

  @override
  Organization fromJson(Map<String, dynamic> json) {
    return Organization.fromJson(json);
  }

  @override
  String toString() {
    return "Organization=>${super.toString()} $orgType $url";
  }

  String toShortString() {
    return "Organization=>$name $orgType $url";
  }

  @override
  String getAvatarUrl() {
    if (avatarUrl == null) {
      return "$defaultMinioEndpointUrl/$defaultRealm/organization.png";
    } else {
      return avatarUrl!;
    }
  }

  String getInitials() {
    return "${name!.substring(0, 2).toUpperCase()}}";
  }

  Organization copyWith({
    int? orgid,
    int? id,
    String? code,
    DateTime? created,
    DateTime? updated,
    String? name,
    String? description,
    String? location,
    String? devicecode,
    String? avatarUrl,
    GPS? gps,
    String? orgType,
    String? url,
    bool? selected,
  }) {
    return Organization(
      id: id ?? this.id,
      code: code ?? this.code,
      created: created ?? this.created,
      updated: updated ?? this.updated,
      name: name ?? this.name,
      description: description ?? this.description,
      location: location ?? this.location,
      devicecode: devicecode ?? this.devicecode,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      gps: gps ?? this.gps,
      orgType: orgType ?? this.orgType,
      url: url ?? this.url,
      selected: selected ?? this.selected,
    );
  }

  @override
  bool operator ==(Object other) =>
      other is Organization &&
      other.runtimeType == runtimeType &&
      other.id == id;

  @override
  int get hashCode => id.hashCode;
}

Organization defaultOrganization = Organization(
  id: 0,
  code: "ORG_DEFAULT", // code
  created: DateTime.now(), // created
  active: true,
  updated: DateTime.now(), // updated
  name: "Default Organization", // name
  description: "This is a default Organization", // description
  location: "", // location
  devicecode: "DEVICE-CODE", // device code
  avatarUrl: "$defaultMinioEndpointUrl/$defaultRealm/organization.png",
  gps: defaultGPS,
  orgType: "group",
  url: "https://www.crowtech.com.au",
  selected: false,
); //fcm

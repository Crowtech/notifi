import 'package:json_annotation/json_annotation.dart';

import 'package:logger/logger.dart';
import 'package:notifi/credentials.dart';
import 'package:notifi/models/gps.dart';
import 'package:notifi/models/person.dart';
import 'package:notifi/models/resource_type.dart';

import '../jwt_utils.dart';
import 'gendertype.dart';
import 'resource.dart';

part 'artifact.g.dart';

var logger = Logger(
  printer: PrettyPrinter(),
);

@JsonSerializable(explicitToJson: true)
class Artifact extends Resource {
  static String className = "Artifact";
  static String tablename = className.toLowerCase();

    Resource author;
    DateTime expiry;

    GPS? gps;

  Artifact(
      {
      super.orgid,
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
      required this.author,
      required this.expiry,
       this.gps,
      }) {
    super.resourceType = ResourceType.artifact;
  }

  factory Artifact.fromJson(Map<String, dynamic> json) => _$ArtifactFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$ArtifactToJson(this);

  @override
  Artifact fromJson(Map<String, dynamic> json) {
    return Artifact.fromJson(json);
  }

  @override
  String toString() {
    String gpsStr = "";
    if (gps != null) {
      gpsStr = "${gps!.latitude},${gps!.longitude}";
    }
    return "Artifact=>${super.toString()} $author $expiry  $gpsStr";
  }

  String toShortString() {
    return "Artifact=>${author.name} $expiry";
  }

  @override
  String getAvatarUrl() {

    if (avatarUrl == null) {
      return "$defaultMinioEndpointUrl/$defaultRealm/artifact.png";
    } else {
      return avatarUrl!;
    }
  }

  String getInitials() {
    return "${name!.substring(0, 0)}";
  }
}

Artifact defaultArtifact = Artifact(
  orgid: 0,
  id: 0,
  code: "ART_DEFAULT", // code
  created: DateTime.now(), // created
  updated: DateTime.now(), // updated
  active: true,
  name: "Default Artifact", // name
  description: "This is a default Artifact", // description
  location: "", // location
  devicecode: "DEVICE-CODE", // device code
  author: defaultPerson, // username
  expiry: DateTime.now(), // email
  avatarUrl: "$defaultMinioEndpointUrl/$defaultRealm/artifact.png",
); //fcm

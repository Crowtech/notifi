import 'package:json_annotation/json_annotation.dart';

import 'package:logger/logger.dart';
import 'package:notifi/credentials.dart';
import 'package:notifi/models/gps.dart';
import 'package:notifi/models/person.dart';
import 'package:notifi/models/resource_type.dart';

import '../jwt_utils.dart';
import 'gendertype.dart';
import 'resource.dart';

part 'location.g.dart';

var logger = Logger(
  printer: PrettyPrinter(),
);

@JsonSerializable(explicitToJson: true)
class Location extends Resource {
  static String className = "Location";
  static String tablename = className.toLowerCase();

    Resource author;
    DateTime expiry;

    @override
  GPS? gps;

  Location(
      {
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
    super.resourceType = ResourceType.location;
  }

  factory Location.fromJson(Map<String, dynamic> json) => _$LocationFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$LocationToJson(this);

  @override
  Location fromJson(Map<String, dynamic> json) {
    return Location.fromJson(json);
  }

  @override
  String toString() {
    String gpsStr = "";
    if (gps != null) {
      gpsStr = "${gps!.latitude},${gps!.longitude}";
    }
    return "Location=>${super.toString()} $author $expiry  $gpsStr";
  }

  String toShortString() {
    return "Location=>${author.name} $expiry";
  }

  @override
  String getAvatarUrl() {

    if (avatarUrl == null) {
      return "$defaultMinioEndpointUrl/$defaultRealm/location.png";
    } else {
      return avatarUrl!;
    }
  }

  String getInitials() {
    return name!.substring(0, 0);
  }

    @override
  bool operator ==(Object other) =>
      other is Location &&
      other.runtimeType == runtimeType &&
      other.id == id;
      
  @override
  int get hashCode => id.hashCode;
}

Location defaultLocation = Location(
  id: 0,
  code: "LOC_DEFAULT", // code
  created: DateTime.now(), // created
  active: true,
  updated: DateTime.now(), // updated
  name: "Default Location", // name
  description: "This is a default Location", // description
  location: "", // location
  devicecode: "DEVICE-CODE", // device code
  author: defaultPerson, // username
  expiry: DateTime.now(), // email
  avatarUrl: "$defaultMinioEndpointUrl/$defaultRealm/location.png",
); //fcm

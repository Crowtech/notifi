import 'package:json_annotation/json_annotation.dart';

import 'package:logger/logger.dart';
import 'package:notifi/credentials.dart';
import 'package:notifi/models/gps.dart';
import 'package:notifi/models/resource_type.dart';

import '../jwt_utils.dart';
import 'gendertype.dart';
import 'resource.dart';

part 'equipment.g.dart';

var logger = Logger(
  printer: PrettyPrinter(),
);

@JsonSerializable(explicitToJson: true)
class Equipment extends Resource {
  static String className = "Equipment";
  static String tablename = className.toLowerCase();

  String etype;
  String model;
  String brand;
  String serialNumber;
  String mac;

  GPS? gps;

  Equipment({
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
    required this.etype,
    required this.model,
    required this.brand,
    required this.serialNumber,
    required this.mac,
    this.gps,
  }) {
    super.resourceType = ResourceType.equipment;
  }

  factory Equipment.fromJson(Map<String, dynamic> json) =>
      _$EquipmentFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$EquipmentToJson(this);

  @override
  Equipment fromJson(Map<String, dynamic> json) {
    return Equipment.fromJson(json);
  }

  @override
  String toString() {
    String gpsStr = "";
    if (gps != null) {
      gpsStr = "${gps!.latitude},${gps!.longitude}";
    }
    return "Equipment=>${super.toString()} $etype $model $brand $serialNumber $mac  $gpsStr";
  }

  String toShortString() {
    return "Equipment=>$etype $model $brand";
  }

  @override
  String getAvatarUrl() {
    // return "https://gravatar.com/avatar/e011911a71acf8c16ac28471deeeea2a?s=64";

    if (avatarUrl == null) {
      return "$defaultMinioEndpointUrl/$defaultRealm/equipment.png";
    } else {
      return avatarUrl!;
    }
  }

  String getInitials() {
    return "${brand.substring(0, 1).toUpperCase()}${model.substring(0, 1).toUpperCase()}";
  }

  @override
  int get hashCode => id.hashCode;
}

Equipment defaultEquipment = Equipment(
  orgid: 0,
  id: 0,
  code: "EQP_DEFAULT", // code
  created: DateTime.now(), // created
  updated: DateTime.now(), // updated
  name: "Default Equipment", // name
  description: "This is a default Equipment", // description
  location: "", // location
  devicecode: "DEVICE-CODE", // device code
  etype: "UNKNOWN", // username
  model: "UNKNOWN", // email
  brand: "UNKOWN", // firstname
  serialNumber: "UNKNOWN", // lastname
  mac: "UNKNOWN", //nickname,
  avatarUrl: "$defaultMinioEndpointUrl/$defaultRealm/equipment.png",
); //fcm

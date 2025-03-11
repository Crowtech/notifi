import 'package:json_annotation/json_annotation.dart';

import 'package:logger/logger.dart';
import 'package:notifi/credentials.dart';
import 'package:notifi/models/gps.dart';
import 'package:notifi/models/resource_type.dart';

import '../jwt_utils.dart';
import 'gendertype.dart';
import 'resource.dart';

part 'vehicle.g.dart';

var logger = Logger(
  printer: PrettyPrinter(),
);

@JsonSerializable(explicitToJson: true)
class Vehicle extends Resource {
  static String className = "Vehicle";
  static String tablename = className.toLowerCase();

    String etype;
    String model;
    String brand;
    String serialNumber;
    String mac;

    GPS? gps;

  Vehicle(
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
      required this.etype,
      required this.model,
      required this.brand,
      required this.serialNumber,
      required this.mac,
       this.gps,
      }) {
    super.resourceType = ResourceType.person;
  }

  factory Vehicle.fromJson(Map<String, dynamic> json) => _$VehicleFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$VehicleToJson(this);

  @override
  Vehicle fromJson(Map<String, dynamic> json) {
    return Vehicle.fromJson(json);
  }

  @override
  String toString() {
    String gpsStr = "";
    if (gps != null) {
      gpsStr = "${gps!.latitude},${gps!.longitude}";
    }
    return "Vehicle=>${super.toString()} $etype $model $brand $serialNumber $mac  $gpsStr";
  }

  String toShortString() {
    return "Vehicle=>$etype $model $brand";
  }

  @override
  String getAvatarUrl() {
    // return "https://gravatar.com/avatar/e011911a71acf8c16ac28471deeeea2a?s=64";

    if (avatarUrl == null) {
      return "$defaultMinioEndpointUrl/$defaultRealm/vehicle.png";
    } else {
      return avatarUrl!;
    }
  }

  String getInitials() {
    return "${brand.substring(0, 1).toUpperCase()}${model.substring(0, 1).toUpperCase()}";
  }
}

Vehicle defaultVehicle = Vehicle(
  orgid: 0,
  id: 0,
  code: "VEH_DEFAULT", // code
  created: DateTime.now(), // created
  updated: DateTime.now(), // updated
  name: "Default Vehicle", // name
  description: "This is a default Vehicle", // description
  location: "", // location
  devicecode: "DEVICE-CODE", // device code
  etype: "UNKNOWN", // username
  model: "UNKNOWN", // email
  brand: "UNKOWN", // firstname
  serialNumber: "UNKNOWN", // lastname
  mac: "UNKNOWN", //nickname,
  avatarUrl: "$defaultMinioEndpointUrl/$defaultRealm/vehicle.png",
); //fcm

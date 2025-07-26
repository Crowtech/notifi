import 'package:json_annotation/json_annotation.dart';

import 'package:logger/logger.dart';
import 'package:notifi/models/gendertype.dart';
import 'package:notifi/models/person.dart';

import 'crowtech_base.dart';
part 'gps.g.dart';

var logger = Logger(
  printer: PrettyPrinter(),
);

@JsonSerializable(explicitToJson: true)
class GPS extends CrowtechBase<GPS> {
  static String className = "GPS";
  static String tablename = className.toLowerCase();
  static String PREFIX = "GPS_";
  // static String typename = "gps";
  String resourcecode;
  int resourceid;
  String? devicecode;
  int? timestamp = DateTime.now().millisecondsSinceEpoch;
  double longitude;
  double latitude;
  double speed;
  double heading;
  double battery;
  bool charging;
  bool moving;
  Person? person;
  final String? accuracy;
  final GpsCoords? coords;

  GPS({
    super.id = 0,
    super.code,
    super.created,
    super.active = true,
    String? jwt,
    this.resourcecode = "",
    this.resourceid = 0,
    this.devicecode,
    this.timestamp,
    String timestampStr = "",
    this.longitude = 0.0,
    this.latitude = 0.0,
    this.speed = 0.0,
    this.heading = 0.0,
    this.battery = 0.0,
    this.charging = false,
    this.moving = false,
    this.person,
    this.accuracy,
    this.coords,
  }) {
    // if (person != null) {
    //   resourceid = person!.id!;
    //   resourcecode = person!.code!;
    // }

    if (timestampStr.isEmpty) {
      timestamp = DateTime.now().millisecondsSinceEpoch;
    } else {
      DateTime ts = DateTime.parse(timestampStr);
      timestamp = ts.millisecondsSinceEpoch; // TODO watch for errors
    }
    // if (resourcecode.isNotEmpty) {
    //   resourcecode = resourcecode.toUpperCase();
    //   resourcecode =
    //       resourcecode.replaceAll("[^\\p{IsAlphabetic}\\p{IsDigit}]", "_");
    //   if (!resourcecode.startsWith("PER_")) {
    //     resourcecode = "PER_$resourcecode";
    //   }
    //   // logger.d("Direct Usercode in GPS is $resourcecode");
    // } else if (jwt != null && jwt.isNotEmpty) {
    //   Map<String, dynamic> decodedToken = JwtDecoder.decode(jwt);
    //   resourcecode = decodedToken['sub'];
    //   // convert to backend format
    //   resourcecode =
    //       resourcecode.replaceAll("[^\\p{IsAlphabetic}\\p{IsDigit}]", "_");
    //   resourcecode = "PER_${resourcecode.toUpperCase()}";
    //   logger.d("JWT Usercode in GPS is $resourcecode");
    // }
  }

  factory GPS.fromJson(Map<String, dynamic> json) => _$GPSFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$GPSToJson(this);

  @override
  GPS fromJson(Map<String, dynamic> json) {
    return GPS.fromJson(json);
  }

  @override
  String toString() {
    String personStr = "";
    if (person != null) {
      personStr =
          "${person!.email} ${person!.gender == GenderType.MALE ? 'MALE' : 'FEMALE'} ";
    }
    return "GPS==> ${super.toString()} $resourcecode $latitude $longitude $speed $heading $personStr";
  }

  @override
  bool operator ==(Object other) =>
      other is GPS && other.runtimeType == runtimeType && other.id == id;

  @override
  int get hashCode => id.hashCode;

  bool get hasValidCoordinates {
    return (latitude != null && longitude != null) ||
        (coords != null &&
            coords!.latitude != null &&
            coords!.longitude != null);
  }

  double? get displayLatitude {
    if (latitude != null) return latitude;
    return coords?.latitude;
  }

  double? get displayLongitude {
    if (longitude != null) return longitude;
    return coords?.longitude;
  }

  String? get timestampString {
    if (timestamp == null) return created.toString();
    if (timestamp is String) return timestamp.toString();
    if (timestamp is int) return timestamp.toString();
    return super.created.toString();
  }
}

GPS defaultGPS = GPS(latitude: 0.0, longitude: 0.0);

@JsonSerializable()
class GpsCoords {
  final double? latitude;
  final double? longitude;
  final double? accuracy;
  final double? speed;
  final double? heading;
  final double? bearing;

  GpsCoords({
    this.latitude,
    this.longitude,
    this.accuracy,
    this.speed,
    this.heading,
    this.bearing,
  });

  factory GpsCoords.fromJson(Map<String, dynamic> json) =>
      _$GpsCoordsFromJson(json);
  Map<String, dynamic> toJson() => _$GpsCoordsToJson(this);
}

import 'package:json_annotation/json_annotation.dart';

import 'package:logger/logger.dart';
import 'package:notifi/models/gps.dart';

import '../jwt_utils.dart';
import 'crowtech_object.dart';
part 'resource.g.dart';

var logger = Logger(
  printer: PrettyPrinter(),
);

@JsonSerializable(explicitToJson: true)
class Resource extends CrowtechObject {
  static String className = "Resource";
  static String tablename = className.toLowerCase();

  String? description;
  String? location;
  String? devicecode;
  String? avatarUrl;
  GPS? gps;
  @JsonKey(includeFromJson: false, includeToJson: false)
  bool selected = false;

  Resource(
      {super.orgid,
      super.id,
      super.code,
      super.created,
      super.updated,
      super.name,
      this.description,
      this.location,
      this.devicecode,
      this.avatarUrl,
      this.gps,
      required this.selected,});

  factory Resource.fromJson(Map<String, dynamic> json) =>
      _$ResourceFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$ResourceToJson(this);

  @override
  Resource fromJson(Map<String, dynamic> json) {
    return Resource.fromJson(json);
  }

  @override
  String toString() {
    return "Resource=>${super.toString()} $description, $location, $devicecode $gps";
  }

  String getAvatarUrl() {
    if (avatarUrl == null) {
      return "https://gravatar.com/avatar/${generateMd5("unknown@unknown.com")}";
    } else {
      print("avatarUrl for $code is $avatarUrl");
      return avatarUrl!;
    }
  }
}

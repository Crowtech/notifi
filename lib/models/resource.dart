import 'package:json_annotation/json_annotation.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import 'package:logger/logger.dart';

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

  Resource({
    super.id,
    super.code,
    super.created,
    super.updated,
    super.name,
    this.description,
    this.location,
    this.devicecode
  });

  factory Resource.fromJson(Map<String, dynamic> json) => _$ResourceFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$ResourceToJson(this);

  @override
  Resource fromJson(Map<String, dynamic> json) {
    return Resource.fromJson(json);
  }

  @override
  String toString() {
    return "Resource=>${super.toString()} $description, $location, $devicecode";
  }
}

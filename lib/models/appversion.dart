import 'package:json_annotation/json_annotation.dart';

import 'package:logger/logger.dart';

import 'crowtech_object.dart';
part 'appversion.g.dart';

var logger = Logger(
  printer: PrettyPrinter(),
);

@JsonSerializable(explicitToJson: true)
class AppVersion extends CrowtechObject {
  static String className = "AppVersion";
  static String tablename = className.toLowerCase();

  String? version;
  String? buildNumber;
  String? dockerId;


  AppVersion(
      {super.id,
      super.code,
      super.created,
      super.updated,
      super.name,
      this.version,
      this.buildNumber,
      this.dockerId});

  factory AppVersion.fromJson(Map<String, dynamic> json) =>
      _$AppVersionFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$AppVersionToJson(this);

  @override
  AppVersion fromJson(Map<String, dynamic> json) {
    return AppVersion.fromJson(json);
  }

  @override
  String toString() {
    return "AppVersion=>${super.toString()} $version, $buildNumber, $dockerId";
  }


}

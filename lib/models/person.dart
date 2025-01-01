import 'package:json_annotation/json_annotation.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import 'package:logger/logger.dart';

import 'gendertype.dart';
import 'resource.dart';

part 'person.g.dart';

var logger = Logger(
  printer: PrettyPrinter(),
);

@JsonSerializable(explicitToJson: true)
class Person extends Resource {
  static String className = "Person";
  static String tablename = className.toLowerCase();

   String username;
  String email;
    String firstname;
    String lastname;
    String nickname;
    GenderType gender;
    String i18n;
    String country;
    double longitude;
    double latitude;
    int birthyear;
    String fcm;

  Person({
    super.id,
    super.code,
    super.created,
    super.updated,
    super.name,
    super.description,
    super.location,
    super.devicecode,
    required this.username,
    required this.email,
    required this.firstname,
    required this.lastname,
    required this.nickname,
    required this.gender,
    required this.i18n,
    required this.country,
    required this.longitude,
    required this.latitude,
    required this.birthyear,
    required this.fcm
  });

  factory Person.fromJson(Map<String, dynamic> json) => _$PersonFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$PersonToJson(this);

  @override
  Person fromJson(Map<String, dynamic> json) {
    return Person.fromJson(json);
  }

  @override
  String toString() {
    return "Person=>${super.toString()} $username $email $firstname $lastname $nickname $gender $i18n";
  }

    String toShortString() {
    return "Person=>$username $nickname $gender";
  }
}

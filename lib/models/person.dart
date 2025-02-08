import 'package:json_annotation/json_annotation.dart';

import 'package:logger/logger.dart';

import '../jwt_utils.dart';
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
  String? country;
  double? longitude;
  double? latitude;
  int? birthyear;
  String? fcm;
  String? token;  // used to get roles

  Person(
      {super.id,
      super.code,
      super.created,
      super.updated,
      super.name,
      super.description,
      super.location,
      super.devicecode,
      super.avatarUrl,
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
      required this.fcm});

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

  @override
  String getAvatarUrl() {
   // return "https://gravatar.com/avatar/e011911a71acf8c16ac28471deeeea2a?s=64";
    
    if (avatarUrl == null) {
    return "https://gravatar.com/avatar/${generateMd5(email)}?s=64";
    } else {
      return avatarUrl!;
    }
  }

  String getInitials()
  {
    return "${firstname.substring(0,1).toUpperCase()}${lastname.substring(0,1).toUpperCase()}";
  }
}

Person defaultPerson = Person(id: 0,
      code: "PER_DEFAULT", // code
      created: DateTime.now(), // created
      updated: DateTime.now(), // updated
      name: "Default Person",  // name
      description: "This is a default Person",  // description
      location: "", // location
      devicecode: "DEVICE-CODE", // device code
      username: "USERNAME",  // username
      email: "user@email.com", // email
      firstname: "", // firstname
      lastname: "",  // lastname
      nickname: "",//nickname,
      gender: GenderType.UNDEFINED,//gender,
      i18n: "en",//i18n,
      country: "Australia",//country,
      longitude: 0.0,//longitude,
      latitude: 0.0,//latitude,
      birthyear: 0,//birthyear,
      fcm: "FCM",
      avatarUrl: "https://gravatar.com/avatar/${generateMd5("user@email.com")}",
     ); //fcm

// import 'package:json_annotation/json_annotation.dart';
// import 'package:logger/logger.dart' as logger;
// import 'package:notifi/credentials.dart';
// import 'package:notifi/jwt_utils.dart';
// import 'package:notifi/models/gendertype.dart';
// import 'package:notifi/models/gps.dart';
// import 'package:notifi/models/resource.dart';
// import 'package:notifi/models/resource_type.dart';
// part 'nperson.g.dart';

// var log = logger.Logger(
//   printer: logger.PrettyPrinter(),
//   level: logger.Level.info,
// );

// var logNoStack = logger.Logger(
//   printer: logger.PrettyPrinter(methodCount: 0),
//   level: logger.Level.info,
// );


// @JsonSerializable(explicitToJson: true)
// class NPerson extends Resource {
//   static String className = "Person";
//   static String tablename = className.toLowerCase();

  
//   String username;
//   String email;
//   String firstname;
//   String lastname;
//   String ?nickname;
//   GenderType gender;
//   String ?i18n;
//   String? country;
//   double? longitude;
//   double? latitude;
//   int? birthyear;
//   String? fcm;
//   String? token; // used to get roles

//     @override
//   GPS? gps;
//   @override
//   String? zoneId;

//   NPerson({

//       super.id,
//       super.code,
//       super.created,
//       super.active,
//       super.updated,
//       super.name,
//       super.description,
//       super.location,
//       super.devicecode,
//       super.avatarUrl,
//       required this.username,
//       required this.email,
//       required this.firstname,
//       required this.lastname,
//       required this.nickname,
//       required this.gender,
//       required this.i18n,
//       required this.country,
//       required this.longitude,
//       required this.latitude,
//       required this.birthyear,
//       required this.fcm,
//        this.gps,
//       required this.zoneId,
//   }) {
//     super.resourceType = ResourceType.person;
//   }

//   factory NPerson.fromJson(Map<String, dynamic> json) =>
//       _$NPersonFromJson(json);
//   @override
//   Map<String, dynamic> toJson() => _$NPersonToJson(this);

//   @override
//   NPerson fromJson(Map<String, dynamic> json) {
//     NPerson p = NPerson.fromJson(json);
//     logNoStack.i("converting ${p.toShortString}");
//     return p;
//   }

// @override
//   String toString() {
//     String gpsStr = "";
//     if (gps != null) {
//       gpsStr = "${gps!.latitude},${gps!.longitude}";
//     }
//     return "Person=>${super.toString()} $username $email $firstname $lastname $nickname $gender $i18n $gpsStr";
//   }

//   String toShortString() {
//     return "Person=>$username $nickname $gender";
//   }

//   @override
//   String getAvatarUrl() {
//     if (avatarUrl == null) {
//       return "$defaultMinioEndpointUrl/$defaultRealm/person.png";
//     } else {
//       return avatarUrl!;
//     }
//   }

//   String getInitials() {
//     return "${firstname.substring(0, 1).toUpperCase()}${lastname.substring(0, 1).toUpperCase()}";
//   }


//   NPerson copyWith({
//     int? id,
//     String? code,
//     DateTime? created,
//     bool? active,
//     DateTime? updated,
//     String? name,
//     String? description,
//     String? location,
//     String? devicecode,
//     String? avatarUrl,
//     String? username,
//     String? email,
//     String? firstname,
//     String? lastname,
//     String? nickname,
//     GenderType? gender,
//     String? i18n,
//      String? country,
//     double? longitude,
//     double? latitude,
//     int? birthyear,
//     String? fcm,
//     GPS? gps,
//     String? zoneId,

//   }) {
//     return NPerson(
//       id: id ?? this.id,
//       code: code ?? this.code,
//       created: created ?? this.created,
//       active: active ?? this.active,
//       updated: updated ?? this.updated,
//       name: name ?? this.name,
//       description: description ?? this.description,
//       location: location ?? this.location,
//       devicecode: devicecode ?? this.devicecode,
//       avatarUrl: avatarUrl ?? this.avatarUrl,
//       username:   username ?? this.username,
//      email: email ?? this.email,
//      firstname: firstname ?? this.firstname,
//      lastname: lastname ?? this.lastname,
//      nickname: nickname ?? this.nickname,
//      gender: gender ?? this.gender,
//      i18n: i18n ?? this.i18n,
//       country: country ?? this.country,
//      longitude: longitude ?? this.longitude,
//      latitude: latitude ?? this.latitude,
//      birthyear: birthyear ?? this.birthyear,
//      fcm: fcm ?? this.fcm,
//       gps: gps ?? this.gps,
//       zoneId: zoneId ?? this.zoneId,
//     );
//   }
// }

// NPerson defaultPerson = NPerson(

//   id: 0,
//   code: "PER_DEFAULT", // code
//   created: DateTime.now(), // created
//   active: true,
//   updated: DateTime.now(), // updated
//   name: "Default Person", // name
//   description: "This is a default Person", // description
//   location: "", // location
//   devicecode: "DEVICE-CODE", // device code
//   username: "USERNAME", // username
//   email: "user@email.com", // email
//   firstname: "", // firstname
//   lastname: "", // lastname
//   nickname: "", //nickname,
//   gender: GenderType.UNDEFINED, //gender,
//   i18n: "en", //i18n,
//   country: "Australia", //country,
//   longitude: 0.0, //longitude,
//   latitude: 0.0, //latitude,
//   birthyear: 0, //birthyear,
//   fcm: "FCM",
//   avatarUrl: "https://gravatar.com/avatar/${generateMd5("user@email.com")}",
//   zoneId: "UTC",
// ); //fcm

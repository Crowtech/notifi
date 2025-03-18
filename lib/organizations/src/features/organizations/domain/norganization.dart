// import 'package:json_annotation/json_annotation.dart';
// import 'package:logger/logger.dart' as logger;
// import 'package:notifi/credentials.dart';
// import 'package:notifi/models/gps.dart';
// import 'package:notifi/models/resource.dart';
// import 'package:notifi/models/resource_type.dart';
// part 'norganization.g.dart';

// var log = logger.Logger(
//   printer: logger.PrettyPrinter(),
//   level: logger.Level.info,
// );

// var logNoStack = logger.Logger(
//   printer: logger.PrettyPrinter(methodCount: 0),
//   level: logger.Level.info,
// );


// @JsonSerializable(explicitToJson: true)
// class NOrganization extends Resource {
//   static String className = "Organization";
//   static String tablename = className.toLowerCase();

//   String orgType;
//   String url;

//   NOrganization({
//     super.orgid,
//     super.id,
//     super.code,
//     super.created,
//     super.updated,
//     super.name,
//     super.description,
//     super.location,
//     super.devicecode,
//     super.avatarUrl,
//     super.gps,
//     super.selected,
//     required this.orgType,
//     required this.url,
//   }) {
//     super.resourceType = ResourceType.organization;
//   }

//   factory NOrganization.fromJson(Map<String, dynamic> json) =>
//       _$NOrganizationFromJson(json);
//   @override
//   Map<String, dynamic> toJson() => _$NOrganizationToJson(this);

//   @override
//   NOrganization fromJson(Map<String, dynamic> json) {
//     return NOrganization.fromJson(json);
//   }

//   @override
//   String toString() {
//     return "NOrganization=>${super.toString()} $orgType $url ";
//   }

//   String toShortString() {
//     return "NOrganization=>$name $orgType $url";
//   }

//   @override
//   String getAvatarUrl() {
//     if (avatarUrl == null) {
//       return "$defaultMinioEndpointUrl/$defaultRealm/organization.png";
//     } else {
//       return avatarUrl!;
//     }
//   }

//   String getInitials() {
//     return "${name!.substring(0, 2).toUpperCase()}}";
//   }


//   NOrganization copyWith({
//     int? orgid,
//     int? id,
//     String? code,
//     DateTime? created,
//     DateTime? updated,
//     String? name,
//     String? description,
//     String? location,
//     String? devicecode,
//     String? avatarUrl,
//     GPS? gps,
//     String? orgType,
//     String? url,
//     bool? selected,
//   }) {
//     return NOrganization(
//       id: id ?? this.id,
//       code: code ?? this.code,
//       created: created ?? this.created,
//       updated: updated ?? this.updated,
//       name: name ?? this.name,
//       description: description ?? this.description,
//       location: location ?? this.location,
//       devicecode: devicecode ?? this.devicecode,
//       avatarUrl: avatarUrl ?? this.avatarUrl,
//       gps: gps ?? this.gps,
//       orgType: orgType ?? this.orgType,
//       url: url ?? this.url,
//       selected: selected ?? this.selected,
//     );
//   }
// }

// NOrganization defaultOrganization = NOrganization(
//   orgid: 0,
//   id: 0,
//   code: "ORG_DEFAULT", // code
//   created: DateTime.now(), // created
//   updated: DateTime.now(), // updated
//   name: "Default Organization", // name
//   description: "This is a default Organization", // description
//   location: "", // location
//   devicecode: "DEVICE-CODE", // device code
//   avatarUrl: "$defaultMinioEndpointUrl/$defaultRealm/organization.png",
//   gps: defaultGPS,
//   orgType: "group",
//   url: "https://www.crowtech.com.au",
// ); //fcm

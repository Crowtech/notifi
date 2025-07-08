import 'package:json_annotation/json_annotation.dart';
import 'package:logger/logger.dart' as logger;
import 'package:notifi/credentials.dart';
import 'package:notifi/models/crowtech_object.dart';
import 'package:notifi/models/organization.dart';
import 'package:notifi/models/person.dart';

part 'registration.g.dart';

var log = logger.Logger(
  printer: logger.PrettyPrinter(),
  level: logger.Level.info,
);

var logNoStack = logger.Logger(
  printer: logger.PrettyPrinter(methodCount: 0),
  level: logger.Level.info,
);

@JsonSerializable(explicitToJson: true)
class Registration extends CrowtechObject {
  static String className = "Registration";
  static String tablename = className.toLowerCase();

  String email;
  String? inviteeFirstname;
  String? inviteeLastname;
  String? inviteeI18n;
  bool? inviteeApproved;
  Organization? organization;
  int? orgId;
  Person? user;
  int? userId;
  Person? inviter;
  int? inviterId;
  Person? approver;
  int? approverId;

  bool? approvalNeeded;
  bool? approved;
  DateTime? approvalDateTime;
  String? approvalReason;

  DateTime? firstLogin;
  String? joinCode;

  Registration(
      {super.id,
      super.code,
      super.created,
      super.active,
      super.updated,
      super.name,
      required this.email,
      this.inviteeFirstname,
      this.inviteeLastname,
      this.inviteeI18n,
      this.inviteeApproved,
      this.organization,
      this.orgId,
      this.user,
      this.userId,
      this.inviter,
      this.inviterId,
      this.approver,
      this.approverId,
      this.approvalNeeded,
      this.approved,
      this.approvalDateTime,
      this.approvalReason,
      this.firstLogin,
      this.joinCode});

  factory Registration.fromJson(Map<String, dynamic> json) =>
      _$RegistrationFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$RegistrationToJson(this);

  @override
  Registration fromJson(Map<String, dynamic> json) {
    return Registration.fromJson(json);
  }

  @override
  String toString() {
    return "Registration=>${super.toString()} $email $orgId $userId $inviterId $approverId";
  }

  String getAvatarUrl() {
    return "$defaultMinioEndpointUrl/$defaultRealm/generic_person.png";
  }

  String getInitials() {
    String firstInitial = '';
    String lastInitial = '';
    
    if (inviteeFirstname != null && inviteeFirstname!.isNotEmpty) {
      firstInitial = inviteeFirstname!.substring(0, 1).toUpperCase();
    }
    
    if (inviteeLastname != null && inviteeLastname!.isNotEmpty) {
      lastInitial = inviteeLastname!.substring(0, 1).toUpperCase();
    }
    
    return '$firstInitial$lastInitial';
  }

  Registration copyWith({
    int? id,
    String? code,
    DateTime? created,
    bool? active,
    DateTime? updated,
    String? name,
    String? email,
    String? inviteeFirstname,
    String? inviteeLastname,
    String? inviteeI18n,
    bool? inviteeApproved,
    int? orgId,
    int? userId,
    int? inviterId,
    int? approverId,
    bool? approvalNeeded,
    bool? approved,
    DateTime? approvalDateTime,
    String? approvalReason,
    DateTime? firstLogin,
    String? joinCode,
  }) {
    return Registration(
      id: id ?? this.id,
      code: code ?? this.code,
      created: created ?? this.created,
      active: active ?? this.active,
      updated: updated ?? this.updated,
      name: name ?? this.name,
      email: email ?? this.email,
      inviteeFirstname: inviteeFirstname ?? this.inviteeFirstname,
      inviteeLastname: inviteeLastname ?? this.inviteeLastname,
      inviteeI18n: inviteeI18n ?? this.inviteeI18n,
      inviteeApproved: inviteeApproved ?? this.inviteeApproved,
      orgId: orgId ?? this.orgId,
      userId: userId ?? this.userId,
      inviterId: inviterId ?? this.inviterId,
      approverId: approverId ?? this.approverId,
      approvalNeeded: approvalNeeded ?? this.approvalNeeded,
      approved: approved ?? this.approved,
      approvalDateTime: approvalDateTime ?? this.approvalDateTime,
      approvalReason: approvalReason ?? this.approvalReason,
      firstLogin: firstLogin ?? this.firstLogin,
      joinCode: joinCode ?? this.joinCode,
    );
  }
}

Registration defaultRegistration = Registration(
  id: 0,
  code: "REG_DEFAULT", // code
  created: DateTime.now(), // created
  active: true,
  updated: DateTime.now(), // updated
  name: "Default Registration", // name
  email: "user@email.com", // email
  inviteeFirstname: "", // firstname
  inviteeLastname: "", // lastname
  inviteeI18n: "en", //i18n,
  inviteeApproved: false,
  orgId: 1,
  userId: null,
  inviterId: null,
  approverId: null,
  approvalNeeded: false,
  approved: false,
  approvalDateTime: null,
  approvalReason: null,
  firstLogin: null,
  joinCode: null,
); //fcm

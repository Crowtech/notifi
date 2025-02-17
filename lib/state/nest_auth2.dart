import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notifi/api_utils.dart';
import 'package:notifi/jwt_utils.dart';
import 'package:notifi/models/person.dart';
import 'package:oidc/oidc.dart';
import 'package:notifi/app_state.dart' as app_state;
import 'package:logger/logger.dart' as logger;

import '../models/gendertype.dart';

var log = logger.Logger(
  printer: logger.PrettyPrinter(),
  level: logger.Level.info,
);

var logNoStack = logger.Logger(
  printer: logger.PrettyPrinter(methodCount: 0),
  level: logger.Level.info,
);

class NestAuthController with ChangeNotifier {
//class NestAuthController extends Notifier<Person> with ChangeNotifier {
  OidcPlatformSpecificOptions_Web_NavigationMode webNavigationMode = (kIsWeb
      ? OidcPlatformSpecificOptions_Web_NavigationMode.samePage
      : OidcPlatformSpecificOptions_Web_NavigationMode.newPage); // was newPage

  bool allowInsecureConnections = false;
  bool preferEphemeralSession = false;

  bool isLoggedIn = false;
  Person currentUser = defaultPerson;

  OidcPlatformSpecificOptions _getOptions() {
    return OidcPlatformSpecificOptions(
      web: OidcPlatformSpecificOptions_Web(
        navigationMode: webNavigationMode,
        popupHeight: 800,
        popupWidth: 730,
      ),
      // these settings are from https://pub.dev/packages/flutter_appauth.
      android: OidcPlatformSpecificOptions_AppAuth_Android(
        allowInsecureConnections: allowInsecureConnections,
      ),
      ios: OidcPlatformSpecificOptions_AppAuth_IosMacos(
        preferEphemeralSession: preferEphemeralSession,
      ),
      macos: OidcPlatformSpecificOptions_AppAuth_IosMacos(
        preferEphemeralSession: preferEphemeralSession,
      ),
      windows: const OidcPlatformSpecificOptions_Native(),
    );
  }

  @override
  Person build()  {
    logNoStack.i("NEST_AUTH_CONTROLLER : BUILD");
    return defaultPerson;
  }

//Within this section, you can integrate authentication methods
//such as Firebase, SharedPreferences, and more.

  void signOut() {
    logNoStack.i("NEST_AUTH_CONTROLLER : SIGN_OUT");
    currentUser.isSignedIn = false;
    isLoggedIn = false;
    notifyListeners();
    //state = defaultPerson;
    // Person(
    //   isSignedIn: false,
    //   orgid: 0,
    //   id: 0,
    //   code: "PER_DEFAULT", // code
    //   created: DateTime.now(), // created
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
    // ); //fcm
  }




  void signIn() {
    logNoStack.i("NEST_AUTH_CONTROLLER : SIGN_IN");
    // currentUser.isSignedIn = true;
    isLoggedIn = true;

   


    // state = Person(
    //   isSignedIn: true,
    //   orgid: 0,
    //   id: 0,
    //   code: "PER_DEFAULT", // code
    //   created: DateTime.now(), // created
    //   updated: DateTime.now(), // updated
    //   name: "Logged In Person", // name
    //   description: "This is a default Person", // description
    //   location: "", // location
    //   devicecode: "DEVICE-CODE", // device code
    //   username: "USERNAME", // username
    //   email: "user+loggedin@email.com", // email
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
    // ); //fcm
     notifyListeners();
  }
}

final nestAuthProvider2 = ChangeNotifierProvider((ref) => NestAuthController());

// final nestAuthProvider = NotifierProvider<NestAuthController, Person>(
//   () => NestAuthController(),
// );

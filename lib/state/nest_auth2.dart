import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notifi/api_utils.dart';
import 'package:notifi/models/person.dart';
import 'package:oidc/oidc.dart';
import 'package:notifi/app_state.dart' as app_state;
import 'package:logger/logger.dart' as logger;

var log = logger.Logger(
  printer: logger.PrettyPrinter(),
  level: logger.Level.info,
);

var logNoStack = logger.Logger(
  printer: logger.PrettyPrinter(methodCount: 0),
  level: logger.Level.info,
);

//class NestAuthController with ChangeNotifier {
 class NestAuthController  extends Notifier<Person>  {

  OidcPlatformSpecificOptions_Web_NavigationMode webNavigationMode = (kIsWeb
      ? OidcPlatformSpecificOptions_Web_NavigationMode.samePage
      : OidcPlatformSpecificOptions_Web_NavigationMode.newPage); // was newPage

  bool allowInsecureConnections = false;
  bool preferEphemeralSession = false;

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
  Person build() => defaultPerson;



//Within this section, you can integrate authentication methods 
//such as Firebase, SharedPreferences, and more. 

 bool isLoggedIn = false;

  void signIn() {
    state.isSignedIn = true;
    isLoggedIn = true;
   // notifyListeners();
  }

  void signOut() {
    state.isSignedIn = false;
    isLoggedIn = false;
   // notifyListeners();
  }
}

//final nestAuthProvider = ChangeNotifierProvider((ref) => NestAuthController());

final nestAuthProvider = NotifierProvider<NestAuthController, Person>(
  () => NestAuthController(),
);

import 'package:flutter/foundation.dart';
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

class NestAuthNotifier extends Notifier<Person> {

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


Future<void> login() async {
    logNoStack.i("NEST_AUTH LOGIN called.");

    app_state.currentManager
        .loginAuthorizationCodeFlow(
      originalUri: Uri.parse('/'),
      //store any arbitrary data, here we store the authorization
      //start time.
      extraStateData: DateTime.now().toIso8601String(),
      options: _getOptions(),
      //NOTE: you can pass more parameters here.
    )
        .then((oidcUser) {
      logNoStack.i("NEST_AUTH LOGIN called and OIDCUSER provided");
      if (oidcUser != null) {
        logNoStack.i(
            "NEST_AUTH  LOGIN called and OIDC_USER provided IS NOT NULL, setting oidc ${oidcUser.userInfo['email']}");
        setOidc(oidcUser);
      } else {
        logNoStack
            .i("NEST_AUTH LOGIN called and OIDC_USER provided IS  NULL");
      }
    });
  }

  void setOidc(OidcUser oidcUser) async {
    log.i("AUTH_CONTROLLER  LOGIN_OIDC: SAbout to register Token");
    var currentPerson = await registerLogin(oidcUser.token.accessToken!);

    log.i(
        "AUTH_CONTROLLER  LOGIN_OIDC fetched Person: auth user is $currentPerson");

    // ref.read(currentUserProvider.notifier).setPerson(currentPerson);
    state = currentPerson;
  }
}

final nestAuthNotifierProvider = NotifierProvider<NestAuthNotifier, Person>(
  () => NestAuthNotifier(),
);

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notifi/api_utils.dart';
import 'package:notifi/credentials.dart';
import 'package:notifi/jwt_utils.dart';
import 'package:notifi/models/person.dart';
import 'package:oidc/oidc.dart';
import 'package:notifi/app_state.dart' as app_state;
import 'package:logger/logger.dart' as logger;
import 'package:flutter_background_geolocation/flutter_background_geolocation.dart'
    as bg;

var log = logger.Logger(
  printer: logger.PrettyPrinter(),
  level: logger.Level.info,
);

var logNoStack = logger.Logger(
  printer: logger.PrettyPrinter(methodCount: 0),
  level: logger.Level.info,
);

//class NestAuthController with ChangeNotifier {
class NestAuthController extends Notifier<bool> with ChangeNotifier {
  OidcPlatformSpecificOptions_Web_NavigationMode webNavigationMode = (kIsWeb
      ? OidcPlatformSpecificOptions_Web_NavigationMode.samePage
      : OidcPlatformSpecificOptions_Web_NavigationMode.newPage); // was newPage

  bool allowInsecureConnections = false;
  bool preferEphemeralSession = false;

  bool isLoggedIn = false;
  bool preventAutoLogin = false;
  Person currentUser = defaultPerson;
  String? token;

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
  bool build() {
    app_state.currentManager.userChanges().listen((event) async {
      if (event?.userInfo != null) {
        var exp = event?.claims['exp'];
        var name = event?.claims['name'];
        var username = event?.claims['preferred_username'];
        token = event?.token.accessToken;
        var deviceId = await fetchDeviceId();
        if (!isLoggedIn) {
        logNoStack.i(
          'NEST_AUTH2: BUILD: App State User changed (login): exp:$exp, $username, $name $deviceId',
        );
        }

        await loginOidc(event);
      } else {
        logNoStack.i("AUTH CONTROLLER BUILD: App State User changed to NULL:");
      }
    });

    logNoStack.i(
        "NEST_AUTH2_CONTROLLER : BUILD, skipLogin is ${skipLogin ? 'ON' : 'OFF'} preventLogn is ${preventAutoLogin ? 'ON' : 'OFF'}");
    if (skipLogin && (!preventAutoLogin)) {
      logNoStack.i("AUTH CONTROLLER BUILD: SKIP LOGIN DETECTED !");
      loginUsernamePassword(testUsername, testPassword);
      preventAutoLogin = true; // stop it from happening.
    }
    return false;
  }

  void updateCurrentUser(Person person) {
    currentUser = person;
    return;
  }

  Future<void> loginUsernamePassword(String username, String password) async {
    logNoStack.i("AUTH CONTROLLER: Skipping Login!!!!!");
    // final messenger = ScaffoldMessenger.of(context);
    try {
      var result = await app_state.currentManager.loginPassword(
        username: username,
        password: password,
      );
      logNoStack.i(
          "AUTH CONTROLLER: Result is ${result!.claims.toJson()['email']}!!!!!");
      await loginOidc(result);
      // ref.read(currentUserProvider.notifier).setOidc(result);
    } catch (e) {
      logNoStack.e(e.toString());
    }
  }

  Future<void> login() async {
    logNoStack.i("NEST_AUTH2 LOGIN called.");

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
      logNoStack
          .i("NEST_AUTH2: AUTH_CONTROLLER LOGIN called and RESULT provided");
      if (oidcUser != null) {
        logNoStack.i(
            "NEST_AUTH2: AUTH_CONTROLLER LOGIN called and RESULT provided IS NOT NULL, setting oidc ${oidcUser.userInfo['email']}");
        loginOidc(oidcUser);
      } else {
        logNoStack.i(
            "NEST_AUTH2: AUTH_CONTROLLER LOGIN called and RESULT provided IS  NULL");
      }
    });
  }

  Future<void> refreshPerson() async {
    logNoStack.i("NEST_AUTH2: Refreshing Person");
    var oidcUser = await app_state.currentManager.refreshToken();
    loginOidc(oidcUser);
  }

  Future<void> refreshToken() async {
    var oidcUser = await app_state.currentManager.refreshToken();
    loginOidc(oidcUser);
  }

  Future<void> loggedIn() async {
    state = true;
  }

  Future<void> loginOidc(OidcUser? oidcUser) async {

    if (oidcUser != null) {
       token = oidcUser.token.accessToken!;
             if (!isLoggedIn) {
      log.i(
          "NEST_AUTH2 LOGIN_OIDC: In AuthControllerLogin: oidcUser is ${oidcUser.userInfo['email']} fetching user ")

        currentUser = await registerLogin(oidcUser.token.accessToken!);
        currentUser.isSignedIn = true;
        isLoggedIn = true;
        state = true;
      }
      // notifyListeners();
    }
  }

//Within this section, you can integrate authentication methods
//such as Firebase, SharedPreferences, and more.

  Future<void> signOut() async {
    logNoStack.i("NEST_AUTH2_CONTROLLER : SIGN_OUT");
    currentUser.isSignedIn = false;

    isLoggedIn = false;

    if (!kIsWeb) {
      bg.BackgroundGeolocation.stop();
    }

    logNoStack.i("NEST_AUTH2 LOGOUT , token is $token");
    apiPostNoLocale(
            token!, "$defaultAPIBaseUrl$defaultApiPrefixPath/persons/logout")
        .then((result) {
      log.i("NEST_AUTH2: LOGOUT result $result");
    }).catchError((error) {
      log.e("NEST_AUTH2 LOGOUT  api logout error ${error.toString()}");
    });

    token = null;

    // let the oidc package know
    await app_state.currentManager.logout(
      //after logout, go back to home
      originalUri: Uri.parse('/login'),
      options: OidcPlatformSpecificOptions(
        web: OidcPlatformSpecificOptions_Web(
          navigationMode: webNavigationMode,
        ),
      ),
    );

    //notifyListeners();

    state = false;
  }

  // void signIn() {
  //   logNoStack.i("NEST_AUTH_CONTROLLER : SIGN_IN");
  //   currentUser.isSignedIn = true;
  //   isLoggedIn = true;

  // }
}

//final nestAuthProvider = ChangeNotifierProvider((ref) => NestAuthController());

final nestAuthProvider = NotifierProvider<NestAuthController, bool>(
  () => NestAuthController(),
);

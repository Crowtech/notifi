import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart' as logger;
import 'package:notifi/api_utils.dart';
import 'package:notifi/credentials.dart';
import 'package:notifi/entities/auth.dart';
import 'package:notifi/jwt_utils.dart';
import 'package:notifi/notifi.dart';
import 'package:notifi/state/auth_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:oidc/oidc.dart';
import 'package:provider/provider.dart' as prov;
import 'package:flutter_background_geolocation/flutter_background_geolocation.dart'
    as bg;
import 'package:notifi/app_state.dart' as app_state;

import '../models/person.dart';

var log = logger.Logger(
  printer: logger.PrettyPrinter(),
  level: logger.Level.info,
);

var logNoStack = logger.Logger(
  printer: logger.PrettyPrinter(methodCount: 0),
  level: logger.Level.info,
);

class CurrentUserFetcher extends Notifier<Person> {
  late SharedPreferences _sharedPreferences;
  static const _sharedPrefsKey = 'token';

  OidcUser? oidcUser; // this stores tokens etc
  Locale locale = const Locale('en');
  OidcPlatformSpecificOptions_Web_NavigationMode webNavigationMode =
      OidcPlatformSpecificOptions_Web_NavigationMode.newPage;

  @override
  Person build() {
    return defaultPerson; // from Person.java
  }

  void fetchCurrentUser(OidcUser currentOidcUser) async {
    String deviceId = await fetchDeviceId();
    log.i(
        "CURRENT_USER: deviceid=$deviceId fetch currentUser from backend API using ${currentOidcUser.userInfo['email']}");
    apiPostDataNoLocale(
            getAccessToken(currentOidcUser),
            "$defaultAPIBaseUrl$defaultApiPrefixPath/persons/login",
            "deviceid",
            deviceId)
        .then((currentUser) {
      log.i("CURRENT_USER: Logged in api user returned $currentUser");
      state = currentUser;
      return;
    }).catchError((error) {
      log.d("CURRENT_USER: Login API  error");
    });
  }

  void setOidc(OidcUser? user) async {
    logNoStack.i("CURRENT_USER: SET_OIDC, Setting currentUser with Oidc user");
    if (user == null) {
      // if null then don't bother
      return;
    }
    oidcUser = user;

    Person person = state;
    person.email = getEmail(user);
    person.firstname = getFirstname(user);
    person.lastname = getLastname(user);
    person.code = getResourceCode(user);
    person.username = getUsername(user);
    person.name = "${person.firstname} ${person.lastname}";
    state = person;
  }

  void setPerson(Person user) async {
    logNoStack.i("CURRENT_USER: Setting currentUser with Person user ${user.email}");
    state = user;
  }

  void logout(/*BuildContext context*/) async {
    logNoStack.i("CURRENT_USER: LOGOUT!");
    if (oidcUser == null) {
      logNoStack.i("CURRENT_USER: LOGOUT OIDC USER IS NULL!!");
      //oidcUser = app_state.cachedAuthedUser.of(context);
    } else {
      logNoStack.i("CURRENT_USER: LOGOUT OIDC USER IS NOT NULL!!");
    }
    //print("Logout token=${getAccessToken(oidcUser!)}");

    if (!kIsWeb) {
      bg.BackgroundGeolocation.stop();
    }

// Let the backend know of the logout
    logNoStack.i("CURRENT_USER: Logout");
    _sharedPreferences = await SharedPreferences.getInstance();
    final savedToken = _sharedPreferences.getString(_sharedPrefsKey);
    if (savedToken != null) {
      logNoStack.i("CURRENT_USER: Logout,About to call logout API ");
      logNoStack.i("CURRENT_USER: Logout,calling $defaultAPIBaseUrl$defaultApiPrefixPath/persons/logout");
      apiPostNoLocale(savedToken,
              "$defaultAPIBaseUrl$defaultApiPrefixPath/persons/logout")
          .then((result) {
        log.i("CURRENT_USER: logout result $result");
        state = defaultPerson;
        oidcUser = null;
      }).catchError((error) {
        log.e("CURRENT_USER: Register logout error");
      });

      //prov.Provider.of<Notifi>(context, listen: false).preventAutoLogin = true;
      // let the oidc package know

        logNoStack.i("Finally , forgetting user");
    //await app_state.currentManager.forgetUser();

      logNoStack.i("CURRENT_USER: Logout,About to call oidc logout");
      await app_state.currentManager.logout(
        //after logout, go back to home
        originalUri: Uri.parse('/'),
        options: OidcPlatformSpecificOptions(
          web: OidcPlatformSpecificOptions_Web(
            navigationMode: webNavigationMode,
          ),
        ),
      );
    }


  }

  void setLocale(Locale locale) {
    this.locale = locale;
  }
}

// Notifier provider holding the state
final currentUserProvider =
    NotifierProvider<CurrentUserFetcher, Person>(CurrentUserFetcher.new);

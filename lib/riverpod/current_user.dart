import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart' as logger;
import 'package:notifi/api_utils.dart';
import 'package:notifi/credentials.dart';
import 'package:notifi/jwt_utils.dart';
import 'package:notifi/notifi.dart';
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
  OidcUser? oidcUser; // this stores tokens etc
  Locale locale = const Locale('en');
  OidcPlatformSpecificOptions_Web_NavigationMode webNavigationMode =
      OidcPlatformSpecificOptions_Web_NavigationMode.newPage;

  @override
  Person build() {
    return defaultPerson; // from Person.java
  }

  void setOidc(OidcUser ?user) async {
    logNoStack.i("Setting currentUser with Oidc user");
    if (user == null) { // if null then don't bother
      return;
    }
    oidcUser = user;

    Person person = state;
    person.email = getEmail(user);
    person.firstname = getFirstname(user);
    person.lastname = getLastname(user);
    person.code = getResourceCode(user);
    person.username = getUsername(user);
    person.name = person.firstname + " " + person.lastname;
    state = person;
  }

  void setPerson(Person user) async {
    logNoStack.i("Setting currentUser with Person user");
    state = user;
  }

  void logout(BuildContext context) async {
   // print("LOGOUT");
    if (oidcUser == null) {
     // print("LOGOUT OIDC USER IS NULL!!");
    }
    //print("Logout token=${getAccessToken(oidcUser!)}");

    if (!kIsWeb) {
      bg.BackgroundGeolocation.stop();
    }

// Let the backend know of the logout
    logNoStack.i("Logout token=${oidcUser!.token.accessToken!}");
    logNoStack.i("Logout locale=${locale}");
    logNoStack.i(
        "logout api=${"$defaultAPIBaseUrl$defaultApiPrefixPath/persons/logout"}");

    apiPost(locale, oidcUser!.token.accessToken!,
            "$defaultAPIBaseUrl$defaultApiPrefixPath/persons/logout")
        .then((result) {
      log.i("logout result $result");
      state = defaultPerson;
      oidcUser = null;
    }).catchError((error) {
      log.e("Register logout error");
    });

    prov.Provider.of<Notifi>(context, listen: false).preventAutoLogin = true;
    // let the oidc package know
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

  void setLocale(Locale locale) {
    this.locale = locale;
  }
}

// Notifier provider holding the state
final currentUserProvider =
    NotifierProvider<CurrentUserFetcher, Person>(CurrentUserFetcher.new);

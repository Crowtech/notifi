import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart' as logger;
import 'package:notifi/api_utils.dart';
import 'package:notifi/credentials.dart';
import 'package:notifi/jwt_utils.dart';
import 'package:oidc/oidc.dart';

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

  @override
  Person build() {
    return defaultPerson; // from Person.java
  }

  void setOidc(OidcUser user) async {
    logNoStack.i("Setting ucurrentUser with Oidc user");
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
    logNoStack.i("Setting ucurrentUser with Person user");
    state = user;
  }

  void logout() async {
    apiPost(locale, oidcUser!.token.accessToken!,
            "$defaultAPIBaseUrl$defaultApiPrefixPath/persons/logout")
        .then((result) {
      log.d("logout result $result");
      state = defaultPerson;
    }).catchError((error) {
      log.e("Register logout error");
    });
  }

  void setLocale(Locale locale)
  {
    this.locale = locale;
  }
}

// Notifier provider holding the state
final currentUserProvider =
    NotifierProvider<CurrentUserFetcher, Person>(CurrentUserFetcher.new);

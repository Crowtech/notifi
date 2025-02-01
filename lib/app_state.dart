// ignore_for_file: avoid_redundant_argument_values

import 'dart:io';

import 'package:async/async.dart';
import 'package:bdaya_shared_value/bdaya_shared_value.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart' as logger;
import 'package:notifi/credentials.dart';
import 'package:notifi/entities/auth.dart';
import 'package:notifi/jwt_utils.dart';
import 'package:notifi/state/auth_controller.dart';
import 'package:oidc/oidc.dart';
import 'package:oidc_default_store/oidc_default_store.dart';

var log = logger.Logger(
  printer: logger.PrettyPrinter(),
  level: logger.Level.info,
);

var logNoStack = logger.Logger(
  printer: logger.PrettyPrinter(methodCount: 0),
  level: logger.Level.info,
);

//This file represents a global state, which is bad
//in a production app (since you can't test it).

//usually you would use a dependency injection library
//and put these in a service.
//final exampleLogger = Logger('oidc.example');

/// Gets the current manager used in the example.
OidcUserManager currentManager = duendeManager;

final duendeManager = OidcUserManager.lazy(
  discoveryDocumentUri: OidcUtils.getOpenIdConfigWellKnownUri(
    Uri.parse('$defaultAuthBaseUrl/realms/$defaultRealm'),
  ),
  // this is a public client,
  // so we use [OidcClientAuthentication.none] constructor.
  clientCredentials: OidcClientAuthentication.none(
    clientId: defaultRealm,
  ),
  store: OidcDefaultStore(),

  // keyStore: JsonWebKeyStore(),
  settings: OidcUserManagerSettings(
    frontChannelLogoutUri: Uri(path: 'redirect.html'),
    uiLocales: ['en'],
    refreshBefore: (token) {
      return const Duration(seconds: 1);
    },
    strictJwtVerification: true,
    // set to true to enable offline auth
    supportOfflineAuth: false,
    // scopes supported by the provider and needed by the client.
    scope: defaultscopes, //['openid', 'profile', 'email', 'offline_access'],
    postLogoutRedirectUri: kIsWeb
        ? Uri.parse(defaultRedirectUrl)
        : Platform.isAndroid || Platform.isIOS || Platform.isMacOS
            ? Uri.parse('$defaultMobilePath:/endsessionredirect')
            : Platform.isWindows || Platform.isLinux
                ? Uri.parse('http://localhost:0')
                : null,
    redirectUri: kIsWeb
        // this url must be an actual html page.
        // see the file in /web/redirect.html for an example.
        //
        // for debugging in flutter, you must run this app with --web-port 5000
        ? Uri.parse(defaultRedirectUrl)
        : Platform.isIOS || Platform.isMacOS || Platform.isAndroid
            // scheme: reverse domain name notation of your package name.
            // path: anything.
            ? Uri.parse('$defaultMobilePath:/oauth2redirect')
            : Platform.isWindows || Platform.isLinux
                // using port 0 means that we don't care which port is used,
                // and a random unused port will be assigned.
                //
                // this is safer than passing a port yourself.
                //
                // note that you can also pass a path like /redirect,
                // but it's completely optional.
                ? Uri.parse('http://localhost:0')
                : Uri(),
  ),
);

///===========================

final initMemoizer = AsyncMemoizer<void>();
Future<void> initApp() {
  return initMemoizer.runOnce(() async {
    currentManager.userChanges().listen((event) async {
      cachedAuthedUser.$ = event;
      if (event?.userInfo != null) {
        var exp = event?.claims['exp'];
        var name = event?.claims['name'];
        var username = event?.claims['preferred_username'];
      
        var deviceId = await fetchDeviceId();
        logNoStack.i(
          'App State User changed (notifi lib): exp:$exp, $username, $name $deviceId',
        );
        logNoStack.i("token = ${event?.token.accessToken}");
          //ref.read(authControllerProvider.notifier).loginOidc( event );
      }
    });

    await currentManager.init();
  });
}

final cachedAuthedUser = SharedValue<OidcUser?>(value: null, autosave: false);

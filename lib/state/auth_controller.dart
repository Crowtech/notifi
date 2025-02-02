import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:notifi/api_utils.dart';
import 'package:notifi/credentials.dart';
import 'package:notifi/jwt_utils.dart';
import 'package:notifi/models/person.dart';
import 'package:notifi/notifi.dart';
import 'package:notifi/riverpod/current_user.dart';
import 'package:oidc/oidc.dart';

import '../entities/user_role.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:notifi/app_state.dart' as app_state;

import '../entities/auth.dart';
import 'package:logger/logger.dart' as logger;
import '../i18n/strings.g.dart';
import 'package:provider/provider.dart' as prov;
import 'package:flutter_background_geolocation/flutter_background_geolocation.dart'
    as bg;

part 'auth_controller.g.dart';

var log = logger.Logger(
  printer: logger.PrettyPrinter(),
  level: logger.Level.info,
);

var logNoStack = logger.Logger(
  printer: logger.PrettyPrinter(methodCount: 0),
  level: logger.Level.info,
);

/// A mock of an Authenticated User
const _dummyUser = Auth.signedIn(
  id: -1,
  displayName: 'My Name',
  email: 'My Email',
  resourcecode: 'PER_DUMMY',
  token: 'some-updated-secret-auth-token',
);

/// This controller is an [AsyncNotifier] that holds and handles our authentication state
@riverpod
class AuthController extends _$AuthController {
  late SharedPreferences _sharedPreferences;
  static const _sharedPrefsKey = 'token';

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
  Future<Auth> build() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    logNoStack.i("AUTH_CONTROLLER Build!");

    // listen for cachedAuthUser then call auth_controller login
    //ref.read(authControllerProvider.notifier).loginOidc( event );
    app_state.currentManager.userChanges().listen((event) async {
      logNoStack.i("Detected OIDC USER!!!!!");
      if (event?.userInfo != null) {
        var exp = event?.claims['exp'];
        var name = event?.claims['name'];
        var username = event?.claims['preferred_username'];

        var deviceId = await fetchDeviceId();
        logNoStack.i(
          'App State User changed (login): exp:$exp, $username, $name $deviceId',
        );
        logNoStack.i("token = ${event?.token.accessToken}");
        ref.read(authControllerProvider.notifier).loginOidc(event);
      }
    });

    _persistenceRefreshLogic();

    return _loginRecoveryAttempt();
  }

  /// Tries to perform a login with the saved token on the persistent storage.
  /// If _anything_ goes wrong, deletes the internal token and returns a [User.signedOut].
  Future<Auth> _loginRecoveryAttempt() async {
    logNoStack.i("In AuthControllerLogin:loginRecoveryAttempt");
    try {
      final savedToken = _sharedPreferences.getString(_sharedPrefsKey);
      if (savedToken == null) {
        throw const UnauthorizedException('No auth token found');
//       login("adam","crow");
// _sharedPreferences.remove(_sharedPrefsKey).ignore();
//       return Future.value(const Auth.signedOut());

//       } else {
//          logNoStack.i("In AuthControllerLogin:loginRecoveryAttempt-> savedToken NOT NULL");
//       }
      }
      return _loginWithToken(savedToken);
    } catch (_, __) {
      logNoStack.i(
          "In AuthControllerLogin:loginRecoveryAttempt-> Exception -> clearing key");
      _sharedPreferences.remove(_sharedPrefsKey).ignore();
      return Future.value(const Auth.signedOut());
    }
  }

  /// Mock of a request performed on logout (might be common, or not, whatevs).
  Future<void> logout(BuildContext context) async {
    logNoStack.i("logout called in auth");
    final savedToken = _sharedPreferences.getString(_sharedPrefsKey);

    if (!kIsWeb) {
      bg.BackgroundGeolocation.stop();
    }
    logNoStack.i("logout token is $savedToken");
    apiPostNoLocale(savedToken!,
            "$defaultAPIBaseUrl$defaultApiPrefixPath/persons/logout")
        .then((result) {
      log.i("logout result $result");
    }).catchError((error) {
      log.e("Register logout error ${error.toString()}");
    });

    _sharedPreferences.remove(_sharedPrefsKey).ignore();
    state = const AsyncData(Auth.signedOut());

    prov.Provider.of<Notifi>(context, listen: false).preventAutoLogin = true;

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
  }

  Future<void> loginOidc(OidcUser? oidcUser) async {
    logNoStack.i("In AuthControllerLogin: LOGIN to oidc");

    if (oidcUser != null) {
      logNoStack.i(
          "In AuthControllerLogin: oidcUser is ${oidcUser.userInfo['email']}");

      var authResult = Auth.signedIn(
          id: 32,
          displayName: getFirstname(oidcUser),
          email: getEmail(oidcUser),
          resourcecode: getResourceCode(oidcUser),
          token: getAccessToken(oidcUser));
      logNoStack.i("In AuthControllerLogin: auth user is $authResult");
      state = AsyncData(authResult);

      ref.read(currentUserProvider.notifier).fetchCurrentUser(oidcUser);
    } else {
      logNoStack.i("In AuthControllerLogin: oidcUser is NULL");
    }
  }

  /// Mock of a successful login attempt, which results come from the network.
  Future<void> login(String email, String password) async {
    //     final currentRoute = GoRouterState.of(context);
    // final originalUri =
    //     currentRoute.uri.queryParameters[OidcConstants_Store.originalUri];
    logNoStack.i("In AuthControllerLogin: LOGIN to oidc");
    // await app_state.currentManager.clearUnusedStates() ;

    const parsedOriginalUri = null;
    //   originalUri == null ? null : Uri.tryParse(originalUri);
    var result = await Future.delayed(
      networkRoundTripTime,
      () => _dummyUser,
    );

    state = AsyncData(result);

    // final isLoggedIn = await keycloakWrapper.login();
    // if (isLoggedIn) {
    //   var userInfo = await keycloakWrapper.getUserInfo();
    //   for (final mapEntry in userInfo!.entries) {
    //     final key = mapEntry.key;
    //     final value = mapEntry.value;
    //     print('Key: $key, Value: $value'); // Key: a, Value: 1 ...
    //   }
    //   var authResult = Auth.signedIn(
    //       id: 32,
    //       displayName: userInfo!["firstname"],
    //       email: userInfo!["email"],
    //       token: userInfo["token"]);
    //   logNoStack.i("In AuthControllerLogin: auth user is ${authResult}");
    //   state = AsyncData(authResult);
    //}
// logNoStack.i("In AuthControllerLogin: LOGIN jumping to oidc");
// var oidcUser = await app_state.currentManager.loginPassword(
//             username: testUsername,
//             password: testPassword,
//           );
//      final oidcUser = await app_state.currentManager.loginAuthorizationCodeFlow(
//      originalUri: parsedOriginalUri ?? Uri.parse('/'),
//     //       //store any arbitrary data, here we store the authorization
//     //       //start time.
    //      extraStateData: DateTime.now().toIso8601String(),
    //      options: _getOptions(),
//     //       //NOTE: you can pass more parameters here.
    //    );
//         if (oidcUser != null) {
    //   logNoStack.i("In AuthControllerLogin: oidcUser is ${oidcUser.userInfo['email']}");
    //   // ref.read(currentUserProvider.notifier).setOidc(oidcUser);
    //    var authResult = Auth.signedIn(id:32,displayName: getFirstname(oidcUser),email: getEmail(oidcUser),token: getAccessToken(oidcUser));
    //   logNoStack.i("In AuthControllerLogin: auth user is $authResult");
    // state = AsyncData(authResult);
    // } else {
    //   logNoStack.i("In AuthControllerLogin: oidcUser is NULL");
    // }
  }

  /// Mock of a login request performed with a saved token.
  /// If such request fails, this method will throw an [UnauthorizedException].
  Future<Auth> _loginWithToken(String token) async {
    logNoStack.i("In AuthControllerLoginWithToken: start");
    final logInAttempt = await Future.delayed(
      networkRoundTripTime,
      () => true, // edit this if you wanna play around
    );

    if (logInAttempt) return _dummyUser;

    throw const UnauthorizedException('401 Unauthorized or something');
  }

  /// Internal method used to listen authentication state changes.
  /// When the auth object is in a loading state, nothing happens.
  /// When the auth object is in an error state, we choose to remove the token
  /// Otherwise, we expect the current auth value to be reflected in our persistence API
  void _persistenceRefreshLogic() {
    ref.listenSelf((_, next) {
      if (next.isLoading) return;
      if (next.hasError) {
        _sharedPreferences.remove(_sharedPrefsKey);
        return;
      }

      next.requireValue.map<void>(
        signedIn: (signedIn) =>
            _sharedPreferences.setString(_sharedPrefsKey, signedIn.token),
        signedOut: (signedOut) {
          _sharedPreferences.remove(_sharedPrefsKey);
        },
      );
    });
  }
}

/// Simple mock of a 401 exception
class UnauthorizedException implements Exception {
  const UnauthorizedException(this.message);
  final String message;
}

/// Mock of the duration of a network request
final networkRoundTripTime = 2.seconds;

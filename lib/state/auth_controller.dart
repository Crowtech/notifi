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
  email: 'user@email.com',
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
      if (event?.userInfo != null) {
        var exp = event?.claims['exp'];
        var name = event?.claims['name'];
        var username = event?.claims['preferred_username'];

        var deviceId = await fetchDeviceId();
        logNoStack.i(
          'AUTH CONTROLLER BUILD: App State User changed (login): exp:$exp, $username, $name $deviceId',
        );
        // logNoStack.i("token = ${event?.token.accessToken}");
        //   var authResult = Auth.signedIn(
        //   id: currentPerson.id!,
        //   displayName: currentPerson.firstname,
        //   email: currentPerson.email,
        //   resourcecode: currentPerson.code!,
        //   token: oidcUser.token.accessToken!);

        // var authResult = Auth.signedIn(
        //     id: 32,
        //     displayName: getFirstname(oidcUser),
        //     email: getEmail(oidcUser),
        //     resourcecode: getResourceCode(oidcUser),
        //     token: getAccessToken(oidcUser));

        await loginOidc(event);
      } else {
        logNoStack.i("AUTH CONTROLLER BUILD: App State User changed to NULL:");
      }
    });

    _persistenceRefreshLogic();

    return _loginRecoveryAttempt();
  }

  /// Tries to perform a login with the saved token on the persistent storage.
  /// If _anything_ goes wrong, deletes the internal token and returns a [User.signedOut].
  Future<Auth> _loginRecoveryAttempt() async {
    log.i(
        "AUTH_CONTROLLER  LOGIN_RECOVERY ATTEMPT: START with sharedPrefsKey -> $_sharedPrefsKey");
    try {
      final savedToken = _sharedPreferences.getString(_sharedPrefsKey);
      logNoStack.i(
          'AUTH_CONTROLLER loginRecoveryAttempt: savedToken got.. $savedToken');
      if (savedToken == null) {
        logNoStack
            .i('AUTH_CONTROLLER loginRecoveryAttempt: savedTokenwas null ');
        throw const UnauthorizedException(
            'AUTH_CONTROLLER loginRecoveryAttempt: No auth token found');
      }
      // Try and work out if token valid
      logNoStack
          .i("AUTH_CONTROLLER loginRecoveryAttempt: savedToken is $savedToken");
      verifyToken(savedToken).then((isValid) {
        logNoStack.i(
            "AUTH_CONTROLLER loginRecoveryAttempt: token validity is ${isValid ? 'true' : 'false'}");
        if (!isValid) {
          throw const UnauthorizedException(
              'AUTH_CONTROLLER loginRecoveryAttempt: Auth Token logged out or expired');
        } else {
          logNoStack
              .i("AUTH_CONTROLLER loginRecoveryAttempt: savedToken is good ");
          return _loginWithToken(savedToken);
        }
      });
    } catch (_, __) {
      logNoStack.i(
          "AUTH_CONTROLLER loginRecoveryAttempt-> Exception -> clearing key");
      _sharedPreferences.remove(_sharedPrefsKey).ignore();
      logNoStack.i(
          "AUTH_CONTROLLER loginRecoveryAttempt-> removed shared key $_sharedPrefsKey");
      ref.read(currentUserProvider.notifier).setPerson(defaultPerson);
      state = const AsyncData(Auth.signedOut());
      //ref.read(currentUserProvider.notifier).logout();
      return Future.value(const Auth.signedOut());
    }
    return Future.value(const Auth.signedOut());
  }

  Future<void> login() async {
    logNoStack.i("AUTH_CONTROLLER LOGIN called.");

    //  Auth user = await  _loginRecoveryAttempt();

    //if ( !user.isAuth) {

    app_state.currentManager
        .loginAuthorizationCodeFlow(
      originalUri: Uri.parse('/'),
      //store any arbitrary data, here we store the authorization
      //start time.
      extraStateData: DateTime.now().toIso8601String(),
      options: _getOptions(),
      //NOTE: you can pass more parameters here.
    )
        .then((result) {
      logNoStack.i("AUTH_CONTROLLER LOGIN called and RESULT provided");
      if (result != null) {
        logNoStack.i(
            "AUTH_CONTROLLER LOGIN called and RESULT provided IS NOT NULL, setting oidc ${result.userInfo['email']}");
        ref.read(currentUserProvider.notifier).setOidc(result);
      } else {
        logNoStack
            .i("AUTH_CONTROLLER LOGIN called and RESULT provided IS  NULL");
      }
    });
  }

  Future<void> loginOidc(OidcUser? oidcUser) async {
    log.i("AUTH_CONTROLLER  LOGIN_OIDC: START");
    
  

    if (oidcUser != null) {
      log.i(
          "AUTH_CONTROLLER  LOGIN_OIDC: In AuthControllerLogin: oidcUser is ${oidcUser.userInfo['email']} fetching user ");

// Now fetch the actual user from the backend

      log.i("AUTH_CONTROLLER  LOGIN_OIDC: SAbout to register Token");
      var currentPerson = await registerLogin(oidcUser.token.accessToken!);

      var authResult = Auth.signedIn(
          id: currentPerson.id!,
          displayName: currentPerson.firstname,
          email: currentPerson.email,
          resourcecode: currentPerson.code!,
          token: oidcUser.token.accessToken!);

      // var authResult = Auth.signedIn(
      //     id: 32,
      //     displayName: getFirstname(oidcUser),
      //     email: getEmail(oidcUser),
      //     resourcecode: getResourceCode(oidcUser),
      //     token: getAccessToken(oidcUser));
      log.i(
          "AUTH_CONTROLLER  LOGIN_OIDC fetched Person: auth user is $authResult");

      ref.read(currentUserProvider.notifier).setPerson(currentPerson);
      state = AsyncData(authResult);
    } else {
      logNoStack.i(
          "AUTH_CONTROLLER LOGIN_OIDC: In AuthControllerLogin: oidcUser was NULL");
    }
  }

//   Future<void> loginPerson(Person currentPerson) async {
//     logNoStack.i(
//         "AUTH_CONTROLLER  LOGIN person! from backend person is ${currentPerson}");
//     if (state.hasValue) {
// // var authUser = (Auth)state.value;

// //       var authResult = Auth.signedIn(
// //           id: currentPerson.id!,
// //           displayName: currentPerson.firstname,
// //           email: currentPerson.email,
// //           resourcecode: currentPerson.code!,
// //           token: authUser.token;
// //       logNoStack.i("In AuthControllerLogin: auth user is $authResult");
// //       state = AsyncData(authResult);

// //     } else {
// //       logNoStack.i("In AuthControllerLogin: person is NULL");
// //     }
//     }
//   }

  /// Mock of a successful login attempt, which results come from the network.
  Future<void> loginUsernamePassword(String email, String password) async {
    //     final currentRoute = GoRouterState.of(context);
    // final originalUri =
    //     currentRoute.uri.queryParameters[OidcConstants_Store.originalUri];
    logNoStack.i("AUTH_CONTROLLER  LOGIN EMAIL/PASSWORD $email $password ");
    // await app_state.currentManager.clearUnusedStates() ;

    // const parsedOriginalUri = null;
    // //   originalUri == null ? null : Uri.tryParse(originalUri);
    // var result = await Future.delayed(
    //   networkRoundTripTime,
    //   () => _dummyUser,
    // );

    try {
     var result = await  app_state.currentManager
          .loginPassword(
        username: email,
        password: password,
      );
      logNoStack.i("AUTH_CONTROLLER  LOGIN EMAIL/PASSWORD : result is $result");
       //   .then((result) {
        logNoStack.i(
            "AUTH_CONTROLLER  LOGIN EMAIL/PASSWORD :Result is ${result!.claims.toJson()['email']}!!!!!");
        loginOidc(result);
    //  });

     
    } catch (e) {
      logNoStack.e("AUTH_CONTROLLER  LOGIN EMAIL/PASSWORD  ${e.toString()}");
    
    }

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
    logNoStack.i("AUTH_CONTROLLER  LOGIN_TOKEN: In AuthController");

// Now fetch the actual user from the backend

    try {
      var currentPerson = await registerLogin(token);

      var authResult = Auth.signedIn(
          id: currentPerson.id!,
          displayName: currentPerson.firstname,
          email: currentPerson.email,
          resourcecode: currentPerson.code!,
          token: token);

      logNoStack.i("AUTH_CONTROLLER  LOGIN_TOKEN: auth user is $authResult");
      state = AsyncData(authResult);
      ref.read(currentUserProvider.notifier).setPerson(currentPerson);
    } on Exception catch (_) {
      Future.value(const Auth.signedOut());
    }
    return Future.value(const Auth.signedOut()); // dummy
  }

  /// Mock of a request performed on logout (might be common, or not, whatevs).
  Future<void> logoutContext(BuildContext context) async {
    logNoStack.i("AUTH_CONTROLLER LOGOUT called in auth");
    final savedToken = _sharedPreferences.getString(_sharedPrefsKey);

    if (!kIsWeb) {
      bg.BackgroundGeolocation.stop();
    }
    logNoStack.i("AUTH_CONTROLLER LOGOUT , token is $savedToken");
    apiPostNoLocale(savedToken!,
            "$defaultAPIBaseUrl$defaultApiPrefixPath/persons/logout")
        .then((result) {
      log.i("AUTH_CONTROLLER LOGOUT result $result");
    }).catchError((error) {
      log.e(
          "AUTH_CONTROLLER LOGOUT  Register logout error ${error.toString()}");
    });

    _sharedPreferences.remove(_sharedPrefsKey).ignore();
    ref.read(currentUserProvider.notifier).setPerson(defaultPerson);
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

  /// Mock of a request performed on logout (might be common, or not, whatevs).
  Future<void> logout() async {
    logNoStack.i("AUTH_CONTROLLER LOGOUT called ");
    final savedToken = _sharedPreferences.getString(_sharedPrefsKey);
    _sharedPreferences.remove(_sharedPrefsKey).ignore();
    if (!kIsWeb) {
      // bg.BackgroundGeolocation.stop();
    }
    logNoStack.i("AUTH_CONTROLLER LOGOUT , token is $savedToken");
    var result = await apiPostNoLocale(
        savedToken!, "$defaultAPIBaseUrl$defaultApiPrefixPath/persons/logout");

    log.i("AUTH_CONTROLLER LOGOUT back from api result $result");
    defaultPerson.email = "user@email.com";
    defaultPerson.token = null;
    log.i("AUTH_CONTROLLER LOGOUT setting Person to default $defaultPerson");
    ref.read(currentUserProvider.notifier).setPerson(defaultPerson);

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
    state = const AsyncData(Auth.signedOut());
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

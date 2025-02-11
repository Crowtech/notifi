import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:notifi/jwt_utils.dart';
import 'package:notifi/notifi.dart';
import 'package:oidc/oidc.dart';

import '../state/auth_controller.dart';
import '../widgets/action_button.dart';
import 'package:notifi/app_state.dart' as app_state;
import 'package:logger/logger.dart' as logger;
import 'package:provider/provider.dart' as prov;

var log = logger.Logger(
  printer: logger.PrettyPrinter(),
  level: logger.Level.info,
);

var logNoStack = logger.Logger(
  printer: logger.PrettyPrinter(methodCount: 0),
  level: logger.Level.info,
);

class LoginPage extends HookConsumerWidget {
  LoginPage({super.key});

  OidcPlatformSpecificOptions_Web_NavigationMode webNavigationMode =
      OidcPlatformSpecificOptions_Web_NavigationMode.newPage;

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
  Widget build(BuildContext context, WidgetRef ref) {
    logNoStack.i(
      'LOGINPAGE: ',
    );
    Future<void> login2() async {
      ref.read(authControllerProvider.notifier).login();
    }

    Future<void> login() =>
        ref.read(authControllerProvider.notifier).loginUsernamePassword(
              'myEmail',
              'myPassword',
            );

      Future<void> login3() async {

  

    final currentRoute = GoRouterState.of(context);
    final originalUri =
        currentRoute.uri.queryParameters[OidcConstants_Store.originalUri];
    final parsedOriginalUri =
        originalUri == null ? null : Uri.tryParse(originalUri);
    try {
      OidcUser? result;
    
        result = await app_state.currentManager.loginAuthorizationCodeFlow(
          originalUri: parsedOriginalUri ?? Uri.parse('/'),
          //store any arbitrary data, here we store the authorization
          //start time.
          extraStateData: DateTime.now().toIso8601String(),
          options: _getOptions(),
          //NOTE: you can pass more parameters here.
        );
        if (result != null) {
          //ref.read(currentUserProvider.notifier).setOidc(result);
            logNoStack
          .i("loginPage accessToken = ${getAccessToken(result)}");
        } else {
            logNoStack
          .i("loginPage accessToken is null");
        }
   
  
      if (kIsWeb &&
          webNavigationMode ==
              OidcPlatformSpecificOptions_Web_NavigationMode.samePage) {
        //in samePage navigation, you can't know the result here.
        return;
      } 
    } catch (e) {
      app_state.log.e(e.toString());
    }
  }


    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Login Page'),
            ActionButton(
              onPressed: login2,
              icon: const SizedBox.shrink(),
              label: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}

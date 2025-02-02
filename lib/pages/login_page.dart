import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:oidc/oidc.dart';

import '../state/auth_controller.dart';
import '../widgets/action_button.dart';
import 'package:notifi/app_state.dart' as app_state;

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
      logNoStack.i( 'LOGINPAGE: ',);
    Future<void> login2() async  {
         var result = await app_state.currentManager.loginAuthorizationCodeFlow(
          originalUri:  Uri.parse('/'),
          //store any arbitrary data, here we store the authorization
          //start time.
          extraStateData: DateTime.now().toIso8601String(),
          options: _getOptions(),
          //NOTE: you can pass more parameters here.
        );
        if (result != null) {
          //ref.read(currentUserProvider.notifier).setOidc(result);
        } else {
          print("************* result is ${result!.userInfo['email']}");
        }
    }

    Future<void> login() => ref.read(authControllerProvider.notifier).login(
          'myEmail',
          'myPassword',
        );

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

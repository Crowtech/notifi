import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:notifi/credentials.dart';
import 'package:notifi/state/nest_auth2.dart';
import 'package:notifi/widgets/action_button.dart';
import 'package:oidc/oidc.dart';


import 'package:notifi/i18n/strings.g.dart' as nt;
import 'package:logger/logger.dart' as logger;

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
  Widget build(BuildContext context, WidgetRef ref) {
    if (skipLogin) {
      logNoStack.i("LOGIN_PAGE LOCAL: skipping login");

      if (context.mounted) {
        logNoStack.i("LOGIN_PAGE LOCAL: skipping login context mounted ");
        // go to sign in page after completing onboarding
        // ref
        //     .read(nestAuthProvider.notifier)
        //     .loginUsernamePassword(testUsername, testPassword);

        //context.goNamed(AppRoute.login.name);
      }
      return const SizedBox.shrink();
      // };
    } 
      final isAuth = ref.read(nestAuthProvider.notifier);


 if (isAuth==true) {
      context.goNamed("home");
    } 

    Future<void> login() async {

      ref.read(nestAuthProvider.notifier).login();
    }


    FlutterNativeSplash.remove();
    logNoStack.i("LOGIN_PAGE: show page ");

    //return const SizedBox.shrink();
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(nt.t.login_page),
            ActionButton(
              onPressed: login,
              icon: const SizedBox.shrink(),
              label: Text(nt.t.login),
            ),
          ],
        ),
      ),
    );
  }
}

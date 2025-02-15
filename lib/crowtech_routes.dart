import 'package:go_router/go_router.dart';
import 'package:notifi/auth.dart';
import 'package:notifi/screens/splash_screen.dart';
import 'package:notifi/test_pages/test_page.dart';
import 'package:oidc/oidc.dart';
import 'package:posthog_flutter/posthog_flutter.dart';


import 'package:notifi/app_state.dart' as app_state;

import 'package:logger/logger.dart';
import '../i18n/strings.g.dart';
//import 'pages/crow_home_page.dart';

var logger = Logger(
  printer: PrettyPrinter(),
);


class CrowtechRoutes {
  static const String splash = '/';
  static const String initial = "/initial";
  static const String login = '/login';
  static const String dashboard = '/dashboard';
  static const String newdashboard = '/new';
  static const String map = '/map';
  static const String location = '/location';
  static const String badge = '/badge';
  static const String advanced = "/advanced";
  static const String test = "/test";
  static const String choose = "/choose";
  static const String auth = "/auth";
  static const String home = "/home";

}

final GoRouter router = GoRouter(
  initialLocation: CrowtechRoutes.auth,
  
  observers: [PosthogObserver()],
  routes: [

    GoRoute(
      path: CrowtechRoutes.home,
      redirect: (context, state) {
        final oidcuser = app_state.cachedAuthedUser.of(context);

        if ((oidcuser == null) ){
          return Uri(
            path: CrowtechRoutes.auth,
            queryParameters: {
              // Note that this requires usePathUrlStrategy(); from `package:flutter_web_plugins/url_strategy.dart`
              // and set
              OidcConstants_Store.originalUri: state.uri.toString(),
            },
          ).toString();
        }
        return null;
      },
      builder: (context, state) => const TestPage(),
    ),
    GoRoute(
      path: CrowtechRoutes.auth,
      redirect: (context, state) {
        //
        final user = app_state.cachedAuthedUser.of(context);
        if (user != null) {
          final originalUri =
              state.uri.queryParameters[OidcConstants_Store.originalUri];
          if (originalUri != null) {
            return originalUri;
          }
          return CrowtechRoutes.home;
        }
        return null;
      },
      builder: (context, state) =>  AuthPage(title:t.app_title),
    ),
    GoRoute(
      path: CrowtechRoutes.splash,
      builder: (context, state) => SplashScreen(nextScreenRoute:CrowtechRoutes.home),
    ),
  
  
    // GoRoute(
    //    path: CrowtechRoutes.newdashboard,
    //   redirect: (context, state) {
    //     final user = app_state.cachedAuthedUser.of(context);

    //     if (user == null) {
    //       return Uri(
    //         path: CrowtechRoutes.auth,
    //         queryParameters: {
    //           // Note that this requires usePathUrlStrategy(); from `package:flutter_web_plugins/url_strategy.dart`
    //           // and set
    //           OidcConstants_Store.originalUri: state.uri.toString(),
    //         },
    //       ).toString();
    //     }
    //     return null;
    //   },
    //   builder: (context, state) => const HomePage(),
    // ),
    // GoRoute(
    //    path: CrowtechRoutes.dashboard,
    //   redirect: (context, state) {
    //     final user = app_state.cachedAuthedUser.of(context);

    //     if (user == null) {
    //       return Uri(
    //         path: CrowtechRoutes.auth,
    //         queryParameters: {
    //           // Note that this requires usePathUrlStrategy(); from `package:flutter_web_plugins/url_strategy.dart`
    //           // and set
    //           OidcConstants_Store.originalUri: state.uri.toString(),
    //         },
    //       ).toString();
    //     }
    //     return null;
    //   },
    //   builder: (context, state) => const HomePage(),
    // ),


   
  ],
);

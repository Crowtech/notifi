// ignore_for_file: avoid_redundant_argument_values


import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:notifi/credentials.dart';

import 'package:notifi/notifi.dart';
import 'package:oidc/oidc.dart';

import 'package:notifi/app_state.dart' as app_state;
import 'package:provider/provider.dart';

import 'package:logger/logger.dart' as logger;
import 'package:notifi/i18n/strings.g.dart' as nt;



var log = logger.Logger(
  printer: logger.PrettyPrinter(),
  level: logger.Level.info,
);

var logNoStack = logger.Logger(
  printer: logger.PrettyPrinter(methodCount: 0),
  level: logger.Level.info,
);

class AuthPage extends StatefulWidget {
  const AuthPage({super.key, required this.title});

  final String title;

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();

  OidcPlatformSpecificOptions_Web_NavigationMode webNavigationMode =
      OidcPlatformSpecificOptions_Web_NavigationMode.samePage; // was newPage

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
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      gotoLogin();
    });
  }

  void gotoLogin() async {
    final currentRoute = GoRouterState.of(context);
    final originalUri =
        currentRoute.uri.queryParameters[OidcConstants_Store.originalUri];
    final parsedOriginalUri =
        originalUri == null ? null : Uri.tryParse(originalUri);
    try {
      OidcUser? result;
      if (skipLogin && (!Provider.of<Notifi>(context,listen:false).preventAutoLogin)) {
        logNoStack.i("Skipping Login!");
        // final messenger = ScaffoldMessenger.of(context);
        try {
          result = await app_state.currentManager.loginPassword(
            username: testUsername,
            password: testPassword,
          );
          logNoStack.i("Result is ${result.toString()}");
          // messenger.showSnackBar(
          //   SnackBar(
          //     content: Text(
          //       'loginPassword returned user id: ${result?.uid}',
          //     ),
          //   ),
          // );
        } catch (e) {
          logNoStack.e(e.toString());
          // messenger.showSnackBar(
          //   const SnackBar(
          //     content: Text(
          //       'loginPassword failed!',
          //     ),
          //   ),
          // );
        }
      } else {
        result = await app_state.currentManager.loginAuthorizationCodeFlow(
          originalUri: parsedOriginalUri ?? Uri.parse('/'),
          //store any arbitrary data, here we store the authorization
          //start time.
          extraStateData: DateTime.now().toIso8601String(),
          options: _getOptions(),
          //NOTE: you can pass more parameters here.
        );
      }
      log.d("AUTH RESULT is ${result!.userInfo.toString()}");

      logNoStack
          .i("gotoLogin accessToken = ${result.userInfo['access_token']}");

     // initNotifi(result.userInfo['access_token'], "", defaultRealm);

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

  @override
  Widget build(BuildContext context) {
    //remember, you can only enter this route if there is no user.
    final currentRoute = GoRouterState.of(context);
    final originalUri =
        currentRoute.uri.queryParameters[OidcConstants_Store.originalUri];
    final parsedOriginalUri =
        originalUri == null ? null : Uri.tryParse(originalUri);

    return Consumer<Notifi>(builder: (context, notifi, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            "${widget.title} !!! ${Provider.of<Notifi>(context, listen: false).packageInfo!.version}",
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: ListView(
            children: [
              //   const Text('Resource owner grant'),
              //   TextField(
              //     controller: userNameController,
              //     decoration: const InputDecoration(
              //       labelText: 'username',
              //     ),
              //   ),
              //   TextField(
              //     controller: passwordController,
              //     decoration: const InputDecoration(
              //       labelText: 'password',
              //     ),
              //   ),
              //   const SizedBox(height: 8),
              //   ElevatedButton(
              //     onPressed: () async {
              //       final messenger = ScaffoldMessenger.of(context);
              //       try {
              //         final result = await app_state.currentManager.loginPassword(
              //           username: userNameController.text,
              //           password: passwordController.text,
              //         );

              //         messenger.showSnackBar(
              //           SnackBar(
              //             content: Text(
              //               'loginPassword returned user id: ${result?.uid}',
              //             ),
              //           ),
              //         );
              //       } catch (e) {
              //         app_state.exampleLogger.severe(e.toString());
              //         messenger.showSnackBar(
              //           const SnackBar(
              //             content: Text(
              //               'loginPassword failed!',
              //             ),
              //           ),
              //         );
              //       }
              //     },
              //     child: const Text('login with Resource owner grant'),
              //   ),
              //   const Divider(),
              // if (kIsWeb) ...[
              //   Text(
              //     'Login Web Navigation Mode',
              //     style: Theme.of(context).textTheme.headlineSmall,
              //   ),
              //   DropdownButton<OidcPlatformSpecificOptions_Web_NavigationMode>(
              //     items: OidcPlatformSpecificOptions_Web_NavigationMode.values
              //         .map(
              //           (e) => DropdownMenuItem(
              //             value: e,
              //             child: Text(e.name),
              //           ),
              //         )
              //         .toList(),
              //     value: webNavigationMode,
              //     onChanged: (value) {
              //       if (value == null) {
              //         return;
              //       }
              //       setState(() {
              //         webNavigationMode = value;
              //       });
              //     },
              //   ),
              //   const Divider(),
              // ],
              ElevatedButton(
                onPressed: () async {
                  final messenger = ScaffoldMessenger.of(context);
                  try {
                    final result = await app_state.currentManager
                        .loginAuthorizationCodeFlow(
                      originalUri: parsedOriginalUri ?? Uri.parse('/'),
                      //store any arbitrary data, here we store the authorization
                      //start time.
                      extraStateData: DateTime.now().toIso8601String(),
                      options: _getOptions(),
                      //NOTE: you can pass more parameters here.
                    );
                    if (kIsWeb &&
                        webNavigationMode ==
                            OidcPlatformSpecificOptions_Web_NavigationMode
                                .samePage) {
                      //in samePage navigation, you can't know the result here.
                      return;
                    }
                    messenger.showSnackBar(
                      SnackBar(
                        content: Text(
                          'loginAuthorizationCodeFlow returned user id: ${result?.uid}',
                        ),
                      ),
                    );
                  } catch (e) {
                    app_state.log.e(e.toString());
                    messenger.showSnackBar(
                      SnackBar(
                        content: Text(
                          'loginAuthorizationCodeFlow failed! ${e is OidcException ? e.message : ""}',
                        ),
                      ),
                    );
                  }
                },
                child: Text(nt.t.login),
              ),
              // const Divider(),
              // ElevatedButton(
              //   onPressed: () async {
              //     final messenger = ScaffoldMessenger.of(context);

              //     // ignore: deprecated_member_use
              //     final result = await app_state.currentManager.loginImplicitFlow(
              //       responseType: OidcConstants_AuthorizationEndpoint_ResponseType
              //           .idToken_Token,
              //       originalUri: parsedOriginalUri ?? Uri.parse('/'),
              //       //store any arbitrary data, here we store the authorization
              //       //start time.
              //       extraStateData: DateTime.now().toIso8601String(),
              //     );
              //     if (kIsWeb &&
              //         webNavigationMode ==
              //             OidcPlatformSpecificOptions_Web_NavigationMode
              //                 .samePage) {
              //       //in samePage navigation, you can't know the result here.
              //       return;
              //     }
              //     messenger.showSnackBar(
              //       SnackBar(
              //         content: Text(
              //           'loginImplicitFlow returned user id: ${result?.uid}',
              //         ),
              //       ),
              //     );
              //   },
              //   child: const Text('Start Implicit flow'),
              // ),
            ],
          ),
        ),
      );
    });
  }

  void directLogin() async {
    // skip login
  }
}

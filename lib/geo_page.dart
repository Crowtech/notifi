import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:notifi/credentials.dart';
import 'package:notifi/jwt_utils.dart';
import 'package:notifi/notifi.dart';
import 'package:notifi/riverpod/current_user.dart';

import 'package:oidc/oidc.dart';
import 'package:notifi/app_state.dart' as app_state;

import 'package:provider/provider.dart' as prov;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:logger/logger.dart' as logger;
import 'package:flutter_background_geolocation/flutter_background_geolocation.dart'
    as bg;
import '../util/dialog.dart' as util;

var log = logger.Logger(
  printer: logger.PrettyPrinter(),
  level: logger.Level.info,
);

var logNoStack = logger.Logger(
  printer: logger.PrettyPrinter(methodCount: 0),
  level: logger.Level.info,
);

class GeoPage extends ConsumerStatefulWidget with WidgetsBindingObserver {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  GeoPage({super.key});

 OidcPlatformSpecificOptions_Web_NavigationMode webNavigationMode =
      OidcPlatformSpecificOptions_Web_NavigationMode.newPage;

  @override
  ConsumerState<GeoPage> createState() => _GeoPageState();
}

class _GeoPageState extends ConsumerState<GeoPage> 
    with TickerProviderStateMixin<GeoPage>, WidgetsBindingObserver {

      

  bool _loggedin = false;
  OidcUser? _user;
  bool? _isMoving = false;
  double _odometer = 0.0;
  bool _enabled = true;
  bool _geoStarted = false;
  late bg.Location _location;
  String? token;
  String apiUrl = defaultAPIBaseUrl;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // GoRouter.of(context).go('/secret-route');
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final user = app_state.cachedAuthedUser.of(context);
    if ((user != null) && (!_loggedin)) {
      log.i("home page didChangeDependencies: initNotifi");
     // initNotifi(context, user.token.accessToken.toString(), defaultRealm);
     // loginUser(context, user.token.accessToken!);
      setState(() {
        _loggedin = true;
        token = user.token.accessToken!;
      });
    }
  }

  void initGeolocation() {
    if (!kIsWeb) {
      bg.BackgroundGeolocation.onLocation(_onLocation, _onLocationError);
      bg.BackgroundGeolocation.onMotionChange(_onMotionChange);
      bg.BackgroundGeolocation.onAuthorization(_onAuthChange);
      bg.BackgroundGeolocation.onHttp(_onHttp);
      bg.BackgroundGeolocation.onHeartbeat(_onHeartbeat);

      bg.BackgroundGeolocation.ready(bg.Config(
              allowIdenticalLocations: true,
              autoSync: true,
              desiredAccuracy: bg.Config.DESIRED_ACCURACY_HIGH,
              distanceFilter: 10.0,
              maxDaysToPersist: 3,
              enableHeadless: true,
              stopOnTerminate: false,
              stationaryRadius: 25,
              stopTimeout: 1,
              startOnBoot: true,
              locationsOrderDirection: "ASC",
              backgroundPermissionRationale: bg.PermissionRationale(
                  title:
                      "Allow {applicationName} to access this device's location even when the app is closed or not in use.",
                  message:
                      "This app collects location data to enable recording your trips to work and calculate distance-travelled.",
                  positiveAction:
                      'Change to "{backgroundPermissionOptionLabel}"',
                  negativeAction: 'Cancel'),
            //    notification: bg.Notification(
            // sticky: false,
            // layout: 'notification_layout',
            // channelId: 'my_channel_id',
            // actions: ["notificationButtonFoo", "notificationButtonBar"]),
              debug: false,
              heartbeatInterval: 250,
              preventSuspend: true,
              batchSync: true,
              maxBatchSize: 1,
              disableElasticity: false,
              headers: {
                "Authorization":
                    "Bearer ${app_state.cachedAuthedUser.of(context)!.token.accessToken}"
              },
              extras: {
                "orgid": 2,
                "resourcecode":
                    getResourceCode(app_state.cachedAuthedUser.of(context)!),
                "resourceid": 0,
                "deviceid": prov.Provider.of<Notifi>(context).deviceId,
              },
              method: "POST",
              url: "$defaultAPIBaseUrl$defaultApiPrefixPath/gps/location",
              logLevel: bg.Config.LOG_LEVEL_VERBOSE))
          .then((bg.State state) async {
        log.i('[ready] ${state.toMap()}');
        log.i('[didDeviceReboot] ${state.didDeviceReboot}');
        if (state.schedule!.isNotEmpty) {
          log.i("Start bg schedule");
          bg.BackgroundGeolocation.startSchedule();
        }

        if (!state.enabled) {
          ////
          // 3.  Start the plugin.
          //
          log.i("Starting bg");
          bg.BackgroundGeolocation.start();
          var location = await bg.BackgroundGeolocation.getCurrentPosition();

          setState(() {
            _enabled = state.enabled;
            _isMoving = state.isMoving;
            _odometer = state.odometer;
            _location = location;
          });
        } else {
          setState(() {
            _isMoving = state.isMoving;
            _odometer = state.odometer;
          });
        }
      });
      log.i("******** GeoLocation Started");
    }
  }

  void _onHeartbeat(bg.HeartbeatEvent event) {
     if (!context.mounted) {
      return;
    }
    logNoStack.d("[heartbeat] ${event.toString()}");
    bg.BackgroundGeolocation.setConfig(bg.Config(
      headers: {
        "Authorization":
            "Bearer ${app_state.cachedAuthedUser.of(context)!.token.accessToken}"
      },
      url: "$defaultAPIBaseUrl$defaultApiPrefixPath/gps/location",
    ));
  }

  void _onHttp(bg.HttpEvent response) {
    int status = response.status;
    bool success = response.success;

    String responseText = response.responseText;
    logNoStack.d(
        '[onHttp] status: $status, success? $success, responseText: $responseText');
  }

  void _onAuthChange(bg.AuthorizationEvent event) async {
    if (!context.mounted) {
      return;
    }
    logNoStack.d("[authorization] ${event.toString()}");

    if (event.success) {
      logNoStack.d("- Authorization response: ${event.response}");
    } else {
      // work out expiry
      Map<String, dynamic> decodedToken = JwtDecoder.decode(
          app_state.cachedAuthedUser.of(context)!.token.accessToken!);
      int expiry = decodedToken['exp'];
      logNoStack.e(
          "- Authorization error: ${event.error} , ${event.response.toString()} , accessTokenExpiry=$expiry");

    }
  }

  void _onLocation(bg.Location location) async {
    log.d('[${bg.Event.LOCATION}] - $location');
    setState(() {
      _location = location;
    });
  }

  void _onLocationError(bg.LocationError error) {
    if (!context.mounted) {
      return;
    }
    log.d('[${bg.Event.LOCATION}] ERROR - $error');

  }

  void _onMotionChange(bg.Location location) {
    if (!context.mounted) {
      return;
    }
    log.d('[${bg.Event.MOTIONCHANGE}] - $location');
    setState(() {
      _isMoving = location.isMoving;
    });
  }

  OidcUser? processUser()
  {
     OidcUser? oldUser;
    final user = app_state.cachedAuthedUser.of(context);
    if (user == null) {
      // put a guard here as well, just in case
      // the redirect doesn't fire up in time.
      return user;
    } else {
      if (user != oldUser) {
        bg.BackgroundGeolocation.setConfig(bg.Config(
      headers: {
        "Authorization":
            "Bearer ${app_state.cachedAuthedUser.of(context)!.token.accessToken}"
      },
      url: "$defaultAPIBaseUrl$defaultApiPrefixPath/gps/location",
    ));
      }

      if (!_geoStarted) {
        setState(() {
          _geoStarted = true;
        });
        initGeolocation();
      }
    }
    return user;
  }

  @override
  Widget build(BuildContext context) {
   
   OidcUser? user = processUser();
   if (user == null) {
      return const SizedBox.shrink();
   }

    final platform = Theme.of(context).platform;
    final mobilePlatforms = [
      TargetPlatform.android,
      TargetPlatform.iOS,
      TargetPlatform.fuchsia,
    ];

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: SelectableRegion(
          focusNode: FocusNode(),
          selectionControls: kIsWeb
              ? mobilePlatforms.contains(platform)
                  ? MaterialTextSelectionControls()
                  : DesktopTextSelectionControls()
              : MaterialTextSelectionControls(),
          child: ListView(
            children: [
              Center(
                child: Text(
                  "Crowtech  ${prov.Provider.of<Notifi>(context, listen: false).packageInfo!.version}",
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              ),
              // ElevatedButton(
              //   onPressed: () {
              //     GoRouter.of(context).go('/');
              //   },
              //   child: const Text('back to home'),
              // ),
              const Divider(),
              ElevatedButton(
                onPressed: () async {
                  try {
                    final res = await app_state.currentManager
                        .loginAuthorizationCodeFlow(
                      // you can change scope too!
                      scopeOverride: [
                        ...app_state.currentManager.settings.scope,
                        'api',
                      ],
                      promptOverride: ['none'],
                      options: const OidcPlatformSpecificOptions(
                        web: OidcPlatformSpecificOptions_Web(
                          navigationMode:
                              OidcPlatformSpecificOptions_Web_NavigationMode
                                  .hiddenIFrame,
                        ),
                      ),
                    );
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content:
                              Text('silently authorized user! ${res?.uid}'),
                        ),
                      );
                    }
                  } on OidcException catch (e) {
                    if (e.errorResponse != null) {
                      await app_state.currentManager.forgetUser();
                    }
                  } catch (e, st) {
                    app_state.log.e('Failed to silently authorize user $e $st');
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Failed to silently authorize user'),
                        ),
                      );
                    }
                  }
                },
                child: const Text('Reauthorize with prompt none'),
              ),
              const Divider(),
              if (kIsWeb) ...[
                Text(
                  'Logout Web Navigation Mode',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                DropdownButtonHideUnderline(
                  child: DropdownButton<
                      OidcPlatformSpecificOptions_Web_NavigationMode>(
                    items: OidcPlatformSpecificOptions_Web_NavigationMode.values
                        .map(
                          (e) => DropdownMenuItem(
                            value: e,
                            child: Text(e.name),
                          ),
                        )
                        .toList(),
                    value: widget.webNavigationMode,
                    onChanged: (value) {
                      if (value == null) {
                        return;
                      }
                      setState(() {
                        widget.webNavigationMode = value;
                      });
                    },
                  ),
                ),
              ],
              ElevatedButton(
                onPressed: () async {
                 ref.read(currentUserProvider.notifier).logout();
                },
                child: const Text('Logout'),
              ),
              const Divider(),
              Wrap(
                spacing: 8,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      try {
                        final res =
                            await app_state.currentManager.refreshToken();

                        if (res == null && context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'It is not possible to refresh the token.',
                              ),
                            ),
                          );
                          return;
                        } else {
                          ref.read(currentUserProvider.notifier).setOidc(res!);
                        }
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Manually refreshed token!'),
                            ),
                          );
                        }
                      } catch (e) {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'An error occurred trying to '
                                'refresh the token',
                              ),
                            ),
                          );
                        }
                      }
                    },
                    child: const Text('Refresh token'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await app_state.currentManager.forgetUser();
                    },
                    child: const Text('Forget User'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      var location =
                          await bg.BackgroundGeolocation.getCurrentPosition(
                              samples: 1);
                      setState(() {
                        _location = location;
                      });
                      logNoStack.i("************ [location] $location");
                      // bg.BackgroundGeolocation.sync();
                      //bg.BackgroundGeolocation.sync();
                      bg.BackgroundGeolocation.playSound(
                          util.Dialog.getSoundId("BUTTON_CLICK"));
                    },
                    child: const Text('GPS'),
                  ),
                ],
              ),
              // const Divider(),
              // Text('user id: ${user.uid}'),
              const Divider(),
              Text('Move Status: ${_isMoving! ? 'Moving' : 'Still'}'),
              const Divider(),
              // Text('Location: ' +
              //     ((_location == null)
              //         ? 'loading ..'
              //         : '${_location.coords.latitude} ${_location.coords.longitude}')),
              // //  Text('${t.odometer}: $_odometer'),
              // const Divider(),
              // Text('userInfo endpoint response: ${user.userInfo}'),
              // const Divider(),
              Text(
                  'DeviceId: ${prov.Provider.of<Notifi>(context, listen: false).deviceId}'),
              const Divider(),
              // Text('userInfo endpoint response: ${user.userInfo}'),
              // const Divider(),
              Text('id token claims: ${user.claims.toJson()}'),
              const Divider(),
              // Text(
              //     'id token: ${user.idToken.substring(user.idToken.length - 10)}'),
              // const Divider(),
              // Text('fcm: ${Provider.of<Notifi>(context, listen: false).fcm}'),
              // const Divider(),
              Text(
                  'access token: ${user.token.accessToken!.substring(user.token.accessToken!.length - 10)}'),
              const Divider(),
              Text(
                  'ref token: ${user.token.refreshToken!.substring(user.token.refreshToken!.length - 10)}'),
              const Divider(),
              Text('tokenType: ${user.token.tokenType}'),
              const Divider(),

              Text('token: ${jsonEncode(user.token.toJson())}'),
            ],
          ),
        ),
      ),
    );
  }
}

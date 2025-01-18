import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_geolocation/flutter_background_geolocation.dart'
    as bg;
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart' as logger;
import 'package:notifi/api_utils.dart';
import 'package:notifi/app_state.dart' as app_state;
import 'package:notifi/credentials.dart';
import 'package:notifi/geo_utils.dart';
import 'package:notifi/jwt_utils.dart';
import 'package:notifi/models/crowtech_basepage.dart';
import 'package:notifi/models/gps.dart';
import 'package:notifi/models/person.dart';
import 'package:notifi/notifi.dart';
import 'package:oidc/oidc.dart';
import 'package:provider/provider.dart';

import '../geo/geomap2.dart';
import '../i18n/strings.g.dart';

var log = logger.Logger(
  printer: logger.PrettyPrinter(),
  level: logger.Level.info,
);

var logNoStack = logger.Logger(
  printer: logger.PrettyPrinter(methodCount: 0),
  level: logger.Level.info,
);

class CrowtechHomePage extends StatefulWidget {
  const CrowtechHomePage({super.key});

  @override
  State<CrowtechHomePage> createState() => _CrowtechHomePageState();
}

class _CrowtechHomePageState extends State<CrowtechHomePage>
    with TickerProviderStateMixin<CrowtechHomePage>, WidgetsBindingObserver {
  OidcPlatformSpecificOptions_Web_NavigationMode webNavigationMode =
      OidcPlatformSpecificOptions_Web_NavigationMode.newPage;

  Timer? timer;

  bool _loggedin = false;
  OidcUser? _oidcuser;
  Person? _currentUser;
  bool _userReady = false;

  bool? _isMoving = false;
  double _odometer = 0.0;
  bool _enabled = true;
  bool _geoStarted = false;

  late bg.Location _location;
  bool _locationReady = false;
  // bg.Location _location = bg.Location({
  //   'coords': bg.Coords(
  //       {'latitude': -36.25075728434346, "longitude": 142.39512886114866})
  // });
  // String? token;
  String apiUrl = defaultAPIBaseUrl;
  CrowtechBasePage<GPS>? points;
  String pointsStr = "";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // GoRouter.of(context).go('/secret-route');
    });
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final user = app_state.cachedAuthedUser.of(context);
    if ((user != null) && (!_loggedin)) {
      logNoStack.i("home page didChangeDependencies: initNotifi");
      initNotifi(context, user.token.accessToken.toString(), defaultRealm);
      loginUser(context, user.token.accessToken!);
      setState(() {
        _loggedin = true;
      });
      void notifiListener() {
        if (!context.mounted) return;
        setState(() {
          _currentUser =
              Provider.of<Notifi>(context, listen: false).currentUser;
          _userReady = Provider.of<Notifi>(context, listen: false).userReady;
        });
        logNoStack.d("CrowtechHomePage:NotifiListener triggered , updated user");
      }

      Provider.of<Notifi>(context, listen: false).addListener(notifiListener);
    }
  }

  void initGeolocation(BuildContext context) async {
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
              debug: false,
              heartbeatInterval: 60,
              preventSuspend: true,
              batchSync: true,
              maxBatchSize: 1,
              disableElasticity: false,
              // headers: {
              //   "Authorization":
              //       "Bearer ${app_state.cachedAuthedUser.of(context)!.token.accessToken}"
              // },
              headers: {'Authorization': 'Bearer {accessToken}'},
              authorization: bg.Authorization(
                  // <-- demo server authenticates with JWT
                  strategy: bg.Authorization.STRATEGY_JWT,
                  accessToken:
                      app_state.cachedAuthedUser.of(context)!.token.accessToken,
                  refreshToken: app_state.cachedAuthedUser
                      .of(context)!
                      .token
                      .refreshToken,
                  refreshUrl:
                      "$defaultAuthBaseUrl/realms/$defaultRealm/protocol/openid-connect/token",
                  refreshPayload: {
                    'refresh_token': '{refreshToken}',
                    'client_id': defaultClientId,
                    'grant_type': 'refresh_token'
                  }),
              extras: {
                "orgid": 2,
                "resourcecode":
                    getResourceCode(app_state.cachedAuthedUser.of(context)!),
                "resourceid": 0,
                "deviceid": Provider.of<Notifi>(context).deviceId,
              },
              method: "POST",
              url: "$defaultAPIBaseUrl/p/gps/location",
              logLevel: bg.Config.LOG_LEVEL_VERBOSE))
          .then((bg.State state) async {
        logNoStack.i(
            '[ready] ${state.toMap()}  [didDeviceReboot] ${state.didDeviceReboot}');

        if (state.schedule!.isNotEmpty) {
          logNoStack.i("Start bg schedule");
          bg.BackgroundGeolocation.startSchedule();
        }
        var location = await bg.BackgroundGeolocation.getCurrentPosition();
        if (!state.enabled) {
          ////
          // 3.  Start the plugin.
          //
          logNoStack.i("Starting bg");
          bg.BackgroundGeolocation.start();

          setState(() {
            _enabled = state.enabled;
            _isMoving = state.isMoving;
            _odometer = state.odometer;
            _location = location;
            _locationReady = true;
          });
        } else {
          setState(() {
            _isMoving = state.isMoving;
            _odometer = state.odometer;
            _location = location;
            _locationReady = true;
          });
        }
      });
      logNoStack.i("******** GeoLocation Started");
    } else {
      // get location for web
      logNoStack.i(
          "Fetching initial position for web mode with locationReady ${_locationReady ? 'YES' : 'NO'}");
      // await _getCurrentPosition(context);
      // final hasPermission = await _handleLocationPermission(context);
      //logNoStack.i("Has permission is ${hasPermission ? 'YES' : 'NO'}");
      //if (!hasPermission) return;
      // Position pos = await Geolocator.getCurrentPosition(
      //     desiredAccuracy: LocationAccuracy.high);
      // logNoStack.i("Pos is $pos");
      // bg.Location loc =
      //     createBgLocation(lat: pos.latitude, long: pos.longitude);
      // logNoStack.i("the location is $loc");
      // setState(() {
      //   _location = loc;
      //   _locationReady = true;
      // });
      fetchWebLocation();
      // set up schedule for web to sample GPS
      /// Initialize a periodic timer with 1 second duration
      timer = Timer.periodic(
        const Duration(seconds: 20),
        (timer) {
          /// callback will be executed every 30 second, fetch GPS
          /// on each callback
          fetchWebLocation();
        },
      );
    }
  }

  Future<void> fetchWebLocation() async {
    if (!context.mounted) return;
    Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((pos) async {
      logNoStack.d("Pos is $pos");
      bg.Location loc =
          createBgLocation(lat: pos.latitude, long: pos.longitude);
      logNoStack.d("the location is $loc");
      setState(() {
        _location = loc;
        _locationReady = true;
      });
      String deviceid = await fetchDeviceId();
      String token = app_state.cachedAuthedUser.of(context)!.token.accessToken!;
      sendGPS(2, deviceid, token, loc);
    });
  }

  // Future<void> _getCurrentPosition(BuildContext context) async {
  //   final hasPermission = true; //await _handleLocationPermission(context);
  //   logNoStack.i("Has permission is ${hasPermission ? 'YES' : 'NO'}");
  //   if (!hasPermission) return;
  //   logNoStack.i("Has permission to get location");
  //   await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
  //       .then((Position position) {
  //     collection.HashMap<String, dynamic> coords = collection.HashMap();
  //     coords.addAll({'latitude': position.latitude});
  //     coords.addAll({'longitude': position.longitude});

  //     setState(() {
  //       _location = bg.Location(coords);
  //       _locationReady = true;
  //     });
  //   }).catchError((e) {
  //     debugPrint(e);
  //   });
  // }

  Future<bool> _handleLocationPermission(BuildContext context) async {
    bool serviceEnabled;
    LocationPermission permission;
    if (!context.mounted) return false;
    logNoStack.i("Looking to handle Location Permission");
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    logNoStack.i(
        "Looking to handle Location Permission 2 ${serviceEnabled ? 'service enabled' : 'Service NOT enabled'}");
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    logNoStack.i("Looking to handle Location Permission - checking permission");
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  void _onHeartbeat(bg.HeartbeatEvent event) {
    if (!context.mounted) {
      return;
    }
    logNoStack.d("[heartbeat] ${event.toString()}");
    // bg.BackgroundGeolocation.setConfig(bg.Config(
    //   headers: {
    //     "Authorization":
    //         "Bearer ${app_state.cachedAuthedUser.of(context)!.token.accessToken}"
    //   },
    //   url: "$defaultAPIBaseUrl/p/gps/location",
    // ));
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
      // Map<String, dynamic> decodedToken = JwtDecoder.decode(
      //     app_state.cachedAuthedUser.of(context)!.token.accessToken!);
      // int expiry = decodedToken['exp'];
      // logNoStack.e(
      //     "- Authorization error: ${event.error} , ${event.response.toString()} , accessTokenExpiry=$expiry");
    }
  }

  void _onLocation(bg.Location location) async {
    if (!context.mounted) {
      return;
    }
    logNoStack.d('[${bg.Event.LOCATION}] - $location');
    setState(() {
      _location = location;
    });
  }

  void _onLocationError(bg.LocationError error) {
    if (!context.mounted) {
      return;
    }
    logNoStack.d('[${bg.Event.LOCATION}] ERROR - $error');
  }

  void _onMotionChange(bg.Location location) {
    if (!context.mounted) {
      return;
    }
    logNoStack.d('[${bg.Event.MOTIONCHANGE}] - $location');
    setState(() {
      _isMoving = location.isMoving;
    });
  }

  @override
  Widget build(BuildContext context) {
    logNoStack.i("Start Build Home Page");
    OidcUser? oidcuser = app_state.cachedAuthedUser.of(context);

    if ((oidcuser == null)) {
      // put a guard here as well, just in case
      // the redirect doesn't fire up in time.
      return const SizedBox.shrink();
    } else {
      if (!_geoStarted) {
        setState(() {
          _geoStarted = true;
        });
        initGeolocation(context);
      }
    }
    final platform = Theme.of(context).platform;
    final mobilePlatforms = [
      TargetPlatform.android,
      TargetPlatform.iOS,
      TargetPlatform.fuchsia,
    ];

    // ignore: unnecessary_null_comparison
    if ((!_locationReady)) {
      return const SizedBox.shrink();
    }
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
                  "${t.app_title}  ${Provider.of<Notifi>(context, listen: false).packageInfo!.version}",
                  style: Theme.of(context).textTheme.displaySmall,
                ),
              ),
              _userReady
                  ? Center(
                      child: Text(
                        "${_currentUser!.name} ${_currentUser!.email}",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    )
                  : const Divider(),

              _userReady
                  ? CircleAvatar(
                      radius: 34,
                      backgroundColor: Colors.red,
                      child: CircleAvatar(
                        radius: 32,
                        backgroundImage:
                            NetworkImage(_currentUser!.getAvatarUrl()),
                      ),
                    )
                  : const Divider(),

              Visibility(
                visible: _locationReady,
                child: SizedBox(
                    width: 300.0,
                    height: 400.0,
                    child: Card(
                      // child: GeoMapHome(location: _location),
                      child: GeoMap2(points:points),
                    )),
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
                    value: webNavigationMode,
                    onChanged: (value) {
                      if (value == null) {
                        return;
                      }
                      setState(() {
                        webNavigationMode = value;
                      });
                    },
                  ),
                ),
              ],
              ElevatedButton(
                onPressed: () async {
                  setState(() {
                    _loggedin = false;
                  });
                  bg.BackgroundGeolocation.stop();
                  Provider.of<Notifi>(context, listen: false).preventAutoLogin =
                      true;
                  await registerLogout(
                      Localizations.localeOf(context),
                      app_state.cachedAuthedUser
                          .of(context)!
                          .token
                          .accessToken!);
                  await app_state.currentManager.logout(
                    //after logout, go back to home
                    originalUri: Uri.parse('/'),
                    options: OidcPlatformSpecificOptions(
                      web: OidcPlatformSpecificOptions_Web(
                        navigationMode: webNavigationMode,
                      ),
                    ),
                  );
                },
                child: Text(t.logout),
              ),
              ElevatedButton(
                onPressed: () async {
                  fetchGPS(
                          Localizations.localeOf(context),
                          app_state.cachedAuthedUser
                              .of(context)!
                              .token
                              .accessToken!,
                          2,
                          0,
                          2)
                      .then((page) {
                    logNoStack.i("page is ${page.toString()}");

                    if (page.items != null) {
                      setState(() {
                        points = page as CrowtechBasePage<GPS>?;
                        String usercode = points!.items!.first.resourcecode;

                        pointsStr =
                            "${points!.items!.first.created} ${NumberFormat("###.0#####", "en_AU").format(points!.items!.first.latitude)} ${NumberFormat("###.0#####", "en_AU").format(points!.items!.first.longitude)} $usercode";
                      });
                    }
                  }).catchError((error) {
                    logNoStack.e("page error is $error");
                  });
                },
                child: const Text("fetch"),
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
                  // ElevatedButton(
                  //   onPressed: () async {
                  //     await app_state.currentManager.forgetUser();
                  //   },
                  //   child: const Text('Forget User'),
                  // ),
                  ElevatedButton(
                    onPressed: () async {
                      late bg.Location location;
                      if (!kIsWeb) {
                        await bg.BackgroundGeolocation.getCurrentPosition(
                            samples: 1);
                      } else {
                        Position pos = await Geolocator.getCurrentPosition(
                            desiredAccuracy: LocationAccuracy.high);
                        logNoStack.i("Pos is $pos");
                        location = createBgLocation(
                            lat: pos.latitude, long: pos.longitude);
                      }
                      setState(() {
                        _location = location;
                      });
                      logNoStack.i("************ [location] $location");
                      // bg.BackgroundGeolocation.sync();
                      //bg.BackgroundGeolocation.sync();
                      // bg.BackgroundGeolocation.playSound(
                      //     util.Dialog.getSoundId("BUTTON_CLICK"));
                    },
                    child: const Text('GPS'),
                  ),
                ],
              ),
              // const Divider(),
              // Text('user id: ${user.uid}'),
              const Divider(),
              Text(
                  'Location: ${_locationReady ? '${NumberFormat("###.0#####", "en_AU").format(_location.coords.latitude)},${NumberFormat("###.0#####", "en_AU").format(_location.coords.longitude)}' : ''}'),
              const Divider(),
              Text('${t.movement_status}: ${_isMoving! ? t.moving : t.still}'),
              const Divider(),
              // Text('Location: ' +
              //     ((_location == null)
              //         ? 'loading ..'
              //         : '${_location.coords.latitude} ${_location.coords.longitude}')),
              // //  Text('${t.odometer}: $_odometer'),
              const Divider(),
              Text('Last Point: $pointsStr'),
              // const Divider(),
              Text(
                  'DeviceId: ${Provider.of<Notifi>(context, listen: false).deviceId}'),
              const Divider(),
              // Text('userInfo endpoint response: ${user.userInfo}'),
              // const Divider(),
              Text('id token claims: ${oidcuser.claims.toJson()}'),
              const Divider(),
              // Text(
              //     'id token: ${user.idToken.substring(user.idToken.length - 10)}'),
              // const Divider(),
              // Text('fcm: ${Provider.of<Notifi>(context, listen: false).fcm}'),
              // const Divider(),
              Text(
                  'access token: ${oidcuser.token.accessToken!.substring(oidcuser.token.accessToken!.length - 10)}'),
              // const Divider(),
              // Text(
              //     'ref token: ${user.token.refreshToken!.substring(user.token.refreshToken!.length - 10)}'),
              const Divider(),
              Text('tokenType: ${oidcuser.token.tokenType}'),
              // const Divider(),

              // Text('token: ${jsonEncode(user.token.toJson())}'),
            ],
          ),
        ),
      ),
    );
  }
}

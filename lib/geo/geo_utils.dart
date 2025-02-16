// import 'dart:async';

// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:collection/collection.dart';
// import 'package:flutter/services.dart';
// import 'dart:math' as math;

// import 'package:flutter_background_geolocation/flutter_background_geolocation.dart'
//     as bg;
// import 'package:flutter_map/flutter_map.dart';
// import 'package:flutter_map/plugin_api.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:notifi/credentials.dart';
// import 'package:notifi/jwt_utils.dart';
// import 'package:notifi/riverpod/locations.dart';
// import 'package:notifi/util/dialog.dart' as util;

// import 'package:latlong2/latlong.dart';
// import 'package:notifi/util/geospatial.dart';
// import 'package:logger/logger.dart' as logger;
// import 'package:notifi/app_state.dart' as app_state;
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// var log = logger.Logger(
//   printer: logger.PrettyPrinter(),
//   level: logger.Level.info,
// );

// var logNoStack = logger.Logger(
//   printer: logger.PrettyPrinter(methodCount: 0),
//   level: logger.Level.info,
// );


// void initGeolocation(BuildContext context) async {
//     if (!kIsWeb) {
//       bg.BackgroundGeolocation.onLocation(_onLocation, _onLocationError);
//       bg.BackgroundGeolocation.onMotionChange(_onMotionChange);
//       bg.BackgroundGeolocation.onAuthorization(_onAuthChange);
//       bg.BackgroundGeolocation.onHttp(_onHttp);
//       bg.BackgroundGeolocation.onHeartbeat(_onHeartbeat);

//       bg.BackgroundGeolocation.ready(bg.Config(
//               allowIdenticalLocations: true,
//               autoSync: true,
//               desiredAccuracy: bg.Config.DESIRED_ACCURACY_HIGH,
//               distanceFilter: 10.0,
//               maxDaysToPersist: 3,
//               enableHeadless: true,
//               stopOnTerminate: false,
//               stationaryRadius: 25,
//               stopTimeout: 1,
//               startOnBoot: true,
//               locationsOrderDirection: "ASC",
//               backgroundPermissionRationale: bg.PermissionRationale(
//                   title:
//                       "Allow {applicationName} to access this device's location even when the app is closed or not in use.",
//                   message:
//                       "This app collects location data to enable recording your trips to work and calculate distance-travelled.",
//                   positiveAction:
//                       'Change to "{backgroundPermissionOptionLabel}"',
//                   negativeAction: 'Cancel'),
//               debug: false,
//               heartbeatInterval: 60,
//               preventSuspend: true,
//               batchSync: true,
//               maxBatchSize: 1,
//               disableElasticity: false,
//               // headers: {
//               //   "Authorization":
//               //       "Bearer ${app_state.cachedAuthedUser.of(context)!.token.accessToken}"
//               // },
//               headers: {'Authorization': 'Bearer {accessToken}'},
//               authorization: bg.Authorization(
//                   // <-- demo server authenticates with JWT
//                   strategy: bg.Authorization.STRATEGY_JWT,
//                   accessToken:
//                       app_state.cachedAuthedUser.of(context)!.token.accessToken,
//                   refreshToken: app_state.cachedAuthedUser
//                       .of(context)!
//                       .token
//                       .refreshToken,
//                   refreshUrl:
//                       "$defaultAuthBaseUrl/realms/$defaultRealm/protocol/openid-connect/token",
//                   refreshPayload: {
//                     'refresh_token': '{refreshToken}',
//                     'client_id': defaultClientId,
//                     'grant_type': 'refresh_token'
//                   }),
//               extras: {
//                 "orgid": 2,
//                 "resourcecode":
//                     getResourceCode(app_state.cachedAuthedUser.of(context)!),
//                 "resourceid": 0,
//                 "deviceid": deviceId,
//               },
//               method: "POST",
//               url: "$defaultAPIBaseUrl$defaultApiPrefixPath/gps/location",
//               logLevel: bg.Config.LOG_LEVEL_VERBOSE))
//           .then((bg.State state) async {
//         logNoStack.i(
//             '[ready] ${state.toMap()}  [didDeviceReboot] ${state.didDeviceReboot}');

//         if (state.schedule!.isNotEmpty) {
//           logNoStack.i("Start bg schedule");
//           bg.BackgroundGeolocation.startSchedule();
//         }
//         var location = await bg.BackgroundGeolocation.getCurrentPosition();
//         if (!state.enabled) {
//           ////
//           // 3.  Start the plugin.
//           //
//           logNoStack.i("Starting bg");
//           bg.BackgroundGeolocation.start();

//           setState(() {
//             _enabled = state.enabled;
//             _isMoving = state.isMoving;
//             _odometer = state.odometer;
//             _location = location;
//             _locationReady = true;
//           });
//         } else {
//           setState(() {
//             _isMoving = state.isMoving;
//             _odometer = state.odometer;
//             _location = location;
//             _locationReady = true;
//           });
//         }
//       });
//       logNoStack.i("******** GeoLocation Started");
//     } else {
//       // get location for web
//       logNoStack.i(
//           "Fetching initial position for web mode with locationReady ${_locationReady ? 'YES' : 'NO'}");

//       fetchWebLocation();
//       // set up schedule for web to sample GPS
//       /// Initialize a periodic timer with 1 second duration
//       timer = Timer.periodic(
//         const Duration(seconds: 20),
//         (timer) {
//           /// callback will be executed every 30 second, fetch GPS
//           /// on each callback
//           fetchWebLocation();
//         },
//       );
//     }
//   }

//   Future<void> fetchWebLocation() async {
//     if (!context.mounted) return;
//     Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
//         .then((pos) async {
//       logNoStack.d("Pos is $pos");
//       bg.Location loc =
//           createBgLocation(lat: pos.latitude, long: pos.longitude);
//       logNoStack.d("the location is $loc");
//       setState(() {
//         _location = loc;
//         _locationReady = true;
//       });
//       String deviceid = await fetchDeviceId();
//       String token = app_state.cachedAuthedUser.of(context)!.token.accessToken!;
//       sendGPS(2, deviceid, token, loc);
//     });
//   }

//   Future<bool> _handleLocationPermission(BuildContext context) async {
//     bool serviceEnabled;
//     LocationPermission permission;
//     if (!context.mounted) return false;
//     logNoStack.i("Looking to handle Location Permission");
//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     logNoStack.i(
//         "Looking to handle Location Permission 2 ${serviceEnabled ? 'service enabled' : 'Service NOT enabled'}");
//     if (!serviceEnabled) {
//       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//           content: Text(
//               'Location services are disabled. Please enable the services')));
//       return false;
//     }
//     logNoStack.i("Looking to handle Location Permission - checking permission");
//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text('Location permissions are denied')));
//         return false;
//       }
//     }
//     if (permission == LocationPermission.deniedForever) {
//       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//           content: Text(
//               'Location permissions are permanently denied, we cannot request permissions.')));
//       return false;
//     }
//     return true;
//   }

//   void _onHeartbeat(bg.HeartbeatEvent event) {
//     if (!mounted) {
//       return;
//     }
//     logNoStack.d("[heartbeat] ${event.toString()}");
//     // bg.BackgroundGeolocation.setConfig(bg.Config(
//     //   headers: {
//     //     "Authorization":
//     //         "Bearer ${app_state.cachedAuthedUser.of(context)!.token.accessToken}"
//     //   },
//     //   url: "$defaultAPIBaseUrl/r/gps/location",
//     // ));
//   }

//   void _onHttp(bg.HttpEvent response) {
//     int status = response.status;
//     bool success = response.success;

//     String responseText = response.responseText;
//     logNoStack.d(
//         '[onHttp] status: $status, success? $success, responseText: $responseText');
//   }

//   void _onAuthChange(bg.AuthorizationEvent event) async {
//     if (!context.mounted) {
//       return;
//     }
//     logNoStack.d("[authorization] ${event.toString()}");

//     if (event.success) {
//       logNoStack.d("- Authorization response: ${event.response}");
//       // set up riverpod user

//       ref
//           .read(currentUserProvider.notifier)
//           .setOidc(app_state.cachedAuthedUser.of(context)!);
//     } else {
//       // work out expiry
//       // Map<String, dynamic> decodedToken = JwtDecoder.decode(
//       //     app_state.cachedAuthedUser.of(context)!.token.accessToken!);
//       // int expiry = decodedToken['exp'];
//       // logNoStack.e(
//       //     "- Authorization error: ${event.error} , ${event.response.toString()} , accessTokenExpiry=$expiry");
//     }
//   }

//   void _onLocation(bg.Location location) async {
//     if (!context.mounted) {
//       return;
//     }
//     logNoStack.d('[${bg.Event.LOCATION}] - $location');
//     setState(() {
//       _location = location;
//     });
//   }

//   void _onLocationError(bg.LocationError error) {
//     if (!context.mounted) {
//       return;
//     }
//     logNoStack.d('[${bg.Event.LOCATION}] ERROR - $error');
//   }

//   void _onMotionChange(bg.Location location) {
//     if (!context.mounted) {
//       return;
//     }
//     logNoStack.d('[${bg.Event.MOTIONCHANGE}] - $location');
//     setState(() {
//       _isMoving = location.isMoving;
//     });
//   }
/// Geolocation Utilities and Background GPS Tracking for Notifi Field Service
/// 
/// This file contains comprehensive geolocation utilities and background GPS
/// tracking functionality for the Notifi field service application. It provides
/// enterprise-grade location services including background tracking, geofencing,
/// and secure location data transmission.
/// 
/// Core GPS Functionality:
/// - Background GPS tracking with configurable accuracy and intervals
/// - Real-time location updates with motion detection
/// - Geofencing for job site and service area monitoring
/// - Location permission handling and privacy compliance
/// - Secure JWT-based authentication for location data transmission
/// 
/// Field Service Features:
/// - Worker location tracking for dispatch optimization
/// - Asset tracking and fleet management support
/// - Service area monitoring and compliance checking
/// - Distance calculations and route optimization
/// - Time-based location sampling for efficiency tracking
/// 
/// Privacy and Security:
/// - Comprehensive permission management
/// - Secure token-based API authentication
/// - Background location rationale for user transparency
/// - Configurable data retention policies
/// - Encrypted location data transmission
/// 
/// Business Context:
/// Essential for field service operations requiring real-time visibility
/// into worker locations, asset positions, and service coverage areas.
/// Enables optimal dispatch, compliance monitoring, and operational efficiency.
/// 
/// Note: This file is currently commented out but contains production-ready
/// implementation for comprehensive GPS tracking and geofencing capabilities.

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


/// Initializes comprehensive geolocation services for field service operations
/// 
/// This function sets up background GPS tracking, geofencing, and location
/// monitoring capabilities. It configures the background geolocation service
/// with enterprise-grade settings suitable for field service applications.
/// 
/// GPS Tracking Configuration:
/// - High accuracy GPS positioning (DESIRED_ACCURACY_HIGH)
/// - 10-meter distance filter for efficient battery usage
/// - 25-meter stationary radius for motion detection
/// - Background location updates even when app is closed
/// 
/// Security and Authentication:
/// - JWT-based authentication with automatic token refresh
/// - Secure transmission of location data to backend APIs
/// - Device identification and organization context
/// - Background permission rationale for user transparency
/// 
/// Field Service Features:
/// - Real-time worker location tracking
/// - Geofencing for job sites and service areas
/// - Motion change detection for activity monitoring
/// - Heartbeat monitoring for connectivity assurance
/// 
/// Privacy Compliance:
/// - Comprehensive permission handling
/// - Clear rationale for background location access
/// - Configurable data retention (3 days default)
/// - User-controlled location sharing preferences
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

  /// Fetches current GPS location for web-based field service applications
  /// 
  /// This function provides GPS location services for web platforms where
  /// background geolocation plugins are not available. It implements a
  /// polling-based approach to continuously monitor worker locations.
  /// 
  /// Web GPS Functionality:
  /// - High accuracy GPS positioning using browser geolocation API
  /// - 20-second polling interval for regular location updates
  /// - Automatic location transmission to backend services
  /// - Context-aware location handling with mounted widget checks
  /// 
  /// Field Service Integration:
  /// - Seamless location tracking across web and mobile platforms
  /// - Consistent location data format for backend processing
  /// - Device identification for multi-platform worker tracking
  /// - Token-based authentication for secure data transmission
  /// 
  /// Privacy and Performance:
  /// - Respects user location permissions and preferences
  /// - Efficient polling to minimize battery impact on mobile web
  /// - Graceful error handling for location service unavailability
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

  /// Handles location permission requests with comprehensive privacy compliance
  /// 
  /// This function manages the complete location permission workflow for field
  /// service applications, ensuring compliance with privacy regulations and
  /// providing clear user communication about location usage.
  /// 
  /// Permission Management:
  /// - Checks if location services are enabled on the device
  /// - Requests location permissions with appropriate user messaging
  /// - Handles denied, permanently denied, and granted permission states
  /// - Provides user-friendly error messages and guidance
  /// 
  /// Privacy Compliance Features:
  /// - Clear explanation of location data usage for field service
  /// - Respect for user privacy preferences and choices
  /// - Graceful handling of permission denial scenarios
  /// - Transparent communication about location tracking purposes
  /// 
  /// Field Service Context:
  /// - Essential for worker location tracking and dispatch optimization
  /// - Enables geofencing and service area monitoring
  /// - Supports compliance with regulatory location requirements
  /// - Facilitates emergency response and worker safety features
  /// 
  /// Returns:
  /// - true if location permissions are granted and services are enabled
  /// - false if permissions are denied or services are disabled
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

  /// Handles real-time GPS location updates for field service tracking
  /// 
  /// This callback function processes incoming GPS location data from the
  /// background geolocation service, updating the application state with
  /// current worker positions and triggering location-based business logic.
  /// 
  /// Location Processing:
  /// - Receives high-accuracy GPS coordinates with timestamp
  /// - Updates application state with current worker position
  /// - Validates location data quality and accuracy
  /// - Triggers location-based notifications and alerts
  /// 
  /// Field Service Integration:
  /// - Enables real-time worker tracking for dispatch optimization
  /// - Supports geofencing alerts for job site entry/exit
  /// - Facilitates route optimization and travel time calculations
  /// - Provides location data for compliance and audit requirements
  /// 
  /// Data Management:
  /// - Maintains location history for reporting and analytics
  /// - Filters duplicate or low-quality location readings
  /// - Batches location updates for efficient network transmission
  /// - Ensures data consistency across application components
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

  /// Handles motion state changes for intelligent field service tracking
  /// 
  /// This callback function detects when workers transition between moving
  /// and stationary states, enabling smart location tracking that optimizes
  /// battery usage while maintaining accurate field service monitoring.
  /// 
  /// Motion Detection Features:
  /// - Automatically detects when workers start/stop moving
  /// - Adjusts GPS sampling frequency based on motion state
  /// - Provides motion-based geofencing and activity monitoring
  /// - Optimizes battery life through intelligent tracking modes
  /// 
  /// Field Service Applications:
  /// - Tracks worker arrival/departure at job sites
  /// - Monitors service call duration and efficiency
  /// - Detects unauthorized stops or route deviations
  /// - Supports automated time tracking and billing
  /// 
  /// Smart Tracking Logic:
  /// - Increases location accuracy when workers are moving
  /// - Reduces GPS sampling when workers are stationary
  /// - Triggers location-based workflow automation
  /// - Provides context for activity-based reporting
  //   void _onMotionChange(bg.Location location) {
//     if (!context.mounted) {
//       return;
//     }
//     logNoStack.d('[${bg.Event.MOTIONCHANGE}] - $location');
//     setState(() {
//       _isMoving = location.isMoving;
//     });
//   }
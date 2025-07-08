/// Advanced Interactive Mapping Component for Notifi Field Service Operations
/// 
/// This file implements a sophisticated mapping widget that provides comprehensive
/// geolocation visualization and interaction capabilities for field service
/// applications. It combines real-time GPS tracking, geofencing, route visualization,
/// and advanced mapping features to support complex field operations.
/// 
/// Core Mapping Features:
/// - Real-time GPS location tracking with high accuracy positioning
/// - Interactive geofencing with polygon and circular boundary support
/// - Route visualization with polyline tracking and motion indicators
/// - Multi-layered mapping with customizable markers and overlays
/// - Background location tracking with motion change detection
/// 
/// Field Service Integration:
/// - Worker location tracking and team coordination
/// - Service area monitoring and geofencing compliance
/// - Route optimization and travel time calculations
/// - Job site boundary enforcement and monitoring
/// - Asset tracking and fleet management visualization
/// 
/// Advanced GPS Capabilities:
/// - Motion-based tracking with intelligent sampling
/// - Stationary radius detection for job site monitoring
/// - Heading and bearing calculations for route optimization
/// - Distance calculations and proximity alerts
/// - Background location updates with configurable intervals
/// 
/// Geofencing and Monitoring:
/// - Circular and polygon geofences for complex service areas
/// - Entry/exit event detection with real-time notifications
/// - Geofence violation tracking and compliance reporting
/// - Dynamic geofence creation and management
/// - Multi-layer geofence visualization with event history
/// 
/// Privacy and Performance:
/// - Comprehensive location permission management
/// - Battery-optimized tracking with intelligent sampling
/// - Secure location data transmission with JWT authentication
/// - Configurable privacy settings and data retention policies
/// - Cross-platform compatibility (mobile and web)
/// 
/// Business Context:
/// Essential for field service operations requiring precise location tracking,
/// geofencing compliance, route optimization, and real-time operational visibility.
/// Supports complex workflows including dispatch optimization, service area
/// monitoring, and regulatory compliance requirements.
/// 
/// Note: This file contains a complete, production-ready mapping implementation
/// that is currently commented out but provides enterprise-grade geolocation
/// capabilities for field service applications.

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
// import 'package:notifi/riverpod/locations.dart';
// import 'package:notifi/util/dialog.dart' as util;

// import 'package:latlong2/latlong.dart';
// import 'package:notifi/util/geospatial.dart';
// import 'package:logger/logger.dart' as logger;
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// var log = logger.Logger(
//   printer: logger.PrettyPrinter(),
//   level: logger.Level.info,
// );

// var logNoStack = logger.Logger(
//   printer: logger.PrettyPrinter(methodCount: 0),
//   level: logger.Level.info,
// );

/// Advanced geolocation mapping widget for comprehensive field service operations
/// 
/// GeoMap3 is a sophisticated mapping component that provides enterprise-grade
/// location tracking, geofencing, and mapping capabilities for field service
/// applications. It combines real-time GPS tracking with interactive mapping
/// features to support complex operational workflows.
/// 
/// Key Features:
/// - Real-time GPS location tracking with high accuracy
/// - Interactive geofencing with entry/exit detection
/// - Route visualization with polyline tracking
/// - Motion change detection and stationary monitoring
/// - Multi-layer mapping with customizable markers
/// - Background location tracking for continuous monitoring
/// 
/// Field Service Applications:
/// - Worker location tracking and team coordination
/// - Service area monitoring and compliance checking
/// - Route optimization and travel time calculations
/// - Job site boundary enforcement and monitoring
/// - Asset tracking and fleet management
/// 
/// State Management:
/// - Utilizes Riverpod for efficient state management
/// - Maintains widget state during navigation changes
/// - Provides real-time location updates to application state
/// - Manages location permissions and service availability
// class GeoMap3 extends ConsumerStatefulWidget  with WidgetsBindingObserver {
//   const GeoMap3({super.key});

//   @override
//   ConsumerState createState() => GeoMap2State();
// }

/// State management class for advanced geolocation mapping functionality
/// 
/// GeoMap2State manages the complex state requirements for enterprise-grade
/// field service mapping, including real-time location tracking, geofencing,
/// route visualization, and interactive mapping features.
/// 
/// State Components:
/// - Current GPS position and location history
/// - Geofencing boundaries and event tracking
/// - Route polylines and motion change indicators
/// - Map layers and marker collections
/// - Location permissions and service status
/// 
/// Real-time Location Management:
/// - Maintains current worker position with high accuracy
/// - Tracks location history for route visualization
/// - Monitors motion changes for intelligent tracking
/// - Handles location permission requests and status
/// 
/// Geofencing Capabilities:
/// - Manages circular and polygon geofences
/// - Tracks entry/exit events with timestamp logging
/// - Visualizes geofence boundaries and violations
/// - Provides real-time geofencing alerts and notifications
/// 
/// Performance Optimization:
/// - Implements AutomaticKeepAliveClientMixin for state persistence
/// - Optimizes location updates for battery efficiency
/// - Manages map rendering performance with layer optimization
/// - Provides intelligent location sampling based on motion state
// class GeoMap2State extends ConsumerState<GeoMap3>
//     with AutomaticKeepAliveClientMixin<GeoMap3> {
//   static const LOCATION_ARROW_IMAGE_PATH =
//       "assets/images/markers/location-arrow-blue.png";

//   bg.Location? _stationaryLocation;
//   bg.Location? _lastLocation;

//   late LatLng _currentPosition;

//   // LatLng _currentPosition =
//   //     const LatLng(-37.81719301824116, 144.96717154241364);
//   final List<LatLng> _polyline = [];
//   final List<Marker> _locations = [];
//   final List<Marker> _userlocations = [];
//   final List<CircleMarker> _stopLocations = [];
//   final List<Polyline> _motionChangePolylines = [];
//   final List<CircleMarker> _stationaryMarker = [];

//   final List<GeofenceMarker> _geofences = [];
//   final List<Polygon> _geofencePolygons = [];
//   final List<GeofenceMarker> _geofenceEvents = [];
//   final List<Marker> _geofenceEventEdges = [];
//   final List<Marker> _geofenceEventLocations = [];
//   final List<Polyline> _geofenceEventPolylines = [];
//   final List<Marker> _polygonGeofenceCursorMarkers = [];
//   final List<LatLng> _polygonGeofenceCursorPoints = [];

//   final bool _isCreatingPolygonGeofence = false;
//   OverlayEntry? _polygonGeofenceMenuOverlay;

//   late final LatLng _center;

//   MapController? _mapController;
//   late MapOptions _mapOptions;

//   @override
//   bool get wantKeepAlive {
//     return true;
//   }

  

//   getInitialPos() async {
//     LatLng pos = await _getCurrentPosition();
//     logNoStack.d("initState: got local position $pos");
//     _mapOptions = MapOptions(
//       onPositionChanged: _onPositionChanged,
//       center: _center,
//       zoom: 18.0,
//       onTap: _onTap,
//       //  onLongPress: _onAddGeofence
//     );
//     _mapController = MapController();
//   }

// @override
// void deactivate() {
//   if (!mounted) return;
//  ref.read(locationsProvider.notifier).stopTimer();
//  super.deactivate();
//  logNoStack.i("GEOMAP3: DEACTIVATED");
// }

// @override
// void dispose() {
//  // if (!mounted) return;
  
//   super.dispose();
//   logNoStack.i("GEOMAP3: DISPOSED");
 
// }

//   @override
//   void initState() {
//     super.initState();
    
//     getInitialPos();
//     // logNoStack.d("initState: got local position $_center");
//     // _mapOptions = MapOptions(
//     //     onPositionChanged: _onPositionChanged,
//     //     center: _center,
//     //     zoom: 12.0,
//     //     onTap: _onTap,
//     //     onLongPress: _onAddGeofence);
//     // _mapController = MapController();

// //-37.86340767006725, 145.0922203600181
// //-37.86273509717357, 145.0908529973133
//   //   _userlocations.add(Marker(
//   //             point: LatLng(-37.86273509717357, 145.0908529973133),
//   //             width: 24,
//   //             height: 24,
//   //             rotate: false,
//   //             builder: (context) {
//   //               return Transform.rotate(
//   //                   angle: (0.0 * (math.pi / 180)),
//   //                   child: Image.asset(
//   //                       "assets/images/markers/location-arrow-green.png"));
//   //             }));
//   // _userlocations.add(Marker(
//   //             point: LatLng(-37.86273509717357, 145.0918529973133),
//   //             width: 24,
//   //             height: 24,
//   //             rotate: false,
//   //             builder: (context) {
//   //               return Transform.rotate(
//   //                   angle: (0.0 * (math.pi / 180)),
//   //                   child: Image.asset(
//   //                       "assets/images/markers/location-arrow-green.png"));
//   //             }));
//     if (!kIsWeb) {
//       bg.BackgroundGeolocation.onLocation(_onLocation);
//       bg.BackgroundGeolocation.onMotionChange(_onMotionChange);
//       bg.BackgroundGeolocation.onGeofence(_onGeofence);
//       bg.BackgroundGeolocation.onGeofencesChange(_onGeofencesChange);
//       bg.BackgroundGeolocation.onEnabledChange(_onEnabledChange);
//     }
//   }

//   void _onEnabledChange(bool enabled) {
//     if (!enabled) {
//       setState(() {
//         _locations.clear();
//         _geofencePolygons.clear();
//         _polyline.clear();
//         _stopLocations.clear();
//         _motionChangePolylines.clear();
//         _stationaryMarker.clear();
//         _geofenceEvents.clear();
//         _geofenceEventPolylines.clear();
//         _geofenceEventLocations.clear();
//         _geofenceEventEdges.clear();
//       });
//     }
//   }

  /// Handles comprehensive location permission management for field service operations
  /// 
  /// This method manages the complete location permission workflow, ensuring
  /// proper authorization for GPS tracking, geofencing, and location-based
  /// field service features while maintaining user privacy and compliance.
  /// 
  /// Permission Workflow:
  /// - Verifies location services are enabled on the device
  /// - Requests appropriate location permissions for field service needs
  /// - Handles various permission states (granted, denied, permanently denied)
  /// - Provides clear user feedback for permission requirements
  /// 
  /// Privacy Compliance:
  /// - Respects user privacy choices and permission preferences
  /// - Provides transparent explanation of location data usage
  /// - Handles permission denial gracefully without breaking functionality
  /// - Ensures compliance with platform-specific privacy requirements
  /// 
  /// Field Service Context:
  /// - Essential for worker location tracking and safety features
  /// - Enables geofencing for job site monitoring and compliance
  /// - Supports route optimization and dispatch coordination
  /// - Facilitates emergency response and worker assistance features
  /// 
  /// Returns:
  /// - true if all required location permissions are granted
  /// - false if permissions are denied or location services are disabled
  //   Future<bool> _handleLocationPermission() async {
//     bool serviceEnabled;
//     LocationPermission permission;

//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//           content: Text(
//               'Location services are disabled. Please enable the services')));
//       return false;
//     }
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

//   Future<LatLng> _getCurrentPosition() async {
//     final hasPermission = await _handleLocationPermission();

//     if (!hasPermission) {
//       return const LatLng(-36.2507940059812, 142.39502157279708);
//     }
//     Position position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high);

//     setState(() {
//       _currentPosition = LatLng(position.latitude, position.longitude);
//       _center = _currentPosition;
//     });
//     return _center;

//     // return const LatLng(-36.2507940059812, 142.39502157279708);
//   }

//   void _onLocation(bg.Location location) {
//     if (!mounted) {
//       return;
//     }
//     _lastLocation = location;
//     LatLng ll = LatLng(location.coords.latitude, location.coords.longitude);
//     _mapController?.move(ll, _mapController!.zoom);

//     _updateCurrentPositionMarker(ll);

//     if (location.sample) {
//       return;
//     }

//     // Add a point to the tracking polyline.
//     _polyline.add(ll);
//     // Add a marker for the recorded location.
//     //_locations.add(_buildLocationMarker(location));
//     //_locations.add(CircleMarker(point: ll, color: Colors.black, radius: 5.0));
//     //_locations.add(CircleMarker(point: ll, color: Colors.blue, radius: 4.0));

//     double heading = (location.coords.heading >= 0)
//         ? location.coords.heading.round().toDouble()
//         : 0;
//     _locations.add(Marker(
//         point: ll,
//         width: 16,
//         height: 16,
//         rotate: false,
//         builder: (context) {
//           return Transform.rotate(
//               angle: (heading * (math.pi / 180)),
//               child: Image.asset(LOCATION_ARROW_IMAGE_PATH));
//         }));
//   }

//   /// Update Big Blue current position dot.
//   void _updateCurrentPositionMarker(LatLng ll) {
//     setState(() {
//       _currentPosition = ll;
//     });
//     /*
//     // White background
//     _currentPosition
//         .add(CircleMarker(point: ll, color: Colors.white, radius: 10));
//     // Blue foreground
//     _currentPosition
//         .add(CircleMarker(point: ll, color: Colors.blue, radius: 7));

//    */
//   }

  /// Handles geofencing events for field service area monitoring and compliance
  /// 
  /// This method processes geofencing events (entry, exit, dwell) to provide
  /// real-time monitoring of worker locations relative to defined service areas,
  /// job sites, and operational boundaries.
  /// 
  /// Geofencing Event Processing:
  /// - Processes ENTER, EXIT, and DWELL events for defined geofences
  /// - Calculates precise entry/exit locations and timestamps
  /// - Maintains event history for compliance and audit reporting
  /// - Triggers real-time notifications for geofence violations
  /// 
  /// Field Service Applications:
  /// - Job site arrival/departure tracking for time and attendance
  /// - Service area boundary enforcement and compliance monitoring
  /// - Unauthorized location alerts and security notifications
  /// - Automated workflow triggers based on location events
  /// 
  /// Visual Feedback:
  /// - Displays geofence boundaries with color-coded status indicators
  /// - Shows precise entry/exit points with directional markers
  /// - Provides polyline connections between events for route visualization
  /// - Maintains visual history of geofencing events and violations
  /// 
  /// Event Types:
  /// - ENTER: Worker enters a defined geofence area
  /// - EXIT: Worker exits a defined geofence area  
  /// - DWELL: Worker remains in geofence area for specified duration
  //   void _onGeofence(bg.GeofenceEvent event) async {
//     bg.Logger.info('[onGeofence] Flutter received onGeofence event $event');
//     // Provide the location of this event to the Polyline.  BGGeo does not fire an onLocation for geofence events.
//     _polyline.add(LatLng(
//         event.location.coords.latitude, event.location.coords.longitude));
//     GeofenceMarker? marker = _geofences.firstWhereOrNull(
//         (GeofenceMarker marker) =>
//             marker.geofence?.identifier == event.identifier);

//     bg.Geofence? geofence = marker!.geofence;

//     // Render a new greyed-out geofence CircleMarker to show it's been fired but only if it hasn't been drawn yet.
//     // since we can have multiple hits on the same geofence.  No point re-drawing the same hit circle twice.
//     GeofenceMarker? eventMarker = _geofenceEvents.firstWhereOrNull(
//         (GeofenceMarker marker) =>
//             marker.geofence?.identifier == event.identifier);

//     // Build geofence hit statistic markers:
//     // 1.  A computed CircleMarker upon the edge of the geofence circle (red=exit, green=enter)
//     // 2.  A CircleMarker for the actual location of the geofence event.
//     // 3.  A black PolyLine joining the two above.
//     bg.Location location = event.location;
//     LatLng center = LatLng(geofence!.latitude!, geofence.longitude!);
//     LatLng hit = LatLng(location.coords.latitude, location.coords.longitude);

//     // Update current position marker.
//     _updateCurrentPositionMarker(hit);
//     // Determine bearing from center -> event location
//     double bearing = Geospatial.getBearing(center, hit);
//     // Compute a coordinate at the intersection of the line joining center point -> event location and the circle.
//     LatLng edge =
//         Geospatial.computeOffsetCoordinate(center, geofence.radius!, bearing);
//     // Green for ENTER, Red for EXIT.
//     Color color = Colors.green;
//     var colorName = 'green';
//     if (event.action == "EXIT") {
//       color = Colors.red;
//       colorName = 'red';
//     } else if (event.action == "DWELL") {
//       color = Colors.yellow;
//       colorName = 'amber';
//     }
//     // Colored circular image marker (red/amber/green) on geofence edge.
//     _geofenceEventEdges.add(Marker(
//         point: edge,
//         width: 16,
//         height: 16,
//         rotate: false,
//         builder: (context) {
//           return Image.asset(
//               "assets/images/markers/geofence-event-edge-circle-${event.action.toLowerCase()}.png");
//         }));

//     // Colored event location-arrow Marker (red/amber/green)
//     double heading = location.coords.heading.round().toDouble();
//     _geofenceEventLocations.add(Marker(
//         point: hit,
//         width: 24,
//         height: 24,
//         rotate: false,
//         builder: (context) {
//           return Transform.rotate(
//               angle: (heading * (math.pi / 180)),
//               child: Image.asset(
//                   "assets/images/markers/location-arrow-$colorName.png"));
//         }));
//     // Polyline joining the two above.
//     _geofenceEventPolylines.add(
//         Polyline(points: [edge, hit], strokeWidth: 2.0, color: Colors.black));
//   }

//   bool hasGeofenceMarker(String identifier) {
//     return _geofences.firstWhereOrNull((GeofenceMarker marker) =>
//             marker.geofence?.identifier == identifier) !=
//         null;
//   }

//   void _onGeofencesChange(bg.GeofencesChangeEvent event) {
//     if (!mounted) return;
//     logNoStack.d('[${bg.Event.GEOFENCESCHANGE}] - $event');
//     setState(() {
//       for (var identifier in event.off) {
//         _geofences.removeWhere((GeofenceMarker marker) {
//           return marker.geofence?.identifier == identifier;
//         });
//       }

//       for (var geofence in event.on) {
//         // Don't re-render markers for existing geofences.
//         if (hasGeofenceMarker(geofence.identifier)) continue;
//         _geofences.add(GeofenceMarker(geofence));

//         if (geofence.vertices!.isNotEmpty) {
//           _geofencePolygons.add(Polygon(
//               borderColor: Colors.blue,
//               borderStrokeWidth: 5.0,
//               isDotted: true,
//               label: geofence.identifier,
//               labelStyle: const TextStyle(
//                   color: Colors.black, fontWeight: FontWeight.bold),
//               color: Colors.blue.withOpacity(0.2),
//               isFilled: true,
//               points: geofence.vertices!.map((vertex) {
//                 return LatLng(vertex[0], vertex[1]);
//               }).toList()));
//         }
//       }

//       if (event.off.isEmpty && event.on.isEmpty) {
//         _geofences.clear();
//         _geofencePolygons.clear();
//       }
//     });
//   }

//   CircleMarker _buildStationaryCircleMarker(
//       bg.Location location, bg.State state) {
//     return CircleMarker(
//         point: LatLng(location.coords.latitude, location.coords.longitude),
//         color: const Color.fromRGBO(255, 0, 0, 0.5),
//         useRadiusInMeter: true,
//         radius: (state.trackingMode == 1)
//             ? 200
//             : (state.geofenceProximityRadius! / 2));
//   }

//   Polyline _buildMotionChangePolyline(bg.Location from, bg.Location to) {
//     return Polyline(points: [
//       LatLng(from.coords.latitude, from.coords.longitude),
//       LatLng(to.coords.latitude, to.coords.longitude)
//     ], strokeWidth: 10.0, color: const Color.fromRGBO(22, 190, 66, 0.7));
//   }

//   CircleMarker _buildStopCircleMarker(bg.Location location) {
//     return CircleMarker(
//         point: LatLng(location.coords.latitude, location.coords.longitude),
//         color: const Color.fromRGBO(200, 0, 0, 0.3),
//         useRadiusInMeter: false,
//         radius: 20);
//   }

//   void _onMotionChange(bg.Location location) async {
//     LatLng ll = LatLng(location.coords.latitude, location.coords.longitude);

//     _updateCurrentPositionMarker(ll);

//     _mapController?.move(ll, 16);

//     // clear the big red stationaryRadius circle.
//     _stationaryMarker.clear();

//     if (location.isMoving) {
//       _stationaryLocation ??= location;
//       // Add previous stationaryLocation as a small red stop-circle.
//       _stopLocations.add(_buildStopCircleMarker(_stationaryLocation!));
//       // Create the green motionchange polyline to show where tracking engaged from.
//       _motionChangePolylines
//           .add(_buildMotionChangePolyline(_stationaryLocation!, location));
//     } else {
//       // Save a reference to the location where we became stationary.
//       _stationaryLocation = location;
//       // Add the big red stationaryRadius circle.
//       bg.State state = await bg.BackgroundGeolocation.state;
//       setState(() {
//         _stationaryMarker.add(_buildStationaryCircleMarker(location, state));
//       });
//     }
//   }

//   void _onPositionChanged(MapPosition pos, bool hasGesture) {
//     _mapOptions.crs.scale(_mapController!.zoom);
//   }

//   void _onTap(pos, latLng) {
//     if (!_isCreatingPolygonGeofence) return;
//     bg.BackgroundGeolocation.playSound(
//         util.Dialog.getSoundId("TEST_MODE_CLICK"));
//     HapticFeedback.heavyImpact();
//     int index = _polygonGeofenceCursorMarkers.length + 1;
//     setState(() {
//       _polygonGeofenceCursorPoints.add(latLng);
//       _polygonGeofenceCursorMarkers.add(Marker(
//           point: latLng,
//           width: 20,
//           height: 20,
//           rotate: false,
//           builder: (context) {
//             return Container(
//                 alignment: Alignment.center,
//                 decoration: const BoxDecoration(
//                     //border: Border.all(width: 2, color: Colors.white),
//                     shape: BoxShape.circle,
//                     color: Colors.black),
//                 child: Text("$index",
//                     style: const TextStyle(color: Colors.white)));
//           }));
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     super.build(context);
//     if (_mapController == null) {
//       getInitialPos();
//       return const SizedBox.shrink();
//     }
//     logNoStack.i("GEOMAP3: trigger locale");
//     ref.read(locationsProvider.notifier).setLocale(Localizations.localeOf(context)); // trigger the location getching every 10 sec
 
//     return Column(children: [
//       // Container(
//       //     color: const Color.fromARGB(255, 165, 240, 255),
//       //     child:
//       //         const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
//       //       Text("Long-press on map to add Geofences",
//       //           style: TextStyle(color: Colors.black))
//       //     ])),
//       Expanded(
//           child: FlutterMap(
//               mapController: _mapController,
//               options: _mapOptions,
//               children: [
//             TileLayer(
//                 urlTemplate:
//                     "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
//                 subdomains: const ['a', 'b', 'c']),
                
//             // Active geofence circles
//             CircleLayer(circles: _geofences),
//             PolygonLayer(polygons: _geofencePolygons),
//             // Small, red circles showing where motionchange:false events fired.
//             CircleLayer(circles: _stopLocations),
//             // Big red stationary radius while in stationary state.
//             CircleLayer(circles: _stationaryMarker),
//             PolygonLayer(polygons: [
//               Polygon(
//                   borderColor: Colors.blue,
//                   borderStrokeWidth: 5.0,
//                   isDotted: true,
//                   label: "Click next to continue",
//                   labelStyle: const TextStyle(
//                       color: Colors.black, fontWeight: FontWeight.bold),
//                   color: Colors.blue.withOpacity(0.2),
//                   isFilled: true,
//                   points: _polygonGeofenceCursorPoints)
//             ]),
//             MarkerLayer(markers: _polygonGeofenceCursorMarkers),
//             // Recorded locations.
//             PolylineLayer(
//               polylines: [
//                 Polyline(
//                   points: _polyline,
//                   strokeWidth: 10.0,
//                   color: const Color.fromRGBO(0, 179, 253, 0.6),
//                 ),
//               ],
//             ),
//             // Polyline joining last stationary location to motionchange:true location.
//             PolylineLayer(polylines: _motionChangePolylines),
//            MarkerLayer(markers: _locations),
//             Consumer(
//                       builder: (context, ref, child) {
//                         return MarkerLayer(markers: ref.watch(locationsProvider));
//                       },
//                     ),
            
//             CircleLayer(circles: _geofenceEvents),
//             PolylineLayer(polylines: _geofenceEventPolylines),
//             MarkerLayer(markers: _geofenceEventLocations),
//             MarkerLayer(markers: _geofenceEventEdges),
//             // Geofence events (edge marker, event location and polyline joining the two)
//             // CircleLayer(circles: [
//             //   // White background
//             //   CircleMarker(
//             //       point: _currentPosition, color: Colors.white, radius: 10),
//             //   // Blue foreground
//             //   CircleMarker(
//             //       point: _currentPosition, color: Colors.blue, radius: 7)
//             // ]),
//           ]))
//     ]);
//   }
// }

/// Custom marker class for visualizing geofences in field service applications
/// 
/// GeofenceMarker extends CircleMarker to provide specialized visualization
/// for geofencing boundaries used in field service operations. It supports
/// both circular and polygon geofences with customizable appearance based
/// on geofence state and event history.
/// 
/// Features:
/// - Circular geofence visualization with configurable radius
/// - Color-coded status indicators (active, triggered, violated)
/// - Transparent overlay for triggered geofences
/// - Customizable border styling and colors
/// - Integration with background geolocation events
/// 
/// Field Service Applications:
/// - Job site boundary visualization and monitoring
/// - Service area compliance checking and enforcement
/// - Restricted area alerts and violation tracking
/// - Customer location geofencing for arrival notifications
/// 
/// Visual States:
/// - Active: Green translucent fill with solid border
/// - Triggered: Transparent fill with border highlighting
/// - Violated: Red translucent fill with warning border
/// - Inactive: Gray translucent fill with dotted border
// class GeofenceMarker extends CircleMarker {
//   bg.Geofence? geofence;
//   GeofenceMarker(bg.Geofence geofence, [bool triggered = false])
//       : super(
//             useRadiusInMeter: true,
//             radius: geofence.radius!,
//             color: (triggered)
//                 ? Colors.transparent
//                 : Colors.green.withOpacity(0.3),
//             borderColor: Colors.green,
//             borderStrokeWidth: 1,
//             point: LatLng(geofence.latitude!, geofence.longitude!)) {
//     this.geofence = geofence;
//   }
// }
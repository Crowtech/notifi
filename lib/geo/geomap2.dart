import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:flutter/services.dart';
import 'dart:math' as math;

import 'package:flutter_background_geolocation/flutter_background_geolocation.dart'
    as bg;
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:geolocator/geolocator.dart';
import 'package:notifi/riverpod/locations.dart';
import 'package:notifi/util/dialog.dart' as util;

import 'package:latlong2/latlong.dart';
import 'package:notifi/util/geospatial.dart';
import 'package:logger/logger.dart' as logger;
import 'package:provider/provider.dart' as prov;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notifi/riverpod/random.dart';
import 'package:notifi/riverpod/locations.dart';

var log = logger.Logger(
  printer: logger.PrettyPrinter(),
  level: logger.Level.info,
);

var logNoStack = logger.Logger(
  printer: logger.PrettyPrinter(methodCount: 0),
  level: logger.Level.info,
);

class GeoMap2 extends StatefulWidget {
  const GeoMap2({super.key});

  @override
  State createState() => GeoMap2State();
}

class GeoMap2State extends State<GeoMap2>
    with AutomaticKeepAliveClientMixin<GeoMap2> {
  static const LOCATION_ARROW_IMAGE_PATH =
      "assets/images/markers/location-arrow-blue.png";

  bg.Location? _stationaryLocation;
  bg.Location? _lastLocation;

  late LatLng _currentPosition;

  // LatLng _currentPosition =
  //     const LatLng(-37.81719301824116, 144.96717154241364);
  final List<LatLng> _polyline = [];
  final List<Marker> _locations = [];
  final List<Marker> _userlocations = [];
  final List<CircleMarker> _stopLocations = [];
  final List<Polyline> _motionChangePolylines = [];
  final List<CircleMarker> _stationaryMarker = [];

  final List<GeofenceMarker> _geofences = [];
  final List<Polygon> _geofencePolygons = [];
  final List<GeofenceMarker> _geofenceEvents = [];
  final List<Marker> _geofenceEventEdges = [];
  final List<Marker> _geofenceEventLocations = [];
  final List<Polyline> _geofenceEventPolylines = [];
  final List<Marker> _polygonGeofenceCursorMarkers = [];
  final List<LatLng> _polygonGeofenceCursorPoints = [];

  final bool _isCreatingPolygonGeofence = false;
  OverlayEntry? _polygonGeofenceMenuOverlay;

  late final LatLng _center;

  MapController? _mapController;
  late MapOptions _mapOptions;

  @override
  bool get wantKeepAlive {
    return true;
  }

  getInitialPos() async {
    LatLng pos = await _getCurrentPosition();
    logNoStack.d("initState: got local position $pos");
    _mapOptions = MapOptions(
      onPositionChanged: _onPositionChanged,
      center: _center,
      zoom: 18.0,
      onTap: _onTap,
      //  onLongPress: _onAddGeofence
    );
    _mapController = MapController();
  }

  @override
  void initState() {
    super.initState();
    getInitialPos();
    // logNoStack.d("initState: got local position $_center");
    // _mapOptions = MapOptions(
    //     onPositionChanged: _onPositionChanged,
    //     center: _center,
    //     zoom: 12.0,
    //     onTap: _onTap,
    //     onLongPress: _onAddGeofence);
    // _mapController = MapController();

//-37.86340767006725, 145.0922203600181
//-37.86273509717357, 145.0908529973133
  //   _userlocations.add(Marker(
  //             point: LatLng(-37.86273509717357, 145.0908529973133),
  //             width: 24,
  //             height: 24,
  //             rotate: false,
  //             builder: (context) {
  //               return Transform.rotate(
  //                   angle: (0.0 * (math.pi / 180)),
  //                   child: Image.asset(
  //                       "assets/images/markers/location-arrow-green.png"));
  //             }));
  // _userlocations.add(Marker(
  //             point: LatLng(-37.86273509717357, 145.0918529973133),
  //             width: 24,
  //             height: 24,
  //             rotate: false,
  //             builder: (context) {
  //               return Transform.rotate(
  //                   angle: (0.0 * (math.pi / 180)),
  //                   child: Image.asset(
  //                       "assets/images/markers/location-arrow-green.png"));
  //             }));
    if (!kIsWeb) {
      bg.BackgroundGeolocation.onLocation(_onLocation);
      bg.BackgroundGeolocation.onMotionChange(_onMotionChange);
      bg.BackgroundGeolocation.onGeofence(_onGeofence);
      bg.BackgroundGeolocation.onGeofencesChange(_onGeofencesChange);
      bg.BackgroundGeolocation.onEnabledChange(_onEnabledChange);
    }
  }

  void _onEnabledChange(bool enabled) {
    if (!enabled) {
      setState(() {
        _locations.clear();
        _geofencePolygons.clear();
        _polyline.clear();
        _stopLocations.clear();
        _motionChangePolylines.clear();
        _stationaryMarker.clear();
        _geofenceEvents.clear();
        _geofenceEventPolylines.clear();
        _geofenceEventLocations.clear();
        _geofenceEventEdges.clear();
      });
    }
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
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

  Future<LatLng> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) {
      return const LatLng(-36.2507940059812, 142.39502157279708);
    }
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    setState(() {
      _currentPosition = LatLng(position.latitude, position.longitude);
      _center = _currentPosition;
    });
    return _center;

    // return const LatLng(-36.2507940059812, 142.39502157279708);
  }

  void _onLocation(bg.Location location) {
    if (!mounted) {
      return;
    }
    _lastLocation = location;
    LatLng ll = LatLng(location.coords.latitude, location.coords.longitude);
    _mapController?.move(ll, _mapController!.zoom);

    _updateCurrentPositionMarker(ll);

    if (location.sample) {
      return;
    }

    // Add a point to the tracking polyline.
    _polyline.add(ll);
    // Add a marker for the recorded location.
    //_locations.add(_buildLocationMarker(location));
    //_locations.add(CircleMarker(point: ll, color: Colors.black, radius: 5.0));
    //_locations.add(CircleMarker(point: ll, color: Colors.blue, radius: 4.0));

    double heading = (location.coords.heading >= 0)
        ? location.coords.heading.round().toDouble()
        : 0;
    _locations.add(Marker(
        point: ll,
        width: 16,
        height: 16,
        rotate: false,
        builder: (context) {
          return Transform.rotate(
              angle: (heading * (math.pi / 180)),
              child: Image.asset(LOCATION_ARROW_IMAGE_PATH));
        }));
  }

  /// Update Big Blue current position dot.
  void _updateCurrentPositionMarker(LatLng ll) {
    setState(() {
      _currentPosition = ll;
    });
    /*
    // White background
    _currentPosition
        .add(CircleMarker(point: ll, color: Colors.white, radius: 10));
    // Blue foreground
    _currentPosition
        .add(CircleMarker(point: ll, color: Colors.blue, radius: 7));

   */
  }

  void _onGeofence(bg.GeofenceEvent event) async {
    bg.Logger.info('[onGeofence] Flutter received onGeofence event $event');
    // Provide the location of this event to the Polyline.  BGGeo does not fire an onLocation for geofence events.
    _polyline.add(LatLng(
        event.location.coords.latitude, event.location.coords.longitude));
    GeofenceMarker? marker = _geofences.firstWhereOrNull(
        (GeofenceMarker marker) =>
            marker.geofence?.identifier == event.identifier);

    bg.Geofence? geofence = marker!.geofence;

    // Render a new greyed-out geofence CircleMarker to show it's been fired but only if it hasn't been drawn yet.
    // since we can have multiple hits on the same geofence.  No point re-drawing the same hit circle twice.
    GeofenceMarker? eventMarker = _geofenceEvents.firstWhereOrNull(
        (GeofenceMarker marker) =>
            marker.geofence?.identifier == event.identifier);

    // Build geofence hit statistic markers:
    // 1.  A computed CircleMarker upon the edge of the geofence circle (red=exit, green=enter)
    // 2.  A CircleMarker for the actual location of the geofence event.
    // 3.  A black PolyLine joining the two above.
    bg.Location location = event.location;
    LatLng center = LatLng(geofence!.latitude!, geofence.longitude!);
    LatLng hit = LatLng(location.coords.latitude, location.coords.longitude);

    // Update current position marker.
    _updateCurrentPositionMarker(hit);
    // Determine bearing from center -> event location
    double bearing = Geospatial.getBearing(center, hit);
    // Compute a coordinate at the intersection of the line joining center point -> event location and the circle.
    LatLng edge =
        Geospatial.computeOffsetCoordinate(center, geofence.radius!, bearing);
    // Green for ENTER, Red for EXIT.
    Color color = Colors.green;
    var colorName = 'green';
    if (event.action == "EXIT") {
      color = Colors.red;
      colorName = 'red';
    } else if (event.action == "DWELL") {
      color = Colors.yellow;
      colorName = 'amber';
    }
    // Colored circular image marker (red/amber/green) on geofence edge.
    _geofenceEventEdges.add(Marker(
        point: edge,
        width: 16,
        height: 16,
        rotate: false,
        builder: (context) {
          return Image.asset(
              "assets/images/markers/geofence-event-edge-circle-${event.action.toLowerCase()}.png");
        }));

    // Colored event location-arrow Marker (red/amber/green)
    double heading = location.coords.heading.round().toDouble();
    _geofenceEventLocations.add(Marker(
        point: hit,
        width: 24,
        height: 24,
        rotate: false,
        builder: (context) {
          return Transform.rotate(
              angle: (heading * (math.pi / 180)),
              child: Image.asset(
                  "assets/images/markers/location-arrow-$colorName.png"));
        }));
    // Polyline joining the two above.
    _geofenceEventPolylines.add(
        Polyline(points: [edge, hit], strokeWidth: 2.0, color: Colors.black));
  }

  bool hasGeofenceMarker(String identifier) {
    return _geofences.firstWhereOrNull((GeofenceMarker marker) =>
            marker.geofence?.identifier == identifier) !=
        null;
  }

  void _onGeofencesChange(bg.GeofencesChangeEvent event) {
    if (!mounted) return;
    logNoStack.d('[${bg.Event.GEOFENCESCHANGE}] - $event');
    setState(() {
      for (var identifier in event.off) {
        _geofences.removeWhere((GeofenceMarker marker) {
          return marker.geofence?.identifier == identifier;
        });
      }

      for (var geofence in event.on) {
        // Don't re-render markers for existing geofences.
        if (hasGeofenceMarker(geofence.identifier)) continue;
        _geofences.add(GeofenceMarker(geofence));

        if (geofence.vertices!.isNotEmpty) {
          _geofencePolygons.add(Polygon(
              borderColor: Colors.blue,
              borderStrokeWidth: 5.0,
              isDotted: true,
              label: geofence.identifier,
              labelStyle: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold),
              color: Colors.blue.withOpacity(0.2),
              isFilled: true,
              points: geofence.vertices!.map((vertex) {
                return LatLng(vertex[0], vertex[1]);
              }).toList()));
        }
      }

      if (event.off.isEmpty && event.on.isEmpty) {
        _geofences.clear();
        _geofencePolygons.clear();
      }
    });
  }

  CircleMarker _buildStationaryCircleMarker(
      bg.Location location, bg.State state) {
    return CircleMarker(
        point: LatLng(location.coords.latitude, location.coords.longitude),
        color: const Color.fromRGBO(255, 0, 0, 0.5),
        useRadiusInMeter: true,
        radius: (state.trackingMode == 1)
            ? 200
            : (state.geofenceProximityRadius! / 2));
  }

  Polyline _buildMotionChangePolyline(bg.Location from, bg.Location to) {
    return Polyline(points: [
      LatLng(from.coords.latitude, from.coords.longitude),
      LatLng(to.coords.latitude, to.coords.longitude)
    ], strokeWidth: 10.0, color: const Color.fromRGBO(22, 190, 66, 0.7));
  }

  CircleMarker _buildStopCircleMarker(bg.Location location) {
    return CircleMarker(
        point: LatLng(location.coords.latitude, location.coords.longitude),
        color: const Color.fromRGBO(200, 0, 0, 0.3),
        useRadiusInMeter: false,
        radius: 20);
  }

  void _onMotionChange(bg.Location location) async {
    LatLng ll = LatLng(location.coords.latitude, location.coords.longitude);

    _updateCurrentPositionMarker(ll);

    _mapController?.move(ll, 16);

    // clear the big red stationaryRadius circle.
    _stationaryMarker.clear();

    if (location.isMoving) {
      _stationaryLocation ??= location;
      // Add previous stationaryLocation as a small red stop-circle.
      _stopLocations.add(_buildStopCircleMarker(_stationaryLocation!));
      // Create the green motionchange polyline to show where tracking engaged from.
      _motionChangePolylines
          .add(_buildMotionChangePolyline(_stationaryLocation!, location));
    } else {
      // Save a reference to the location where we became stationary.
      _stationaryLocation = location;
      // Add the big red stationaryRadius circle.
      bg.State state = await bg.BackgroundGeolocation.state;
      setState(() {
        _stationaryMarker.add(_buildStationaryCircleMarker(location, state));
      });
    }
  }

  void _onPositionChanged(MapPosition pos, bool hasGesture) {
    _mapOptions.crs.scale(_mapController!.zoom);
  }

  void _onTap(pos, latLng) {
    if (!_isCreatingPolygonGeofence) return;
    bg.BackgroundGeolocation.playSound(
        util.Dialog.getSoundId("TEST_MODE_CLICK"));
    HapticFeedback.heavyImpact();
    int index = _polygonGeofenceCursorMarkers.length + 1;
    setState(() {
      _polygonGeofenceCursorPoints.add(latLng);
      _polygonGeofenceCursorMarkers.add(Marker(
          point: latLng,
          width: 20,
          height: 20,
          rotate: false,
          builder: (context) {
            return Container(
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                    //border: Border.all(width: 2, color: Colors.white),
                    shape: BoxShape.circle,
                    color: Colors.black),
                child: Text("$index",
                    style: const TextStyle(color: Colors.white)));
          }));
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (_mapController == null) {
      return const SizedBox.shrink();
    }

    return Column(children: [
      // Container(
      //     color: const Color.fromARGB(255, 165, 240, 255),
      //     child:
      //         const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      //       Text("Long-press on map to add Geofences",
      //           style: TextStyle(color: Colors.black))
      //     ])),
      Expanded(
          child: FlutterMap(
              mapController: _mapController,
              options: _mapOptions,
              children: [
            TileLayer(
                urlTemplate:
                    "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                subdomains: const ['a', 'b', 'c']),
                
            // Active geofence circles
            CircleLayer(circles: _geofences),
            PolygonLayer(polygons: _geofencePolygons),
            // Small, red circles showing where motionchange:false events fired.
            CircleLayer(circles: _stopLocations),
            // Big red stationary radius while in stationary state.
            CircleLayer(circles: _stationaryMarker),
            PolygonLayer(polygons: [
              Polygon(
                  borderColor: Colors.blue,
                  borderStrokeWidth: 5.0,
                  isDotted: true,
                  label: "Click next to continue",
                  labelStyle: const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                  color: Colors.blue.withOpacity(0.2),
                  isFilled: true,
                  points: _polygonGeofenceCursorPoints)
            ]),
            MarkerLayer(markers: _polygonGeofenceCursorMarkers),
            // Recorded locations.
            PolylineLayer(
              polylines: [
                Polyline(
                  points: _polyline,
                  strokeWidth: 10.0,
                  color: const Color.fromRGBO(0, 179, 253, 0.6),
                ),
              ],
            ),
            // Polyline joining last stationary location to motionchange:true location.
            PolylineLayer(polylines: _motionChangePolylines),
           // MarkerLayer(markers: _locations),
            MarkerLayer(markers: _userlocations),
            Consumer(
                      builder: (context, ref, child) {
                        return MarkerLayer(markers: ref.watch(locationsProvider));
                      },
                    ),
            
            CircleLayer(circles: _geofenceEvents),
            PolylineLayer(polylines: _geofenceEventPolylines),
            MarkerLayer(markers: _geofenceEventLocations),
            MarkerLayer(markers: _geofenceEventEdges),
            // Geofence events (edge marker, event location and polyline joining the two)
            // CircleLayer(circles: [
            //   // White background
            //   CircleMarker(
            //       point: _currentPosition, color: Colors.white, radius: 10),
            //   // Blue foreground
            //   CircleMarker(
            //       point: _currentPosition, color: Colors.blue, radius: 7)
            // ]),
          ]))
    ]);
  }
}

class GeofenceMarker extends CircleMarker {
  bg.Geofence? geofence;
  GeofenceMarker(bg.Geofence geofence, [bool triggered = false])
      : super(
            useRadiusInMeter: true,
            radius: geofence.radius!,
            color: (triggered)
                ? Colors.transparent
                : Colors.green.withOpacity(0.3),
            borderColor: Colors.green,
            borderStrokeWidth: 1,
            point: LatLng(geofence.latitude!, geofence.longitude!)) {
    this.geofence = geofence;
  }
}

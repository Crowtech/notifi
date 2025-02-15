import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:logger/logger.dart' as logger;
import 'package:notifi/credentials.dart';
import 'package:notifi/models/gps.dart';
import 'package:notifi/models/nestfilter.dart';
import '../api_utils.dart';
import '../models/crowtech_basepage.dart';
import 'dart:math' as math;

import '../state/auth_controller.dart';

var log = logger.Logger(
  printer: logger.PrettyPrinter(),
  level: logger.Level.info,
);

var logNoStack = logger.Logger(
  printer: logger.PrettyPrinter(methodCount: 0),
  level: logger.Level.info,
);
//void main() {
//  runApp(const ProviderScope(child: RandomNumberApp()));
//}

// Notifier for generating a random number exposed by a state notifier
// provider
class LocationsFetcher extends Notifier<List<Marker>> {
  static const LOCATION_ARROW_IMAGE_PATH =
      "assets/images/markers/location-arrow-green.png";

  late Timer _timer;
  late Locale _locale;
  int _periodSec = 10;

  NestFilter nestfilter = NestFilter(
      orgIdList: [],
      resourceCodeList: [],
      resourceIdList: [],
      deviceCodeList: [],
      query: '',
      offset: 0,
      limit: 30,
      sortby: 'id DESC',
      caseinsensitive: true,
      distinctField: 'resourcecode');

  void setPeriod(int period) {
    stopTimer();
    _periodSec = period;
    startTimer();
  }

  void startTimer() {
    fetchGPS(); // get an initial fetch
    _timer = Timer.periodic(
      Duration(seconds: _periodSec),
      (Timer timer) {
        fetchGPS();
      },
    );
  }

  void setLocale(Locale locale) {
    _locale = locale;
  }

  void stopTimer() {
    _timer.cancel();
  }

  @override
  List<Marker> build() {
    logNoStack.i("LOCATIONS: BUILD");
    startTimer();
    return [];
  }

  // void generate() {
  //   state = Random().nextInt(9999);
  // }

  //Future<CrowtechBasePage<GPS>> fetchGPS(
  void fetchGPS() async {
    String jsonDataStr = jsonEncode(nestfilter);
    logNoStack
        .i("Sending NestFilter gps $nestfilter with json as $jsonDataStr");
    final userToken = await ref.watch(
      authControllerProvider.selectAsync(
        (value) => value.map(
          signedIn: (signedIn) => signedIn.token,
          signedOut: (signedOut) => null,
        ),
      ),
    );
    var response = await apiPostDataStr(
        _locale, userToken!, "$defaultApiPrefixPath/gps/fetch", jsonDataStr);
    // .then((response) {
    logNoStack.d("result ${response.body.toString()}");
    final map = jsonDecode(response.body);

    List<String> colours = ['red', 'green', 'blue', 'amber'];
    final List<Marker> userlocations = [];
    if (map["totalItems"] == 0) {
      logNoStack.i("Empty List");
      CrowtechBasePage<GPS> page =
          CrowtechBasePage<GPS>(itemFromJson: GPS.fromJson).fromJson(map);

// create markers

      if (page.items != null) {
        for (var i = 0; i < page.items!.length; i++) {
          String colour = colours[i % colours.length];
          GPS gps = page.items![i];
          logNoStack.i('GPS $gps');
          LatLng ll = LatLng(gps.latitude, gps.longitude);
          double heading = gps.heading.round().toDouble();
          userlocations.add(Marker(
              point: ll,
              width: 24,
              height: 24,
              rotate: false,
              builder: (context) {
                return Transform.rotate(
                    angle: (heading * (math.pi / 180)),
                    child: Image.asset(
                        "assets/images/markers/location-arrow-$colour.png"));
              }));
        }
      }

      state = userlocations;
    } else {
      logNoStack.d("map = $map");

      CrowtechBasePage<GPS> page =
          CrowtechBasePage<GPS>(itemFromJson: GPS.fromJson).fromJson(map);

      if (page.items != null) {
        for (var i = 0; i < page.items!.length; i++) {
          String colour = colours[i % colours.length];
          GPS gps = page.items![i];
          logNoStack.i('GPS $gps');
          LatLng ll = LatLng(gps.latitude, gps.longitude);
          double heading = gps.heading.round().toDouble();
          userlocations.add(Marker(
              point: ll,
              width: 24,
              height: 24,
              rotate: false,
              builder: (context) {
                return Transform.rotate(
                    angle: (heading * (math.pi / 180)),
                    child: Image.asset(
                        "assets/images/markers/location-arrow-$colour.png"));
              }));
        }
      }
      state = userlocations;
    }
  }
}

// Notifier provider holding the state
final locationsProvider =
    NotifierProvider<LocationsFetcher, List<Marker>>(LocationsFetcher.new);

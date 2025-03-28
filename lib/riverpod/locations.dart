import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:logger/logger.dart' as logger;
import 'package:notifi/credentials.dart';
import 'package:notifi/models/gendertype.dart';
import 'package:notifi/models/gps.dart';
import 'package:notifi/models/nestfilter.dart';
import 'package:notifi/state/nest_auth2.dart';
import '../api_utils.dart';
import '../models/crowtech_basepage.dart';
import 'dart:math' as math;


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
      limit: 1000,
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
    final userToken = ref.read(nestAuthProvider.notifier).token;
    var response = await apiPostDataStr(_locale, userToken!,
        "$defaultAPIBaseUrl$defaultApiPrefixPath/gps/fetch", jsonDataStr);
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
          String colour;

          GPS gps = page.items![i];

          if (gps.person != null) {
            colour = gps.person!.gender == GenderType.MALE ? "blue" : "red";
            logNoStack.i('GPS $gps with person colour $colour');
          } else {
            colour = colours[i % colours.length];
            logNoStack.i('GPS $gps with NO person colour $colour');
          }
          LatLng ll = LatLng(gps.latitude, gps.longitude);
          double heading = gps.heading.round().toDouble();
          userlocations.add(Marker(
              point: ll,
              width: 24,
              height: 24,
              rotate: false,
              child: Transform.rotate(
                  angle: (heading * (math.pi / 180)),
                  child: Image.asset(
                      "assets/images/markers/location-arrow-$colour.png"))));
        }
      }

      state = userlocations;
    } else {
      logNoStack.d("map = $map");

      CrowtechBasePage<GPS> page =
          CrowtechBasePage<GPS>(itemFromJson: GPS.fromJson).fromJson(map);

      if (page.items != null) {
        for (var i = 0; i < page.items!.length; i++) {
          String colour;

          GPS gps = page.items![i];

          if (gps.person != null) {
            colour = gps.person!.gender == GenderType.MALE ? "blue" : "red";
            logNoStack.i('GPS $gps with person colour $colour');
          } else {
            colour = colours[i % colours.length];
            logNoStack.i('GPS $gps with NO person colour $colour');
          }

          LatLng ll = LatLng(gps.latitude, gps.longitude);
          double heading = gps.heading.round().toDouble();
          userlocations.add(Marker(
              point: ll,
              width: 24,
              height: 24,
              rotate: false,
              child: Transform.rotate(
                  angle: (heading * (math.pi / 180)),
                  child: Image.asset(
                      "assets/images/markers/location-arrow-$colour.png"))));
        }
      }
      state = userlocations;
    }
  }
}

// Notifier provider holding the state
final locationsProvider =
    NotifierProvider<LocationsFetcher, List<Marker>>(LocationsFetcher.new);

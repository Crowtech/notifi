import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:logger/logger.dart' as logger;
import 'package:notifi/credentials.dart';
import 'package:notifi/models/gps.dart';
import 'package:notifi/models/nestfilter.dart';
import '../api_utils.dart';
import '../models/crowtech_basepage.dart';
import '../models/nestfilter.dart';
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
  @override
  List<Marker> build() {
    return [];
  }

  // void generate() {
  //   state = Random().nextInt(9999);
  // }

  //Future<CrowtechBasePage<GPS>> fetchGPS(
  void fetchGPS(
      Locale locale, String token, int orgid, int offset, int limit) async {
    List<int> orgIdList = [];
    orgIdList.add(orgid);

    var nestfilter = NestFilter(
        orgIdList: orgIdList,
        resourceCodeList: [],
        resourceIdList: [],
        deviceCodeList: [],
        query: '',
        offset: offset,
        limit: limit,
        sortby: 'id DESC',
        caseinsensitive: true,
        distinctField: 'resourcecode');

    String jsonDataStr = jsonEncode(nestfilter);
    logNoStack
        .i("Sending NestFilter gps $nestfilter with json as $jsonDataStr");

    var response = await apiPostDataStr(
        locale, token, "$defaultApiPrefixPath/gps/fetch", jsonDataStr);
    // .then((response) {
    logNoStack.d("result ${response.body.toString()}");
    final map = jsonDecode(response.body);

    final List<Marker> _userlocations = [];
    if (map["totalItems"] == 0) {
      logNoStack.i("Empty List");
      CrowtechBasePage<GPS> page =
          CrowtechBasePage<GPS>(itemFromJson: GPS.fromJson).fromJson(map);

// create markers

      if (page.items != null) {
        for (var i = 0; i < page.items!.length; i++) {
          print('Number $i');
          GPS gps = page.items![i];
          LatLng ll = LatLng(gps.latitude, gps.longitude);
          _userlocations.add(Marker(
              point: ll,
              width: 24,
              height: 24,
              rotate: false,
              builder: (context) {
                return Transform.rotate(
                    angle: (gps.heading * (math.pi / 180)),
                    child: Image.asset(
                        "assets/images/markers/location-arrow-red.png"));
              }));
        }
      }

      state = _userlocations;
    } else {
      logNoStack.d("map = $map");

      CrowtechBasePage<GPS> page =
          CrowtechBasePage<GPS>(itemFromJson: GPS.fromJson).fromJson(map);

      if (page.items != null) {
        for (var i = 0; i < page.items!.length; i++) {
          print('Number $i');
          GPS gps = page.items![i];
          LatLng ll = LatLng(gps.latitude, gps.longitude);
          _userlocations.add(Marker(
              point: ll,
              width: 24,
              height: 24,
              rotate: false,
              builder: (context) {
                return Transform.rotate(
                    angle: (gps.heading * (math.pi / 180)),
                    child: Image.asset(
                        "assets/images/markers/location-arrow-red.png"));
              }));
        }
      }
      state = _userlocations;
    }
  }
}

// Notifier provider holding the state
final locationsProvider =
    NotifierProvider<LocationsFetcher, List<Marker>>(LocationsFetcher.new);

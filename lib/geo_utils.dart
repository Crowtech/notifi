import 'dart:convert';
import 'dart:io';

import 'package:app_set_id/app_set_id.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart' as logger;
import 'package:notifi/credentials.dart';
import 'package:notifi/geo_page.dart';
//import 'package:logger/printart';
import 'package:notifi/notifi.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:flutter_background_geolocation/flutter_background_geolocation.dart'
    as bg;
import 'dart:collection' as collection;

import 'package:uuid/uuid.dart';

var log = logger.Logger(
  printer: logger.PrettyPrinter(),
  level: logger.Level.info,
);

var logNoStack = logger.Logger(
  printer: logger.PrettyPrinter(methodCount: 0),
  level: logger.Level.info,
);

bg.Location createBgLocation({required double lat, required double long,double heading=0.0 , double speed=0.0, String ltype = 'still'}) {
  var uuid = Uuid();
  collection.HashMap<String, dynamic> coords = collection.HashMap();
  coords.addAll({'latitude': lat});
  coords.addAll({'longitude': long});
  coords.addAll({'heading': heading});
  coords.addAll({'speed': speed});
  coords.addAll({'accuracy': 100.0});
  coords.addAll({'altitude': 0.0});
  coords.addAll({'ellipsoidal_altitude': 100.0});
  collection.HashMap<String, dynamic> location = collection.HashMap();
  location.addAll({'coords': coords});

  collection.HashMap<String, dynamic> battery = collection.HashMap();
  battery.addAll({'is_charging': false});
  battery.addAll({'level': 1.0});
  location.addAll({'battery': battery});

  collection.HashMap<String, dynamic> activity = collection.HashMap();
  activity.addAll({'type': ltype});
  activity.addAll({'confidence': 100});
  location.addAll({'activity': activity});

DateTime now = DateTime.now();
String isoDate = now.toIso8601String();

  location['timestamp'] = isoDate;
  location['age'] = 0;

  location['is_moving'] = (speed>0.0);
  location['uuid'] = uuid.v6();
  location['odometer'] = 0.0;
  location['event'] = 'heartbeat';

  bg.Location loc = bg.Location(location);
  return loc;
}

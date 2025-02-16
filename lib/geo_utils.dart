import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:logger/logger.dart' as logger;
import 'package:notifi/credentials.dart';
import 'package:notifi/jwt_utils.dart';
import 'package:notifi/models/gps.dart';
//import 'package:logger/printart';
import 'package:flutter_background_geolocation/flutter_background_geolocation.dart'
    as bg;
import 'dart:collection' as collection;

import 'package:uuid/uuid.dart';

import 'models/person.dart';

var log = logger.Logger(
  printer: logger.PrettyPrinter(),
  level: logger.Level.info,
);

var logNoStack = logger.Logger(
  printer: logger.PrettyPrinter(methodCount: 0),
  level: logger.Level.info,
);

bg.Location createBgLocation({required double lat, required double long,double heading=0.0 , double speed=0.0, String ltype = 'still'}) {
  var uuid = const Uuid();
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


Future<String> sendGPS(Person currentUser,String token, bg.Location location) async {
    // Create a Map

  String deviceId = await fetchDeviceId();


 //   String jwtType = "UNKNOWN";

      logNoStack.i("sendGPS, currentUser is ${currentUser.email} id=${currentUser.id} resourcecode=${currentUser.code}");
      // if (token != null) {
      //   Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
      //   resourcecode = decodedToken['sub'];
      //   logNoStack.d("resource sub code is $resourcecode");
      //   jwtType = decodedToken['typ'];
      //   // convert to backend format
      //   final RegExp pattern = RegExp(r'[^a-zA-Z0-9]');
      //   resourcecode = resourcecode.replaceAll(pattern, "_");
      //   resourcecode = "PER_${resourcecode.toUpperCase()}";


      //   logNoStack.d(
      //       "sendGPS Constructor resourcecode is $resourcecode from JWT:$jwtType");
      // } else {
      //   logNoStack.e("SendGPS TOKEN is null");
      // }


//logNoStack.d("RESOURCECODE in sendGPS IS $resourcecode");
    // if (JwtDecoder.isExpired(token!)) {
    //   logNoStack.d("JWT has EXPIRED!");
    //   widget.jwt = "sadfsadf";//Provider.of<OgAuthProvider>(context, listen: false)
    //       // .userRefreshToken
    //       // .toString();
    //   jwtType = JwtDecoder.decode(widget.jwt!)['typ'];
    // }

    // logNoStack.d(
    //     "Send GPS using $jwtType as ${widget.jwt!.substring(widget.jwt!.length - 10)}");

    // var authProvider = await Provider.of<OgAuthProvider>(context, listen: false);
    //     authProvider.checkTokenStatus(context
    //       , widget.jwt!);

    var gps = GPS(
      jwt: token,
      longitude: location.coords.longitude,
      latitude: location.coords.latitude,
      speed: location.coords.speed,
      heading: location.coords.heading,
      battery: location.battery.level,
      charging: location.battery.isCharging,
      timestampStr: location.timestamp,
      moving: location.isMoving,
      resourcecode: currentUser.code!,
      devicecode: deviceId,
      orgid: currentUser.orgid,
    );

  logNoStack.i("Sending GPS gps $gps");

    String gpsJson;
    gpsJson = jsonEncode(gps);
    //gpsJson = json.encode(locMap);

    //logNoStack.d('JsonObject: $json');
    var url = Uri.parse(
        "$defaultAPIBaseUrl$defaultApiPrefixPath/gps?resourcecode=${currentUser.code}");
    logNoStack.i("SEND GPS to $url $gpsJson using jwt $token");
    try {
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer $token",
          // "Accept-Language": "$myLocale",
        },
        body: gpsJson,
        encoding: Encoding.getByName('utf-8'),
      );

      if (response.statusCode == 201) {
        logNoStack.d('Response: ${response.body}');
      } else {
        logNoStack.d('Error: ${response.statusCode}');
      }
    } catch (error) {
      logNoStack.d('Exception: $error');
    }

    return gpsJson;
  }
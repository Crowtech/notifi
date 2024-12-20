import 'dart:convert';

import 'package:app_set_id/app_set_id.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart' as logger;
import 'package:notifi/credentials.dart';
//import 'package:logger/printart';
import 'package:notifi/notifi.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';

var log = logger.Logger(
  printer: logger.PrettyPrinter(),
  level: logger.Level.info,
);
//import '../routes.dart'; // Importing application routes

// import '../credentials.dart' as credentials;
// import '../firebase_options.dart'; // Importing credentials

Future<Map> apiPost(BuildContext context, String token, String apiPath) async {
  return apiPostData(context, token, apiPath, null, null);
}

Future<Map> apiPostData(BuildContext context, String token, String apiPath,
    String? dataName, Object? data) async {
  Locale myLocale = Localizations.localeOf(context);
  // log.d("token used is $token");
  // log.d("locale used is $myLocale");
  //var url = Uri.parse("${Credentials.defaultAPIBaseUrl}/p/persons/register");
  var url = Uri.parse("$defaultAPIBaseUrl${apiPath}");
  var jsonData = null;
  final response;
  if (dataName != null) {
    jsonData = jsonEncode({
      "${dataName}": data,
    });

    response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer $token",
          "Accept-Language": "$myLocale",
        },
        body: jsonData);
  } else {
    // No data
    response = await http.post(url, headers: {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": "Bearer $token",
      "Accept-Language": "$myLocale",
    });
  }

  log.d(response.statusCode);
  if (response.statusCode == 202 || response.statusCode == 200 || response.statusCode == 200){
    log.d("Register login Post created successfully!");
    final resultMap = jsonDecode(response.body);
    return resultMap;
  } else {
    log.d("apiPost created unsuccessfully!");
    throw "api Post created unsuccessfully!";
  }
}

Future<Map> registerLogin(
    BuildContext context, String token, String deviceId) async {
  apiPostData(context, token, "/p/persons/register", "deviceid", deviceId)
      .then((result) {
    log.d("result ${result}");
    return result;
  }).catchError((error) {
    log.d("Register login error");
  });
  throw "Register Login error";
}

Future<void> registerLogout(
    BuildContext context, String token) async {
  apiPost(context, token, "/p/persons/logout")
      .then((result) {
    log.d("logout result ${result}");
  }).catchError((error) {
    log.e("Register logout error");
  });

}

// void initNotifi(BuildContext context, String token) async {

//   void notifiListener() {
//     log.d(
//         "Main:NotifiListener triggered , fcm is ${Provider.of<Notifi>(context, listen: false).fcm}");
//     registerFCM(context,token, Provider.of<Notifi>(context, listen: false).deviceId!, Provider.of<Notifi>(context, listen: false).fcm);
//   }

//   Provider.of<Notifi>(context, listen: false).addListener(notifiListener);
//     await Provider.of<Notifi>(context, listen: false).init();
// }

Future<Map> registerFCM(
    BuildContext context, String token, String deviceid, String fcm) async {
  apiPost(context, token, "/p/persons/devicefcm/${deviceid}/${fcm}")
      .then((result) {
    log.d("result ${result}");
    return result;
  }).catchError((error) {
    log.d("Register login error");
  });
  throw "Register Login error";
}

Future<bool> saveFCM(String token, String deviceid, String fcm) async {
  // OgAuthProvider authProvider =
  //     Provider.of<OgAuthProvider>(context, listen: false);
  log.d("Save FCM");
  var url = Uri.parse(
      "$defaultAPIBaseUrl/p/persons/devicefcm/${deviceid}/${fcm}");
  final response = await http.post(
    url,
    headers: {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": "Bearer $token"
    },
  );
  log.d(response.statusCode);
  if (response.statusCode == 202) {
    log.d("FCMPost created successfully!");
    return true;
    //final map = jsonDecode(response.body);
    // MyPage<Attribute> pageAttribute =
    //     new MyPage<Attribute>(itemFromJson: Attribute.fromJson).fromJson(map);
    // log.d(pageAttribute);
  } else {
    log.d("FCM Post created unsuccessfully! ${response.statusCode}");
   return false;
  }
}



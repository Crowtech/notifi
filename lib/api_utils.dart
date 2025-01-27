import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart' as logger;
import 'package:notifi/credentials.dart';
import 'package:notifi/models/gps.dart';
import 'package:notifi/models/nestfilter.dart';
import 'package:minio/minio.dart';

import 'models/crowtech_basepage.dart';

var log = logger.Logger(
  printer: logger.PrettyPrinter(),
  level: logger.Level.info,
);

var logNoStack = logger.Logger(
  printer: logger.PrettyPrinter(methodCount: 0),
  level: logger.Level.info,
);

final String defaultLocale = Platform.localeName;

Future<dynamic> apiPost(Locale locale, String token, String apiPath) async {
  return apiPostData(locale, token, apiPath, null, null);
}

Future<dynamic> apiPostData(Locale locale, String token, String apiPath,
    String? dataName, Object? data) async {
      logNoStack.i("APIPath -> $apiPath");
  var url = Uri.parse(apiPath);
  String jsonData;
  final http.Response response;
  if (dataName != null) {
    jsonData = jsonEncode({
      dataName: data,
    });

    response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer $token",
          "Accept-Language": "$locale",
        },
        body: jsonData);
  } else {
    // No data
    response = await http.post(url, headers: {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": "Bearer $token",
      "Accept-Language": "$locale",
    });
  }

  logNoStack.d(response.statusCode);
  if (response.statusCode == 202 ||
      response.statusCode == 201 ||
      response.statusCode == 200) {
    logNoStack
        .i("$apiPath created successfully! with status ${response.statusCode}");
    final resultMap = jsonDecode(response.body);
    return resultMap;
  } else {
    logNoStack.e(
        "$apiPath created unsuccessfully! with status ${response.statusCode}");
    return Future.error(
        "$apiPath created unsuccessfully! with status ${response.statusCode}");
  }
}

Future<http.Response> apiPostDataStr(
    Locale locale, String token, String apiPath, String? jsonDataStr) async {
  var url = Uri.parse("$defaultAPIBaseUrl$apiPath");

  final http.Response response;
  if (jsonDataStr != null) {
    response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer $token",
          "Accept-Language": "$locale",
        },
        body: jsonDataStr);
  } else {
    // No data
    response = await http.post(url, headers: {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": "Bearer $token",
      "Accept-Language": "$locale",
    });
  }

  log.d(response.statusCode);
  if (response.statusCode == 202 ||
      response.statusCode == 201 ||
      response.statusCode == 200) {
    return response;
  } else {
    log.d("apiPost created unsuccessfully!");
    throw "api Post created unsuccessfully!";
  }
}

// Future<Person> registerLogin(
//   String token,
// ) async {
//   String deviceId = await fetchDeviceId();
//   log.i("registerLogin: deviceid=$deviceId");
//   apiPostData(defaultLocale, token, "$defaultApiPrefixPath/persons/register",
//           "deviceid", deviceId)
//       .then((result) {

//     log.d("Registered user $user");
//     return user;
//   }).catchError((error) {
//     log.d("Register login error");
//   });
//   throw "Register Login error";
// }

Future<void> registerLogout(Locale locale, String token) async {
  apiPost(locale, token, "$defaultAPIBaseUrl$defaultApiPrefixPath/persons/logout").then((result) {
    log.d("logout result $result");
  }).catchError((error) {
    log.e("Register logout error");
  });
}

Future<Map> registerFCM(
    Locale locale, String token, String deviceid, String fcm) async {
  logNoStack.i(
      "About to send FCM and deviceid to api $defaultAPIBaseUrl$defaultApiPrefixPath/persons/devicefcm/$deviceid/$fcm");
  apiPost(locale, token,
          "$defaultAPIBaseUrl$defaultApiPrefixPath/persons/devicefcm/$deviceid/$fcm")
      .then((response) {
    logNoStack.i("back from send FCM sending $deviceid");
    logNoStack.i("result ${response.toString()}");
    return response;
  }).catchError((error) {
    log.d("Register FCM error");
    // ignore: invalid_return_type_for_catch_error
    return Map;
  });
  return <dynamic, dynamic>{};
}

Future<void> uploadMinio(String file)
async {
  
}

//Future<CrowtechBasePage<GPS>> fetchGPS(
Future<CrowtechBasePage<GPS>> fetchGPS(
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
  logNoStack.i("Sending NestFilter gps $nestfilter with json as $jsonDataStr");

  var response = await apiPostDataStr(locale, token, "$defaultApiPrefixPath/gps/fetch", jsonDataStr);
     // .then((response) {
    logNoStack.d("result ${response.body.toString()}");
    final map = jsonDecode(response.body);

    if (map["totalItems"] == 0) {
      logNoStack.i("Empty List");
      CrowtechBasePage<GPS> page =
          CrowtechBasePage<GPS>(itemFromJson: GPS.fromJson).fromJson(map);
     // page.processingTime = map['processingTime'];
     // page.startIndex = map['startIndex'];
     // page.totalItems = map['totalItems'];
      return page;
    } else {
      logNoStack.d("map = $map");

      CrowtechBasePage<GPS> page =
          CrowtechBasePage<GPS>(itemFromJson: GPS.fromJson).fromJson(map);
      //page.processingTime = map['processingTime'];
      //page.startIndex = map['startIndex'];
     // page.totalItems = map['totalItems'];

      //String pageJson = page.toString();
      //logNoStack.i("page is ${page.toString()}");
      // logNoStack.i("Number of items returned = ${page.items!.length}");
      // logNoStack.i("Processing Time = ${page.processingTime}");
      // logNoStack.i("Total Number of items available = ${page.totalItems}");
      // for (int i = 0; i < page.items!.length; i++) {
      //   logNoStack.i("item $i = ${page.items!.elementAt(i)}");
      // }

      //logNoStack.i(page);
      return page;
    }
  // }).catchError((error) {
  //   log.e("Fetch GPS Page error");
  //  // return CrowtechBasePage<GPS>();
  //   throw "api Post created unsuccessfully!";
  // });
  //return  CrowtechBasePage<GPS>();
//   ).catchError((error) {
//     log.d("Fetch GPS error");
//        // ignore: invalid_return_type_for_catch_error
//       // return Future.error(error);
//       CrowtechBasePage<GPS> errorOne = CrowtechBasePage<GPS>();
//       errorOne.items = [];
//       errorOne.processingTime = 0;
//       errorOne.startIndex = -1;
//       errorOne.totalItems = 0;
//        return errorOne;
//   });
//     // CrowtechBasePage<GPS> retOne = CrowtechBasePage<GPS>();
//     //   retOne.items = [];
//     //   retOne.processingTime = -1;
//     //   retOne.startIndex = -1;
//     //   retOne.totalItems = -1;
//     //   return retOne;
//  throw Future.error("Nothing");
}

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:logger/logger.dart' as logger;
import 'package:notifi/credentials.dart';
import 'package:notifi/i18n/strings.g.dart';
import 'package:notifi/jwt_utils.dart';
import 'package:notifi/models/appversion.dart';
import 'package:notifi/models/gps.dart';
import 'package:notifi/models/nestfilter.dart';
import 'package:notifi/models/person.dart';

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

Future<dynamic> apiPostNoLocale(String token, String apiPath) async {
  return apiPostDataNoLocale(token, apiPath, null, null);
}

Future<dynamic> apiPostDataNoLocale(
    String token, String apiPath, String? dataName, Object? data) async {
  logNoStack.d("API POST : APIPath -> $apiPath");
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
        },
        body: jsonData);
  } else {
    // No data
    response = await http.post(url, headers: {
      "Content-Type": "application/json",
      //"Accept": "application/json",
      "Authorization": "Bearer $token",
    });
  }

  logNoStack.i(response.statusCode);
  if (response.statusCode == 202 ||
      response.statusCode == 201 ||
      response.statusCode == 200) {
    logNoStack.d(
        "API POST No LOCALE: $apiPath created successfully! with status ${response.statusCode}");
        logNoStack.d("API POST No Locale: respose is ${response.body}");
        if (response.body.isEmpty) {
          return [];
        }
    final resultMap = jsonDecode(response.body);
    return resultMap;
  } else {
    logNoStack.e(
        "$apiPath created unsuccessfully! with url $url status ${response.statusCode} and error: ${response.reasonPhrase}");
    return Future.error(
        "$apiPath created unsuccessfully! with url $url status ${response.statusCode} and error: ${response.reasonPhrase}");
  }
}

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
    logNoStack.i(
        "API POST DATA: $apiPath created successfully! with status ${response.statusCode}");
    final resultMap = jsonDecode(response.body);
    return resultMap;
  } else {
    logNoStack.e(
        "API POST DATA: $apiPath created unsuccessfully! with status ${response.statusCode}");
    return Future.error(
        "API POST DATA: $apiPath created unsuccessfully! with status ${response.statusCode}");
  }
}

Future<http.Response> apiPostDataStrNoLocale(
    String token, String apiPath, String? jsonDataStr) async {
  var url = Uri.parse(apiPath);

  logNoStack.i("API_UTILS:apiPostDataStrNoLocale: $url $jsonDataStr");

  final http.Response response;
  if (jsonDataStr != null) {
    response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonDataStr);
  } else {
    // No data
    response = await http.post(url, headers: {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": "Bearer $token",
    });
  }

  log.i("API_UTILS:apiPostDataStrNoLocale: ${response.statusCode}");
  if (response.statusCode == 204 ||
      response.statusCode == 202 ||
      response.statusCode == 201 ||
      response.statusCode == 200) {
    return response;
  } else {
    log.i(
        "API POST DATA: apiPostDataStrNoLocaleapiPost created unsuccessfully!");
    throw "api Post created unsuccessfully!";
  }
}

Future<http.Response> apiPutDataStrNoLocale(
    String token, String apiPath, String? jsonDataStr) async {
  var url = Uri.parse(apiPath);

  logNoStack.i("API_UTILS:apiPutDataStrNoLocale: $url $jsonDataStr");

  final http.Response response;
  if (jsonDataStr != null) {
    response = await http.put(url,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonDataStr);
  } else {
    // No data
    response = await http.post(url, headers: {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": "Bearer $token",
    });
  }

  log.i("API_UTILS:apiPutDataStrNoLocale: ${response.statusCode}");
  if (response.statusCode == 204 ||
      response.statusCode == 202 ||
      response.statusCode == 201 ||
      response.statusCode == 200) {
    return response;
  } else {
    log.i(
        "API POST DATA: apiPutDataStrNoLocaleapiPost created unsuccessfully!");
    throw "api Post created unsuccessfully!";
  }
}

Future<http.Response> apiGetData(String apiPath, String accept) async {
  var url = Uri.parse(apiPath);

  final http.Response response;
  logNoStack.i(
      "Response code for apiGeData is $apiPath for \"Content-Type\" and \"Accept\" $accept");
  // No data
  response = await http.get(url, headers: {
    "Content-Type": accept,
    "Accept": accept,
  });

  logNoStack
      .i("Response code for apiGeData is ${response.statusCode} for $apiPath");
  if (response.statusCode == 202 ||
      response.statusCode == 201 ||
      response.statusCode == 200) {
    return response;
  } else {
    logNoStack.e(
        "API GET DATA: apiGetData created unsuccessfully! ${response.statusCode}");
    throw "api Get created unsuccessfully!";
  }
}

Future<http.Response> apiPostDataStr(
    Locale locale, String token, String apiPath, String? jsonDataStr) async {
  var url = Uri.parse(apiPath);

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

Future<Person> registerLogin(
  String token,
) async {
  String deviceId = await fetchDeviceId();
  logNoStack.i("API_UTILS: Login: deviceid=$deviceId");
  String url =
      "$defaultAPIBaseUrl$defaultApiPrefixPath/persons/login?devicecode=$deviceId";
  try {
    var currentUserMap =
        await apiPostDataNoLocale(token, url, "deviceid", deviceId);

    var currentUser = Person.fromJson(currentUserMap);

    logNoStack.i("API_UTILS: Logged in user $currentUser");
    return currentUser;
  } on Exception catch (error) {
    throw ("API_UTILS: login error $error for $url");
  }
}

Future<bool> verifyToken(String token) async {
  bool hasExpired = JwtDecoder.isExpired(token);

  DateTime? expirationDate;
  try {
    expirationDate = JwtDecoder.getExpirationDate(token);
  } on Exception {
    return false;
  }
  // 2025-01-13 13:04:18.000
  logNoStack.i("Expiry Token: $expirationDate");

  Duration tokenTime = JwtDecoder.getTokenTime(token);

  // 15
  logNoStack.i("Duration of Token: ${tokenTime.inMinutes}");

  if (hasExpired) {
    return false;
  }

  var url = Uri.parse("$defaultAPIBaseUrl$defaultApiPrefixPath/persons/login");

  final http.Response response;

  // No data
  response = await http.post(url, headers: {
    "Content-Type": "application/json",
    "Accept": "application/json",
    "Authorization": "Bearer $token",
  });

  logNoStack.d(response.statusCode);
  if (response.statusCode == 202 ||
      response.statusCode == 201 ||
      response.statusCode == 200) {
    return true;
  } else {
    return false;
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

// Future<void> registerLogout(Locale locale, String token) async {
//   apiPost(locale, token, "$defaultAPIBaseUrl$defaultApiPrefixPath/persons/logout").then((result) {
//     log.d("logout result $result");
//   }).catchError((error) {
//     log.e("Register logout error");
//   });
// }

Future<Map> registerFCM(
    /*Locale locale, */ String token, String deviceid, String fcm) async {
  logNoStack.i(
      "REGISTER FCM: About to send FCM and deviceid to api $defaultAPIBaseUrl$defaultApiPrefixPath/persons/devicefcm/$deviceid/$fcm");
  apiPostNoLocale(token,
          "$defaultAPIBaseUrl$defaultApiPrefixPath/persons/devicefcm/$deviceid/$fcm")
      .then((response) {
    logNoStack.i("REGISTER FCM: back from send FCM sending $deviceid");
    logNoStack.i("REGISTER FCM: result ${response.toString()}");
    return response;
  }).catchError((error) {
    log.e("REGISTER FCM: Register FCM error $error ");
    // ignore: invalid_return_type_for_catch_error
    return Map;
  });
  return <dynamic, dynamic>{};
}

Future<String> fetchLatestAppVersion() async {
  var apiPath = "$defaultAPIBaseUrl$defaultApiPrefixPath/appversionss/latest";
  try {
    var response = await apiGetData(apiPath, "application/json");
    logNoStack.d("FETCH LATEST APP VERSION: result ${response.body}");
    final map = jsonDecode(response.body);
    AppVersion appVersion = AppVersion.fromJson(map);
    logNoStack
        .i("Latest AppVersion is $appVersion , current version is $appVersion");
    //return response.body;
    return appVersion.version!;
  } on Exception catch (error) {
    throw ("API_UTILS: Register login error $error");
  }
}

Future<void> uploadMinio(String file) async {}

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

  var response = await apiPostDataStr(locale, token,
      "$defaultAPIBaseUrl$defaultApiPrefixPath/gps/fetch", jsonDataStr);
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

Future<bool> updateKeycloakUserInfo(String token, String id, String email,
    String firstname, String lastname) async {
//PUT /{realm}/users/{id}

  var url =
      Uri.parse("$defaultAPIBaseUrl$defaultApiPrefixPath/persons/update/$id");

  final http.Response response;
  logNoStack.i("API_UTILS: update user: $lastname");
  // No data
  response = await http.put(url, headers: {
    "Content-Type": "application/json",
    "Accept": "application/json",
    "Authorization": "Bearer $token",
  }, body: {
    "lastName": lastname,
  }
      // body: jsonEncode(<String, dynamic>{
      //        // 'username': email,
      //       //  'firstName': firstname,
      //         'lastName': lastname,
      //       //  'email': email,
      //         // Add any other data you want to send in the body
      //       })
      );

  logNoStack.i(response.statusCode);
  if (response.statusCode == 204 ||
      response.statusCode == 202 ||
      response.statusCode == 201 ||
      response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}

Future<bool> updateKeycloakPassword(
    String token, String id, String password) async {
//PUT /{realm}/users/{id}

  var url =
      Uri.parse("$defaultAPIBaseUrl$defaultApiPrefixPath/persons/password/$id");

  final http.Response response;

  // No data
  response = await http.put(url,
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      },
      body: jsonEncode(password));

  logNoStack.i(response.statusCode);
  if (response.statusCode == 204 ||
      response.statusCode == 202 ||
      response.statusCode == 201 ||
      response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}

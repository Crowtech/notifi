/// API utilities for making HTTP requests to the Notifi backend services.
///
/// This module provides a comprehensive set of functions for interacting with
/// the Notifi API, including authentication, data fetching, and updates.
/// All functions handle JWT token-based authentication and support localization.
library;

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:logger/logger.dart' as logger;
import 'dart:developer' as developer;
import 'package:notifi/credentials.dart';
import 'package:notifi/jwt_utils.dart';
import 'package:notifi/models/appversion.dart';
import 'package:notifi/models/gps.dart';
import 'package:notifi/models/nestfilter.dart';
import 'package:notifi/models/person.dart';

import 'models/crowtech_basepage.dart';

/// Logger instance with full stack trace for detailed debugging
var log = logger.Logger(
  printer: logger.PrettyPrinter(),
  level: logger.Level.info,
);

/// Logger instance without stack trace for cleaner output
var logNoStack = logger.Logger(
  printer: logger.PrettyPrinter(methodCount: 0),
  level: logger.Level.info,
);

/// The default locale from the platform settings
final String defaultLocale = Platform.localeName;

/// Makes a POST request without locale headers.
///
/// This is a convenience wrapper around [apiPostDataNoLocale] for requests
/// that don't require any request body data.
///
/// **Parameters:**
/// - `token`: JWT authentication token
/// - `apiPath`: Full API endpoint URL
///
/// **Returns:** Decoded JSON response as dynamic object
///
/// **Throws:** Error message if request fails
Future<dynamic> apiPostNoLocale(String token, String apiPath) async {
  return apiPostDataNoLocale(token, apiPath, null, null);
}

/// Makes a POST request with optional data payload, without locale headers.
///
/// This function handles POST requests that don't require localization.
/// It supports both empty requests and requests with JSON payloads.
///
/// **Parameters:**
/// - `token`: JWT authentication token
/// - `apiPath`: Full API endpoint URL
/// - `dataName`: Optional key name for the data in JSON body
/// - `data`: Optional data object to send in request body
///
/// **Returns:** Decoded JSON response or empty array if no content
///
/// **Throws:** Error message with status code if request fails
///
/// **Status Codes Handled:**
/// - 200-204: Success responses
///
/// **Example:**
/// ```dart
/// final result = await apiPostDataNoLocale(
///   token,
///   'https://api.example.com/users',
///   'user',
///   {'name': 'John', 'email': 'john@example.com'}
/// );
/// ```
Future<dynamic> apiPostDataNoLocale(
    String token, String apiPath, String? dataName, Object? data) async {
  logNoStack.i("API POST : APIPath -> $apiPath");
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
    if (apiPath.startsWith("http://")) {
      logNoStack.i("API POST : sending as http://");
      response = await http.post(url, headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      });
    } else {
      // No data
      response = await http.post(url, headers: {
        "Content-Type": "application/json",
        //"Accept": "application/json",
        "Authorization": "Bearer $token",
      });
    }
  }

  logNoStack.i(response.statusCode);
  if (response.statusCode == 204 ||
      response.statusCode == 203 ||
      response.statusCode == 202 ||
      response.statusCode == 201 ||
      response.statusCode == 200) {
    logNoStack.i(
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

/// Makes a POST request with raw JSON data, without locale headers.
///
/// Unlike [apiPostDataNoLocale], this function sends the data object directly
/// as JSON without wrapping it in another object. Useful for APIs that expect
/// the payload at the root level.
///
/// **Parameters:**
/// - `token`: JWT authentication token
/// - `apiPath`: Full API endpoint URL
/// - `data`: Data object to send as raw JSON in request body
///
/// **Returns:** Decoded JSON response or empty array if no content
///
/// **Throws:** Error message with status code if request fails
///
/// **Example:**
/// ```dart
/// final result = await apiPostDataNoLocaleRaw(
///   token,
///   'https://api.example.com/users',
///   {'name': 'John', 'email': 'john@example.com'}
/// );
/// ```
Future<dynamic> apiPostDataNoLocaleRaw(
    String token, String apiPath, Object? data) async {
  logNoStack.i("API POST RAW: APIPath -> $apiPath");
  var url = Uri.parse(apiPath);
  String jsonData;
  final http.Response response;
  jsonData = jsonEncode(data);

  response = await http.post(url,
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      },
      body: jsonData);

  logNoStack.i(response.statusCode);
  if (response.statusCode == 202 ||
      response.statusCode == 201 ||
      response.statusCode == 200) {
    logNoStack.d(
        "API POST RAW No LOCALE: $apiPath created successfully! with status ${response.statusCode}");
    logNoStack.d("API POST No Locale: respose is ${response.body}");
    if (response.body.isEmpty) {
      return [];
    }
    final resultMap = jsonDecode(response.body);
    return resultMap;
  } else {
    logNoStack.e(
        "$apiPath RAW created unsuccessfully! with url $url status ${response.statusCode} and error: ${response.reasonPhrase}");
    return Future.error(
        "$apiPath RAW created unsuccessfully! with url $url status ${response.statusCode} and error: ${response.reasonPhrase}");
  }
}

/// Makes a POST request with locale headers.
///
/// This is a convenience wrapper around [apiPostData] for requests
/// that don't require any request body data but need localization.
///
/// **Parameters:**
/// - `locale`: Locale for content localization
/// - `token`: JWT authentication token
/// - `apiPath`: Full API endpoint URL
///
/// **Returns:** Decoded JSON response as dynamic object
///
/// **Throws:** Error message if request fails
Future<dynamic> apiPost(Locale locale, String token, String apiPath) async {
  return apiPostData(locale, token, apiPath, null, null);
}

/// Makes a POST request with optional data payload and locale headers.
///
/// This function handles POST requests that require localization support.
/// The Accept-Language header is set based on the provided locale.
///
/// **Parameters:**
/// - `locale`: Locale for content localization
/// - `token`: JWT authentication token
/// - `apiPath`: Full API endpoint URL
/// - `dataName`: Optional key name for the data in JSON body
/// - `data`: Optional data object to send in request body
///
/// **Returns:** Decoded JSON response as dynamic object
///
/// **Throws:** Error message with status code if request fails
///
/// **Example:**
/// ```dart
/// final result = await apiPostData(
///   Locale('en', 'US'),
///   token,
///   'https://api.example.com/users',
///   'user',
///   {'name': 'John'}
/// );
/// ```
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
        "API POST DATA: $apiPath created unsuccessfully! with status ${response.statusCode} $apiPath $data");
    return Future.error(
        "API POST DATA: $apiPath created unsuccessfully! with status ${response.statusCode} $apiPath $data");
  }
}

/// Makes a POST request with pre-encoded JSON string, without locale headers.
///
/// This function is useful when you need fine control over the JSON encoding
/// or when working with pre-encoded JSON strings.
///
/// **Parameters:**
/// - `token`: JWT authentication token
/// - `apiPath`: Full API endpoint URL
/// - `jsonDataStr`: Pre-encoded JSON string to send in request body
///
/// **Returns:** Raw HTTP response object
///
/// **Throws:** Exception with error details if request fails
///
/// **Example:**
/// ```dart
/// final jsonStr = jsonEncode({'name': 'John'});
/// final response = await apiPostDataStrNoLocale(token, url, jsonStr);
/// ```
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
        "API POST DATA: apiPostDataStrNoLocaleapiPost created unsuccessfully ${response.statusCode} $apiPath $jsonDataStr!");
    throw "api Post created unsuccessfully! ${response.statusCode} $apiPath $jsonDataStr!";
  }
}

/// Makes a PUT request with pre-encoded JSON string, without locale headers.
///
/// Similar to [apiPostDataStrNoLocale] but uses PUT method for updates.
/// Note: Falls back to POST if jsonDataStr is null (likely a bug).
///
/// **Parameters:**
/// - `token`: JWT authentication token
/// - `apiPath`: Full API endpoint URL
/// - `jsonDataStr`: Pre-encoded JSON string to send in request body
///
/// **Returns:** Raw HTTP response object
///
/// **Throws:** Exception with error details if request fails
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

/// Makes a GET request with optional authentication.
///
/// This is a convenience wrapper around [apiGetData] that defaults to
/// JSON content type.
///
/// **Parameters:**
/// - `token`: Optional JWT authentication token (null for public endpoints)
/// - `apiPath`: Full API endpoint URL
///
/// **Returns:** Raw HTTP response object
///
/// **Throws:** Exception if request fails
Future<http.Response> apiGet(String? token, String apiPath) async {
  return apiGetData(token, apiPath, "application/json");
}

/// Makes a GET request with customizable content type and optional auth.
///
/// This function handles GET requests with flexible content type support,
/// useful for downloading different types of content (JSON, images, files).
///
/// **Parameters:**
/// - `token`: Optional JWT authentication token (null for public endpoints)
/// - `apiPath`: Full API endpoint URL
/// - `accept`: Content type for Accept header (e.g., 'application/json')
///
/// **Returns:** Raw HTTP response object
///
/// **Throws:** Exception with message "api Get created unsuccessfully!"
///
/// **Example:**
/// ```dart
/// // Get JSON data
/// final response = await apiGetData(token, url, 'application/json');
/// // Get image
/// final image = await apiGetData(token, imageUrl, 'image/png');
/// ```
Future<http.Response> apiGetData(
    String? token, String apiPath, String accept) async {
  var url = Uri.parse(apiPath);

  final http.Response response;
  logNoStack.i(
      "Response code for apiGetData is $apiPath for \"Content-Type\" and \"Accept\" $accept");
  // No data
  if (token == null) {
    response = await http.get(url, headers: {
      "Content-Type": accept,
      "Accept": accept,
    });
  } else {
    response = await http.get(url, headers: {
      "Content-Type": accept,
      "Authorization": "Bearer $token",
      "Accept": accept,
    });
  }

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

/// Makes a POST request with pre-encoded JSON string and locale headers.
///
/// Combines the functionality of sending raw JSON strings with localization
/// support through Accept-Language header.
///
/// **Parameters:**
/// - `locale`: Locale for content localization
/// - `token`: JWT authentication token
/// - `apiPath`: Full API endpoint URL
/// - `jsonDataStr`: Pre-encoded JSON string to send in request body
///
/// **Returns:** Raw HTTP response object
///
/// **Throws:** Exception with message "api Post created unsuccessfully!"
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

/// Makes a DELETE request to remove a resource.
///
/// Sends a DELETE request with authentication to remove a resource
/// at the specified endpoint.
///
/// **Parameters:**
/// - `token`: JWT authentication token
/// - `apiPath`: Full API endpoint URL of resource to delete
///
/// **Returns:** Raw HTTP response object
///
/// **Throws:** Exception with message "api Get created unsuccessfully!" (sic)
///
/// **Example:**
/// ```dart
/// final response = await apiDeleteData(token, '$baseUrl/users/123');
/// ```
Future<http.Response> apiDeleteData(String? token, String apiPath) async {
  var url = Uri.parse(apiPath);

  final http.Response response;
  logNoStack.i("Response code for apiDeleteData is $apiPath ");
  response = await http.delete(url, headers: {
    "Authorization": "Bearer $token",
  });

  logNoStack.i(
      "Response code for apiDeleteData is ${response.statusCode} for $apiPath");
  if (response.statusCode == 202 ||
      response.statusCode == 201 ||
      response.statusCode == 200) {
    return response;
  } else {
    logNoStack.e(
        "API DELETE DATA: apiDeleteData created unsuccessfully! ${response.statusCode}");
    throw "api Get created unsuccessfully!";
  }
}

/// Registers a login for the current device and returns user information.
///
/// This function performs device-based login by sending the device ID
/// to the server and receiving back the authenticated user's information.
///
/// **Parameters:**
/// - `token`: JWT authentication token
///
/// **Returns:** [Person] object containing authenticated user information
///
/// **Throws:** Error message with URL if login fails
///
/// **Process:**
/// 1. Fetches device ID using platform-specific methods
/// 2. Sends device ID to login endpoint
/// 3. Parses response into Person object
///
/// **Example:**
/// ```dart
/// try {
///   final user = await registerLogin(authToken);
///   print('Logged in as: ${user.name}');
/// } catch (e) {
///   print('Login failed: $e');
/// }
/// ```
Future<Person> registerLogin(
  String token,
) async {
  String deviceId = await fetchDeviceId();
  logNoStack.i("API_UTILS: Login: deviceid=$deviceId");
  String url =
      "$defaultAPIBaseUrl$defaultApiPrefixPath/persons/login?devicecode=$deviceId";
  try {
    developer.log("registerLogin: token ${token}");
    var currentUserMap =
        await apiPostDataNoLocale(token, url, "deviceid", deviceId);
 logNoStack.i("API_UTILS: registerLogin response $currentUserMap");
    var currentUser = Person.fromJson(currentUserMap);

    logNoStack.i("API_UTILS: Logged in user $currentUser");
    return currentUser;
  } on Exception catch (error) {
    throw ("API_UTILS: login error $error for $url");
  }
}

/// Verifies if a JWT token is valid and not expired.
///
/// This function performs both client-side and server-side validation:
/// 1. Checks if token is expired using JWT decoder
/// 2. Extracts and logs token expiration time
/// 3. Makes API call to verify token with server
///
/// **Parameters:**
/// - `token`: JWT token to verify
///
/// **Returns:**
/// - `true` if token is valid and verified by server
/// - `false` if token is expired or server validation fails
///
/// **Example:**
/// ```dart
/// if (await verifyToken(userToken)) {
///   // Token is valid, proceed with authenticated requests
/// } else {
///   // Token invalid, redirect to login
/// }
/// ```
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

/// Registers a Firebase Cloud Messaging token for a device.
///
/// Associates an FCM token with a device ID on the server, enabling
/// push notifications to be sent to this specific device.
///
/// **Parameters:**
/// - `token`: JWT authentication token
/// - `deviceid`: Unique device identifier
/// - `fcm`: Firebase Cloud Messaging token
///
/// **Returns:** Map containing server response (currently returns empty map)
///
/// **Note:** This function has async issues - it doesn't properly await
/// the API call, always returning an empty map immediately.
///
/// **Example:**
/// ```dart
/// await registerFCM(authToken, deviceId, fcmToken);
/// ```
Future<Map> registerFCM(
    /*Locale locale, */ String token, String deviceid, String fcm) async {
  log.i(
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

/// Fetches the latest app version from the server.
///
/// Queries the server for the most recent app version information,
/// useful for checking if updates are available.
///
/// **Returns:** Version string (e.g., "1.2.3")
///
/// **Throws:** Error message if request fails
///
/// **Note:** The endpoint has a typo: "appversionss" instead of "appversions"
///
/// **Example:**
/// ```dart
/// try {
///   final latestVersion = await fetchLatestAppVersion();
///   if (latestVersion != currentVersion) {
///     // Prompt user to update
///   }
/// } catch (e) {
///   // Handle error gracefully
/// }
/// ```
Future<String> fetchLatestAppVersion() async {
  var apiPath = "$defaultAPIBaseUrl$defaultApiPrefixPath/appversionss/latest";
  try {
    var response = await apiGetData(null, apiPath, "application/json");
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

/// Uploads a file to MinIO object storage.
///
/// **Parameters:**
/// - `file`: File path or identifier to upload
///
/// **Note:** This function is currently not implemented (empty body)
///
/// TODO: Implement MinIO upload functionality
Future<void> uploadMinio(String file) async {}

/// Fetches paginated GPS data for a specific organization.
///
/// Retrieves GPS tracking information with filtering and pagination support.
/// Uses NestFilter for complex query capabilities including sorting and
/// distinct field selection.
///
/// **Parameters:**
/// - `locale`: Locale for content localization
/// - `token`: JWT authentication token
/// - `orgid`: Organization ID to filter GPS data
/// - `offset`: Pagination offset (starting index)
/// - `limit`: Maximum number of items to return
///
/// **Returns:** [CrowtechBasePage<GPS>] containing:
/// - List of GPS items
/// - Total count of available items
/// - Processing time and pagination metadata
///
/// **Filter Configuration:**
/// - Sorts by ID descending
/// - Case-insensitive search
/// - Distinct by resource code
///
/// **Example:**
/// ```dart
/// final gpsData = await fetchGPS(
///   Locale('en'),
///   token,
///   orgId: 123,
///   offset: 0,
///   limit: 50
/// );
/// print('Found ${gpsData.totalItems} GPS records');
/// ```
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

/// Updates user information in Keycloak identity provider.
///
/// Currently only updates the last name field, despite accepting all
/// user fields as parameters.
///
/// **Parameters:**
/// - `token`: JWT authentication token
/// - `id`: User ID in Keycloak
/// - `email`: User's email (currently unused)
/// - `firstname`: User's first name (currently unused)
/// - `lastname`: User's last name to update
///
/// **Returns:**
/// - `true` if update successful (2xx status)
/// - `false` if update failed
///
/// **Note:** The implementation only sends lastname in the request body.
/// Other fields are accepted but ignored.
///
/// **Example:**
/// ```dart
/// final success = await updateKeycloakUserInfo(
///   token,
///   userId,
///   'john@example.com',
///   'John',
///   'Smith'
/// );
/// ```
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

/// Updates a user's password in Keycloak.
///
/// Sends a password update request to the Keycloak admin API.
///
/// **Parameters:**
/// - `token`: JWT authentication token with admin privileges
/// - `id`: User ID in Keycloak
/// - `password`: New password to set
///
/// **Returns:**
/// - `true` if password updated successfully (2xx status)
/// - `false` if update failed
///
/// **Security Note:** Ensure password meets complexity requirements
/// before calling this function.
///
/// **Example:**
/// ```dart
/// final success = await updateKeycloakPassword(
///   adminToken,
///   userId,
///   'NewSecurePassword123!'
/// );
/// if (!success) {
///   // Handle password update failure
/// }
/// ```
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

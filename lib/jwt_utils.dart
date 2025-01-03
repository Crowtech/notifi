// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:app_set_id/app_set_id.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:logger/logger.dart' as logger;
import 'package:notifi/notifi.dart';
import 'package:notifi/models/person.dart' as person;
import 'package:oidc/oidc.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';

import 'api_utils.dart';
import 'credentials.dart';
import 'models/person.dart';

var log = logger.Logger(
  printer: logger.PrettyPrinter(),
  level: logger.Level.info,
);

var logNoStack = logger.Logger(
  printer: logger.PrettyPrinter(methodCount: 0),
  level: logger.Level.info,
);

String getResourceCodeFromSub(String? sub) {
  if (sub == null) {
    return "PER_UNKNOWN";
  }
  final RegExp pattern = RegExp(r'[^a-zA-Z0-9]');
  String resourcecode = sub.replaceAll(pattern, "_");
  resourcecode = "PER_${resourcecode.toUpperCase()}";
  return resourcecode;
}

String getResourceCodeFromJwt(String jwt) {
  Map<String, dynamic> decodedToken = JwtDecoder.decode(jwt);
  String resourcecode = decodedToken['sub'];

  return getResourceCodeFromJwt(resourcecode);
}

String getResourceCode(OidcUser user) {
  return getResourceCodeFromSub(user.uid);
}

String getAccessToken(OidcUser user) {
  return user.token.accessToken!;
}

String getEmail(OidcUser user) {
  return user.claims.toJson()['email'];
}

String getLastname(OidcUser user) {
  return user.claims.toJson()['family_name'];
}

String getFirstname(OidcUser user) {
  return user.claims.toJson()['given_name'];
}

String getUsername(OidcUser user) {
  return user.claims.toJson()['preferred_username'];
}

Future<bool> loginUser(BuildContext context, String token) async {
  Locale myLocale = Localizations.localeOf(context);
  logNoStack.d("token used is $token");
  logNoStack.d("locale used is $myLocale");
  String deviceid = await fetchDeviceId();
  // var url =
  //     Uri.parse("$defaultAPIBaseUrl$defaultApiPrefixPath/persons/register?deviceid=$deviceid");
  // var fcm;
  // final response = await http.post(url,
  //     headers: {
  //       "Content-Type": "application/json",
  //       "Accept": "application/json",
  //       "Authorization": "Bearer $token",
  //       "Accept-Language": "$myLocale",
  //     },
  //     body: jsonEncode({
  //       fcm,
  //     })
  //     );

  apiPost(myLocale, token,
          "$defaultApiPrefixPath/persons/login?devicecode=$deviceid")
      .then((resultMap) {
    logNoStack.i("Register login Post created successfully!");
    // final userMap = jsonDecode(response.body);
    // logNoStack.i("logged in user map: $userMap");
    // String userJson = jsonEncode(userMap);
    // logNoStack.i("logged in user json: $userJson");
    // String uJson = '{"id":37,"created":"2024-11-16T23:49:52.669864","updated":"2025-01-01T08:27:02.340004","code":"PER_2DC66E1A_A275_4EFF_AD81_C1F1A7CCA6E0","name":"Panta Dev","description":"Panta Dev registered 2024-11-16T23:49:52.669739","devicecode":"test","username":"hello@pantagroup.org","email":"hello@pantagroup.org","firstname":"Panta","lastname":"Dev","nickname":"Panta Dev","gender":"UNDEFINED","i18n":"en","fcm":"dSfKKWS2uUTPdf3pcZGL_Y:APA91bHQonVTK_Wc3gGK7VW3b86zqzotNvjDokVN7QRmxGMoTerkGak9MXCkNeUUCFR05ReI4W_ajpw9GH6upoBOv43jpGQM5R4Z-KwFVEE-H2vNuQnUs00"}';
//var uMap = jsonDecode(uJson);
    //person.Person user = person.Person.fromJson(uMap);
    person.Person user = person.Person.fromJson(resultMap);
    //logNoStack.i("logged in user: $user");
    Provider.of<Notifi>(context, listen: false).user = user;
    logNoStack.i(
        "logged in notifi user: ${Provider.of<Notifi>(context, listen: false).user}");
    return true;
  }).catchError((error) {
    log.e("login api error");
    
  });

  return false;
}

void initNotifi(BuildContext context, String token, String topic) async {
  // var packageInfo = await fetchPackageInfo();
  // var deviceId = await fetchDeviceId();

  logNoStack.i("NOTIFI INIT ");

  var notifi = Provider.of<Notifi>(context, listen: false);
  await Provider.of<Notifi>(context, listen: false).init();

  void notifiListener() {
    if (!context.mounted) return;
    logNoStack.d("Main:NotifiListener triggered , fcm is ${notifi.fcm}");
    Locale locale = Localizations.localeOf(context);
    registerFCM(locale, token, notifi.deviceId!, notifi.fcm);
  }

  Provider.of<Notifi>(context, listen: false).addListener(notifiListener);
}

Future<PackageInfo> fetchPackageInfo() async {
  var info = await PackageInfo.fromPlatform();
  logNoStack.d("NOTIFI PACKAGE INFO is $info");

  return info;
}

Future<String> fetchDeviceType() async {
  String deviceType = "";

  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  if (kIsWeb) {
    WebBrowserInfo webBrowserInfo = await deviceInfo.webBrowserInfo;
    logNoStack.d('Running on : [${webBrowserInfo.browserName.name}]');
    deviceType = webBrowserInfo.browserName.name.trim();
    logNoStack.d("Got the deviceType => $deviceType");
  } else {
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      logNoStack.d('Running on : ${androidInfo.product.toString()}');
      deviceType = 'AND${androidInfo.brand}$deviceType';
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      logNoStack.d('Running on : ${iosInfo.utsname.machine}');
      deviceType = 'IOS${iosInfo.model}$deviceType';
    }
  }
  return deviceType;
}

Future<String> fetchDeviceId() async {
  String deviceId = "Loading...";
  String deviceType = await fetchDeviceType();

  if (kIsWeb) {
    deviceId = "Web:" + deviceType;
  } else {
    final appSetIdPlugin = AppSetId();
    deviceId = await appSetIdPlugin.getIdentifier() ?? "Unknown";
    deviceId = "$deviceType:$deviceId"; // watch for OS
  }
  return deviceId;
}

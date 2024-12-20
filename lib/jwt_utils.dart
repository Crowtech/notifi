import 'dart:convert';

import 'package:app_set_id/app_set_id.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';

import 'package:package_info_plus/package_info_plus.dart';

import 'package:notifi/notifi.dart';
import 'package:oidc/oidc.dart';
import 'package:app_set_id/app_set_id.dart';
import 'package:provider/provider.dart';
import 'package:logger/logger.dart' as logger;

import 'api_utils.dart';
import 'credentials.dart';

var log = logger.Logger(
  printer: logger.PrettyPrinter(),
  level: logger.Level.info,
);

String getResourceCodeFromSub(String? sub) {
  if (sub == null) {
    return "PER_UNKNOWN";
  }
  final RegExp pattern = RegExp(r'[^a-zA-Z0-9]');
  String resourcecode = sub!.replaceAll(pattern, "_");
  resourcecode = "PER_${resourcecode.toUpperCase()}";
  return resourcecode;
}

String getResourceCodeFromJwt(String jwt) {
  Map<String, dynamic> decodedToken = JwtDecoder.decode(jwt!);
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

Future<bool> loginUser(BuildContext context,String token) async {
  // OgAuthProvider authProvider =
  //     Provider.of<OgAuthProvider>(context, listen: false);

  Locale myLocale = Localizations.localeOf(context);
  log.d("token used is $token");
  log.d("locale used is $myLocale");
  var url = Uri.parse("$defaultAPIBaseUrl/p/persons/register");
  var fcm = null;
  final response = await http.post(url,
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "Bearer $token",
        "Accept-Language": "$myLocale",
      },
      body: jsonEncode({
        "fcm": fcm,
      }));
  log.d(response.statusCode);
  if (response.statusCode == 202) {
    log.d("Register login Post created successfully!");
    final userMap = jsonDecode(response.body);
    log.d("logged in user: ${userMap}");
    return true;
    
    // MyPage<Attribute> pageAttribute =
    //     new MyPage<Attribute>(itemFromJson: Attribute.fromJson).fromJson(map);
    // log.d(pageAttribute);
  } else {
    log.d("Register Post created unsuccessfully!");
    throw "Register Post created unsuccessfully!";
  }
}

void initNotifi(BuildContext context,String token, String topic) async {

  var packageInfo = await fetchPackageInfo();
  var deviceId = await fetchDeviceId();

    log.d("NOTIFI INIT ${packageInfo!.version} ${deviceId} ");

  List<String> topics = [];
  topics.add(topic);
  // Notifi notifi = Notifi(
  //     // Initialize notification system
  //     options: DefaultFirebaseOptions.currentPlatform,
  //     vapidKey:
  //         "BJx1wQv5p6KfUVYDvlhivY_kvg3CLawanH5fidaQN6lk1yNBTq4-QLmbq0Y2T1jlWUgzr6fBqjXp0cjr22QZGTQ",
  //     secondsToast: 4,
  //     topics: topics,
  //     packageInfoFuture: fetchPackageInfo(),
  //    deviceId: deviceId);
  await Provider.of<Notifi>(context,listen:false).init();
  //await notifi.init(); // Initialize notifications
  
  //await notifi.nest.init();


  void notifiListener() {
    if (!context.mounted) return;
    log.d("Main:NotifiListener triggered , fcm is ${Provider.of<Notifi>(context,listen:false).fcm}");
    saveFCM(token, deviceId, Provider.of<Notifi>(context,listen:false).fcm);
  }

  Provider.of<Notifi>(context,listen:false).addListener(notifiListener);
}



 Future<PackageInfo> fetchPackageInfo() async {
    var info = await PackageInfo.fromPlatform();
    log.d("NOTIFI PACKAGE INFO is $info");

    return info;

  }

  Future<String> fetchDeviceId() async {
    String deviceId = "Loading...";
      final _appSetIdPlugin = AppSetId();
      deviceId = await _appSetIdPlugin.getIdentifier() ?? "Unknown";
    
    return deviceId;
  }

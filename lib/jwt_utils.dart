// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';
import 'package:crypto/crypto.dart';

import 'package:app_set_id/app_set_id.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:logger/logger.dart' as logger;
import 'package:notifi/i18n/string_hardcoded.dart';
import 'package:notifi/notifi.dart';
import 'package:notifi/models/person.dart' as person;
import 'package:notifi/riverpod/current_user.dart';
import 'package:oidc/oidc.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' as prov;

import 'api_utils.dart';
import 'credentials.dart';

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

Future<bool> loginUser(
    BuildContext context, prov.WidgetRef ref, String token) async {
  Locale myLocale = Localizations.localeOf(context);
  logNoStack.d("token used is $token");
  logNoStack.d("locale used is $myLocale");
  String deviceid = await fetchDeviceId();
  String url =
      "$defaultAPIBaseUrl$defaultApiPrefixPath/persons/login?devicecode=$deviceid";
  logNoStack.i("login api url = $url");
  apiPost(myLocale, token, url).then((resultMap) {
    logNoStack.i("Register login Post created successfully!");

    person.Person user = person.Person.fromJson(resultMap);
    logNoStack.i("logged in user: $user");
    // Provider.of<Notifi>(context, listen: false).currentUser = user;
    // logNoStack.i(
    //     "logged in notifi user: ${Provider.of<Notifi>(context, listen: false).currentUser}");

    ref.read(currentUserProvider.notifier).setPerson(user);
    return true;
  }).catchError((error) {
    log.e("login api error $error");
    return false;
  });

  return false;
}

void initNotifi(BuildContext context, String token, String topic) async {
  // var packageInfo = await fetchPackageInfo();
  // var deviceId = await fetchDeviceId();

  logNoStack.i("NOTIFI INIT ");

  // var notifi = Provider.of<Notifi>(context, listen: false);
  await Provider.of<Notifi>(context, listen: false).init();

  // void notifiListener() {
  //   if (!context.mounted) return;
  //   logNoStack.d("Main:NotifiListener triggered , fcm is ${notifi.fcm}");
  //   Locale locale = Localizations.localeOf(context);
  //   registerFCM(locale, token, notifi.deviceId!, notifi.fcm);
  // }

  // Provider.of<Notifi>(context, listen: false).addListener(notifiListener);
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
    deviceId = "Web:$deviceType";
  } else {
    final appSetIdPlugin = AppSetId();
    deviceId = await appSetIdPlugin.getIdentifier() ?? "Unknown";
    deviceId = "$deviceType:$deviceId"; // watch for OS
  }
  return deviceId;
}

String generateMd5(String input) {
  return md5.convert(utf8.encode(input)).toString();
}

void registerErrorHandlers() {
  // * Show some error UI if any uncaught exception happens
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
    debugPrint(details.toString());
  };
  // * Handle errors from the underlying platform/OS
  PlatformDispatcher.instance.onError = (Object error, StackTrace stack) {
    debugPrint(error.toString());
    return true;
  };
  // * Show some error UI when any widget in the app fails to build
  ErrorWidget.builder = (FlutterErrorDetails details) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('An error occurred'.hardcoded),
      ),
      body: Center(child: Text(details.toString())),
    );
  };
}
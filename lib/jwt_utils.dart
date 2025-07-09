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
import 'package:notifi/entities/user_role.dart';
import 'package:notifi/i18n/string_hardcoded.dart';
import 'package:notifi/notifi_refactored.dart';
import 'package:notifi/models/person.dart' as person;
import 'package:oidc/oidc.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' as prov;
import 'package:notifi/i18n/strings.g.dart' as nt;

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

   // ref.read(currentUserProvider.notifier).setPerson(user);
  if (user.i18n == 'en') {
    nt.LocaleSettings.setLocale(nt.AppLocale.en);
  } else if (user.i18n == 'zh') {
    nt.LocaleSettings.setLocale(nt.AppLocale.zh);
  }

    return true;
  }).catchError((error) {
    log.e("login api error $error");
    return false;
  });

  return false;
}

void initNotifi(BuildContext context, String token, String topic) async {
  // Legacy function - converted to new architecture
  // The initialization is now handled by the Riverpod providers automatically
  // through the NotificationService and other providers in notifi_refactored.dart
  
  logNoStack.i("NOTIFI INIT (converted to new architecture)");
  
  // Note: The new architecture automatically initializes services when needed
  // Individual services like NotificationService, CameraService etc. are
  // initialized via their respective Riverpod providers
}

Future<PackageInfo> fetchPackageInfo() async {
  var info = await PackageInfo.fromPlatform();
  logNoStack.d("NOTIFI2 PACKAGE INFO is $info");

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
    deviceId = "$deviceType$deviceId"; // watch for OS
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

extension StringExtensions on String { 
  String capitalise() { 
    return "${this[0].toUpperCase()}${substring(1)}"; 
  } 
}

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}

String getImageUrl({String? url, int diameter=64, String defaultUrl="https://gravatar.com/avatar/E9BC1D1E7E57D73ACC1682C0AD66CA4F"}) {
  if (url == null || url.isEmpty) {
    url = defaultUrl;
  }
  return  "$defaultImageProxyUrl/${diameter}x/$url";
}

UserRole getRole(String? token)
{
  
  if (token == null) return const UserRole.none();

  bool hasExpired = JwtDecoder.isExpired(token);
  if (hasExpired) {
    logNoStack.e("Permissions: User  token has expired");
    return const UserRole.none();
  }
  DateTime expirationDate = JwtDecoder.getExpirationDate(token);

  // 2025-01-13 13:04:18.000
  logNoStack.i("token expiry datetime is $expirationDate");
  // use token to extract roles
  Duration tokenTime = JwtDecoder.getTokenTime(token);
  logNoStack.i("token duration is ${tokenTime.inMinutes} for $token");


  Map<String, dynamic> jwtMap = JwtDecoder.decode(token);
  logNoStack.i("PERMISSIONS: JWT Map is $jwtMap");
  List rolesList = jwtMap['realm_access']['roles'];
  String rolesStr = "";
  for (var i = 0; i < rolesList.length; i++) {
    if (rolesList[i] != null) {
      rolesStr += "${rolesList[i]}\n";
    }
  }
  logNoStack.i("PERMISSIONS: Roles for user are \n$rolesStr");
if (rolesList.contains("dev")) {
    return const UserRole.dev();
  }
   else if (rolesList.contains("superadmin")) {
    return const UserRole.admin();
  }  else if (rolesList.contains("orgadmin")) {
    return const UserRole.orgadmin();
    } else if (rolesList.contains("admin")) {
    return const UserRole.admin();
  } else if (rolesList.contains("manager")) {
    return const UserRole.manager();
  } else if (rolesList.contains("user")) {
    return const UserRole.user();
  }
  return const UserRole.none();
}

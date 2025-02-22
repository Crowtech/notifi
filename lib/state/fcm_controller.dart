import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:notifi/entities/fcm.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:logger/logger.dart' as logger;

part 'fcm_controller.g.dart';

var log = logger.Logger(
  printer: logger.PrettyPrinter(),
  level: logger.Level.info,
);

var logNoStack = logger.Logger(
  printer: logger.PrettyPrinter(methodCount: 0),
  level: logger.Level.info,
);

/// A mock of an Fcmenticated User
const _dummyFcm = Fcm.active(
  firebaseOptions: null,
  vapidKey: '',
  secondsToast: 3,
  topics: [],
  token: ''
);

@riverpod
Future<Fcm> fcm(
  Ref ref,
  // We can add arguments to the provider.
  // The type of the parameter can be whatever you wish.
  FirebaseOptions? options,
) async {
  // We can use the "activityType" argument to build the URL.
  // This will point to "https://boredapi.com/api/activity?type=<activityType>"
  // final response = await http.get(
  //   Uri(
  //     scheme: 'https',
  //     host: 'boredapi.com',
  //     path: '/api/activity',
  //     // No need to manually encode the query parameters, the "Uri" class does it for us.
  //     queryParameters: {'type': activityType},
  //   ),
  // );
  // final json = jsonDecode(response.body) as Map<String, dynamic>;
  //return Activity.fromJson(json);
  return _dummyFcm;
}

/// This controller is an [AsyncNotifier] that holds and handles our authentication state
@riverpod
class FcmController extends _$FcmController {
  late SharedPreferences _sharedPreferences;
  static const _sharedPrefsKey = 'token';

  

  @override
  Future<Fcm> build(FirebaseOptions options) async {
    _sharedPreferences = await SharedPreferences.getInstance();
    logNoStack.i("FCM_CONTROLLER Build!");

    
    return _dummyFcm;
  }


}






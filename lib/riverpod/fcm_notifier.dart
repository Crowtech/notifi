import 'dart:ui';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notifi/api_utils.dart';
import 'package:notifi/jwt_utils.dart';
import 'package:notifi/state/nest_auth2.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:logger/logger.dart' as logger;
import 'package:latlong2/latlong.dart';

part 'fcm_notifier.g.dart';

var log = logger.Logger(
  printer: logger.PrettyPrinter(),
  level: logger.Level.info,
);

var logNoStack = logger.Logger(
  printer: logger.PrettyPrinter(methodCount: 0),
  level: logger.Level.info,
);

@Riverpod(keepAlive: true)
class FcmNotifier extends _$FcmNotifier {
  @override
  String  build() {
    return "NOT_READY";
  }

  void setFcm(String fcm) {
      logNoStack.i("FCM_NOTIFIER: Setting fcm : $fcm}");
   //   ref.read(sendFcmProvider(fcm));
    state = fcm;
   // 
  }


}


@Riverpod(keepAlive: true)
void sendFcm(Ref ref, String fcm) async {

  var fcm = ref.watch(fcmNotifierProvider);
    String? token = ref.read(nestAuthProvider.notifier).token;
    if (token == null) {
      return;
    }
    logNoStack.i("SEND_FCM: Sending fcm to api : $fcm}");
    String devicecode = await fetchDeviceId();
    //Locale locale = (Locale)null;
    Map result = await registerFCM( token, devicecode, fcm);
    logNoStack.i("SEND_FCM: result = $result");
  }


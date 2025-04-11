
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:logger/logger.dart' as logger;

part 'deviceid_notifier.g.dart';

var log = logger.Logger(
  printer: logger.PrettyPrinter(),
  level: logger.Level.info,
);

var logNoStack = logger.Logger(
  printer: logger.PrettyPrinter(methodCount: 0),
  level: logger.Level.info,
);

@Riverpod(keepAlive: true)
class DeviceIdNotifier extends _$DeviceIdNotifier {
  @override
  String  build() {
    return "NOT_READY";
  }

  void setDeviceId(String deviceId) {
      logNoStack.i("DEVICE_ID_NOTIFIER: Setting fcm : $deviceId}");
   //   ref.read(sendFcmProvider(fcm));
    state = deviceId;
   // 
  }


}


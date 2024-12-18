library notifi;

import 'package:app_set_id/app_set_id.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:package_info_plus/package_info_plus.dart';

var logger = Logger(
  printer: PrettyPrinter(),
);

class Nest extends ChangeNotifier {
  final _appSetIdPlugin = AppSetId();

  int _count = 0;
  late String _deviceId;
  late PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
    installerStore: 'Unknown',
  );

  int get count => _count;
  String get deviceId => _deviceId;
  PackageInfo get packageInfo => _packageInfo;

  set deviceId(String newDeviceId) {
    _deviceId = newDeviceId;
    notifyListeners();
  }

  void increment() {
    _count++;
    notifyListeners();
  }

  Nest() {
    logger.d("Starting");
  }

  Future<void> init() async {
    await _initPackageInfo();
    await _initDeviceId();
    notifyListeners();
  }

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    _packageInfo = info;
  }

  Future<void> _initDeviceId() async {
    String deviceId;
    try {
      deviceId = await _appSetIdPlugin.getIdentifier() ?? "Unknown";
    } on PlatformException {
      deviceId = 'Failed to get identifier.';
    }

    //if (!mounted) return;

    _deviceId = deviceId;
  }
}

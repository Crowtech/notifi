import 'dart:ui';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notifi/api_utils.dart';
import 'package:notifi/jwt_utils.dart';
import 'package:notifi/state/nest_auth2.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:logger/logger.dart' as logger;
import 'package:latlong2/latlong.dart';

part 'package_info_notifier.g.dart';

var log = logger.Logger(
  printer: logger.PrettyPrinter(),
  level: logger.Level.info,
);

var logNoStack = logger.Logger(
  printer: logger.PrettyPrinter(methodCount: 0),
  level: logger.Level.info,
);

@Riverpod(keepAlive: true)
Future<PackageInfo> packageInfo(Ref ref) async {
  return await fetchPackageInfo();
}

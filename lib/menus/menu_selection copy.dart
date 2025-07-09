import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart' as logger;

var log = logger.Logger(
  printer: logger.PrettyPrinter(),
  level: logger.Level.info,
);

var logNoStack = logger.Logger(
  printer: logger.PrettyPrinter(methodCount: 0),
  level: logger.Level.info,
);


class MenuIndex extends StateNotifier<String> {
  MenuIndex() : super("");
  set value(String index) => state = index;
  
  void update(String Function(dynamic state) param0) {}
}

final menuIndexProvider = StateNotifierProvider((ref) => MenuIndex());


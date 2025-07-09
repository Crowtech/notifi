import 'package:flutter/services.dart';
import 'package:logger/logger.dart' as logger;

var log = logger.Logger(
  printer: logger.PrettyPrinter(),
  level: logger.Level.info,
);

var logNoStack = logger.Logger(
  printer: logger.PrettyPrinter(methodCount: 0),
  level: logger.Level.info,
);


String TOPIC_REGEX = r"^[\p{L} ,.'-0-9\\ \\:\\(\\)\\!\\@\\&\\\\_\\.]*$";

List<TextInputFormatter> topicInputFormatter = [FilteringTextInputFormatter.allow(RegExp("[a-zA-Z0-9+\\+\\@\\\\_\\ \\.\\&\\-\\(\\)\\!\\@\\\\_\\.]"))];

bool validateSubject(String? topic) {
    if (topic == null) {
      return false;
    }
    return RegExp(
      TOPIC_REGEX,
      caseSensitive: false,
      unicode: true,
      dotAll: true,
    ).hasMatch(topic);
  }

  
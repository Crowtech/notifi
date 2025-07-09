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


String MESSAGE_REGEX = r"^[\p{L} ,.'-0-9\\ \\:\\(\\)\\!\\@\\&\\\\_\\.]*$";

List<TextInputFormatter> messageInputFormatter = [FilteringTextInputFormatter.allow(RegExp("[a-zA-Z0-9+\\+\\@\\\\_\\ \\.\\&\\-\\(\\)\\!\\@\\\\_\\.]"))];

bool validateMessage(String? message) {
    if (message == null) {
      return false;
    }
    return RegExp(
      MESSAGE_REGEX,
      caseSensitive: false,
      unicode: true,
      dotAll: true,
    ).hasMatch(message);
  }

  
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


String NAME_REGEX = r"^[\p{L} ,.'-0-9\\-\\ \\:\\(\\)\\!\\@\\&\\\\_\\.]*$";

List<TextInputFormatter> nameInputFormatter = [FilteringTextInputFormatter.allow(RegExp("[a-zA-Z0-9+\\+\\@\\\\_\\ \\.\\&\\-\\(\\)\\!\\@\\\\_\\.]"))];

bool validateName(String? name) {
    if (name == null) {
      return false;
    }
    return RegExp(
      NAME_REGEX,
      caseSensitive: false,
      unicode: true,
      dotAll: true,
    ).hasMatch(name);
  }

  
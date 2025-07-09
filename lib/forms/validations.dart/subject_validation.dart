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


String SUBJECT_REGEX = r"^[\p{L} ,.'-0-9\\ \\:\\(\\)\\!\\@\\&\\\\_\\.]*$";

List<TextInputFormatter> subjectInputFormatter = [FilteringTextInputFormatter.allow(RegExp("[a-zA-Z0-9+\\+\\@\\\\_\\ \\.\\&\\-\\(\\)\\!\\@\\\\_\\.]"))];

bool validateSubject(String? subject) {
    if (subject == null) {
      return false;
    }
    return RegExp(
      SUBJECT_REGEX,
      caseSensitive: false,
      unicode: true,
      dotAll: true,
    ).hasMatch(subject);
  }

  
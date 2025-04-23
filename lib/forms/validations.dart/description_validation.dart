import 'package:flutter/services.dart';
import 'package:logger/logger.dart' as logger;
import 'package:notifi/helpers/text_formatter.dart';

var log = logger.Logger(
  printer: logger.PrettyPrinter(),
  level: logger.Level.info,
);

var logNoStack = logger.Logger(
  printer: logger.PrettyPrinter(methodCount: 0),
  level: logger.Level.info,
);


String DESCRIPTION_REGEX = r"^[\p{L} ,.'-0-9]*$";

List<TextInputFormatter> descriptionInputFormatter = [];


bool validateDescription(String? description) {

if (description == null) {
  return true; // allow null for description
}
    return RegExp(
      DESCRIPTION_REGEX,
      caseSensitive: false,
      unicode: true,
      dotAll: true,
    ).hasMatch(description!);
  }

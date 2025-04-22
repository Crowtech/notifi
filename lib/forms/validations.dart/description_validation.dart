import 'package:logger/logger.dart' as logger;

var log = logger.Logger(
  printer: logger.PrettyPrinter(),
  level: logger.Level.info,
);

var logNoStack = logger.Logger(
  printer: logger.PrettyPrinter(methodCount: 0),
  level: logger.Level.info,
);


String DESCRIPTION_REGEX = r"^[\p{L} ,.'-0-9]*$";

bool validateDescription(String? description) {

    return RegExp(
      DESCRIPTION_REGEX,
      caseSensitive: false,
      unicode: true,
      dotAll: true,
    ).hasMatch(description!);
  }

  
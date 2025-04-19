import 'package:email_validator/email_validator.dart' as emailValidator;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notifi/api_utils.dart';
import 'package:notifi/credentials.dart';
import 'package:notifi/state/nest_auth2.dart';
import 'package:notifi/i18n/strings.g.dart' as nt;
import 'package:logger/logger.dart' as logger;
import 'package:status_alert/status_alert.dart';

var log = logger.Logger(
  printer: logger.PrettyPrinter(),
  level: logger.Level.info,
);

var logNoStack = logger.Logger(
  printer: logger.PrettyPrinter(methodCount: 0),
  level: logger.Level.info,
);


String NAME_REGEX = r"^[\p{L} ,.'-0-9]*$";

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

  
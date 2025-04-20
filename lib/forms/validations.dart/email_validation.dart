import 'package:email_validator/email_validator.dart' as emailValidator;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notifi/api_utils.dart';
import 'package:notifi/credentials.dart';
import 'package:notifi/helpers/text_formatter.dart';
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


String EMAIL_REGEX = r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$";

List<TextInputFormatter> emailInputFormatter = [LowerCaseTextFormatter(),FilteringTextInputFormatter.allow(RegExp("[a-zA-Z0-9+\\+\\@\\\\_.]"))];



bool validateEmail(String? email) {
    if (email == null) {
      return false;
    }
    return emailValidator.EmailValidator.validate(email);
  }

  Future<bool> validateEmailAsync(WidgetRef ref,BuildContext context,String? email) async {
    if (email == null) {
      return false;
    }
    if (email.isEmpty) {
      return true;
    }
    if (RegExp(
      EMAIL_REGEX,
      caseSensitive: false,
      unicode: true,
      dotAll: true,
    ).hasMatch(email)) {
      // check if url exists
      var token = ref.read(nestAuthProvider.notifier).token;
      var apiPath =
          "$defaultAPIBaseUrl$defaultApiPrefixPath/persons/check/email/";
      apiPath = "$apiPath${Uri.encodeComponent(email)}";
      var response = await apiGetData(token!, apiPath, "application/json");
      if (!response.body.contains("true")) {
        StatusAlert.show(
          context,
          duration: const Duration(seconds: 3),
          title: nt.t.person,
          subtitle: nt.t.form.already_exists(
              item: nt.t.person_capitalized, field: nt.t.form.url),
          configuration: const IconConfiguration(icon: Icons.error),
          maxWidth: 260,
        );
      }
      return response.body.contains("true");
    }
    return false;
  }
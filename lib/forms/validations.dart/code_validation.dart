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

String CODE_REGEX =  r"^[A-Z]3\\_[A-Z0-9\\_]*$";

List<TextInputFormatter> codeInputFormatter = [UpperCaseTextFormatter(),FilteringTextInputFormatter.allow(RegExp(CODE_REGEX))];

bool validateCode(String? code) {
    if (code == null || code.isEmpty) {
      return false;
    }
    return RegExp(
      CODE_REGEX,
      caseSensitive: false,
      unicode: true,
      dotAll: true,
    ).hasMatch(code);
  }


Future<bool> validateCodesync(WidgetRef ref,BuildContext context,String? code) async {
    if (code == null) {
      return false;
    }
    if (code.isEmpty) {
      return true;
    }
    if (RegExp(
     CODE_REGEX,
      caseSensitive: false,
      unicode: true,
      dotAll: true,
    ).hasMatch(code)) {
      // check if url exists
      var token = ref.read(nestAuthProvider.notifier).token;
      var apiPath =
          "$defaultAPIBaseUrl$defaultApiPrefixPath/resources/check/code/";
      apiPath = "$apiPath${Uri.encodeComponent(code)}";
      logNoStack.i("CODE_FORM: encodedApiPath is $apiPath");
      var response = await apiGetData(token!, apiPath, "application/json");
      logNoStack.i("CODE_FORM: result ${response.body.toString()}");
      if (!response.body.contains("true")) {
        StatusAlert.show(
          context,
          duration: const Duration(seconds: 3),
          title: nt.t.template,
          subtitle: nt.t.form.already_exists(
              item: nt.t.template_capitalized, field: nt.t.form.code),
          configuration: const IconConfiguration(icon: Icons.error),
          maxWidth: 260,
        );
      }
      return response.body.contains("true");
    }
    return false;
  }
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

String URL_REGEX =  r"^https?:\/\/(?:www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b(?:[-a-zA-Z0-9()@:%_\+.~#?&\/=]*)$";

List<TextInputFormatter> urlInputFormatter = [LowerCaseTextFormatter(),FilteringTextInputFormatter.allow(RegExp(URL_REGEX))];

Future<bool> validateUrlAsync(WidgetRef ref,BuildContext context,String? url) async {
    if (url == null) {
      return false;
    }
    if (url.isEmpty) {
      return true;
    }
    if (RegExp(
     URL_REGEX,
      caseSensitive: false,
      unicode: true,
      dotAll: true,
    ).hasMatch(url)) {
      // check if url exists
      var token = ref.read(nestAuthProvider.notifier).token;
      var apiPath =
          "$defaultAPIBaseUrl$defaultApiPrefixPath/resources/check/url/";
      apiPath = "$apiPath${Uri.encodeComponent(url)}";
      logNoStack.i("ORG_FORM: encodedApiPath is ${apiPath}");
      var response = await apiGetData(token!, apiPath, "application/json");
      logNoStack.i("ORG_FORM: result ${response.body.toString()}");
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
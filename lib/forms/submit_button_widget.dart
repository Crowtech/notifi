import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notifi/i18n/strings.g.dart' as nt;
import 'package:logger/logger.dart' as logger;
import 'package:notifi/riverpod/refresh_widget.dart';

var log = logger.Logger(
  printer: logger.PrettyPrinter(),
  level: logger.Level.info,
);

var logNoStack = logger.Logger(
  printer: logger.PrettyPrinter(methodCount: 0),
  level: logger.Level.info,
);

// ignore: must_be_immutable
class SubmitButtonWidget extends StatelessWidget {
  SubmitButtonWidget(
      {super.key, required this.formKey, required this.formCode});

  GlobalKey<FormState> formKey;
  String formCode;

  @override
  Widget build(BuildContext context /*, WidgetRef ref*/) {
    //ref.watch(refreshWidgetProvider("$formCode-submit"));
    logNoStack.i("Submit button $formCode ");
    return ElevatedButton(
      key: Key("$formCode-submit"),
      onPressed:
          !(formKey.currentState != null && formKey.currentState!.validate())
              ? null
              : () {
                  // If the form is valid, display a snackbar. In the real world,
                  // you'd often call a server or save the information in a database.
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(nt.t.saving),
                    ),
                  );
                  Navigator.of(context).pop();
                },
      child: Text(nt.t.response.submit),
    );
  }
}

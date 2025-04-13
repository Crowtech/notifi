import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notifi/i18n/strings.g.dart' as nt;
import 'package:logger/logger.dart' as logger;

var log = logger.Logger(
  printer: logger.PrettyPrinter(),
  level: logger.Level.info,
);

var logNoStack = logger.Logger(
  printer: logger.PrettyPrinter(methodCount: 0),
  level: logger.Level.info,
);

// ignore: must_be_immutable
class CancelButtonWidget extends ConsumerWidget {
  CancelButtonWidget({super.key,required this.formKey,required this.formCode});

GlobalKey<FormState> formKey;
  String formCode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
   // ref.watch(refreshWidgetProvider("$formCode-cancel"));
    
    return TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(nt.t.response.cancel),
                    );
                    
  }
}
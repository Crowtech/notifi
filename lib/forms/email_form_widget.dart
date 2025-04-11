import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_regex/flutter_regex.dart';
import 'package:notifi/helpers/debouncer.dart';
import 'package:notifi/i18n/strings.g.dart' as nt;
import 'package:logger/logger.dart' as logger;
import 'package:notifi/models/organization_type.dart';

var log = logger.Logger(
  printer: logger.PrettyPrinter(),
  level: logger.Level.info,
);

var logNoStack = logger.Logger(
  printer: logger.PrettyPrinter(methodCount: 0),
  level: logger.Level.info,
);

class EmailTextFormFieldWidget extends StatefulWidget {
  const EmailTextFormFieldWidget({super.key,required this.itemCategory});

  final String itemCategory;

  @override
  State<EmailTextFormFieldWidget> createState() =>
      _EmailTextFormFieldWidgetState();
}

class _EmailTextFormFieldWidgetState
    extends State<EmailTextFormFieldWidget> {
  final GlobalKey<FormFieldState> emailFormFieldKey =
      GlobalKey<FormFieldState>();
  final Debouncer _debouncer = Debouncer(milliseconds: 500);
  String? _olderEmailValue;

  @override
  void dispose() {
    _debouncer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: emailFormFieldKey,
      decoration:  InputDecoration(
        labelText: nt.t.email,
      ),
      validator: (value) {
        String? result =
            (!_isEmptyOlderValue(_olderEmailValue)) && value!.isEmpty
                ? null
                : !isValidEmail(value)
                    ? nt.t.form.email_validation(item: widget.itemCategory )
                    : null;
        _olderEmailValue = _isEmptyValue(value) ? value : _olderEmailValue;
        return result;
      },
      onChanged: (value) => _debouncer.run(() {
        _olderEmailValue = value.isEmpty ? _olderEmailValue : value;
        emailFormFieldKey.currentState?.validate();
      }),
    );
  }

  bool isValidEmail(String? email) {
    if (email == null) {
      return false;
    }
    return EmailValidator.validate(email);
  }

  bool _isEmptyOlderValue(String? value) {
    return value == null || value.isEmpty;
  }

  bool _isEmptyValue(String? value) {
    return value == null || value.isEmpty;
  }
}
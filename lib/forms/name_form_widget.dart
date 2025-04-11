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

class NameTextFormFieldWidget extends StatefulWidget {
  const NameTextFormFieldWidget({super.key,required this.itemCategory});

  final String itemCategory;

  @override
  State<NameTextFormFieldWidget> createState() =>
      _NameTextFormFieldWidgetState();
}

class _NameTextFormFieldWidgetState
    extends State<NameTextFormFieldWidget> {
  final GlobalKey<FormFieldState> nameFormFieldKey =
      GlobalKey<FormFieldState>();
  final Debouncer _debouncer = Debouncer(milliseconds: 500);
  String? _olderValue;

  @override
  void dispose() {
    _debouncer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: nameFormFieldKey,
      decoration: InputDecoration(
        labelText: nt.t.name,
      ),
      validator: (value) {
        String? result =
            (!_isEmptyOlderValue(_olderValue)) && value!.isEmpty
                ? null
                : !isValidEmail(value)
                    ? nt.t.form.email_validation(item: widget.itemCategory )
                    : null;
        _olderValue = _isEmptyValue(value) ? value : _olderValue;
        return result;
      },
      onChanged: (value) => _debouncer.run(() {
        _olderValue = value.isEmpty ? _olderValue : value;
        nameFormFieldKey.currentState?.validate();
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
import 'package:flutter/material.dart';
import 'package:logger/logger.dart' as logger;
import 'package:notifi/helpers/debouncer.dart';

var log = logger.Logger(
  printer: logger.PrettyPrinter(),
  level: logger.Level.info,
);

var logNoStack = logger.Logger(
  printer: logger.PrettyPrinter(methodCount: 0),
  level: logger.Level.info,
);

class TextFormFieldWidget extends StatefulWidget {
  const TextFormFieldWidget({super.key,required this.itemCategory, required this.itemName, required this.itemValidation, required this.regex});
  
  final String itemCategory;
  final String itemName;
  final String itemValidation;
  final String regex;

  @override
  State<TextFormFieldWidget> createState() =>
      _TextFormFieldWidgetState();
}

class _TextFormFieldWidgetState
    extends State<TextFormFieldWidget> {
  final GlobalKey<FormFieldState> itemFormFieldKey =
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
      key: itemFormFieldKey,
      decoration: InputDecoration(
        labelText: widget.itemName,
      ),
      validator: (value) {
        String? result =
            (!_isEmptyOlderValue(_olderValue)) && value!.isEmpty
                ? null
                : !isValid(value)
                    ? widget.itemValidation
                    : null;
        _olderValue = _isEmptyValue(value) ? value : _olderValue;
        return result;
      },
      onChanged: (value) => _debouncer.run(() {
        _olderValue = value.isEmpty ? _olderValue : value;
        itemFormFieldKey.currentState?.validate();
      }),
    );
  }

  bool isValid(String? value) {
    if (value == null) {
      return false;
    }
    return RegExp(widget.regex,caseSensitive: false, unicode: true, dotAll: true)
  .hasMatch(value);
  }

  bool _isEmptyOlderValue(String? value) {
    return value == null || value.isEmpty;
  }

  bool _isEmptyValue(String? value) {
    return value == null || value.isEmpty;
  }
}
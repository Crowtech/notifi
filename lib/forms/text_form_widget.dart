import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart' as logger;
import 'package:notifi/helpers/debouncer.dart';
import 'package:notifi/helpers/text_formatter.dart';
import 'package:notifi/riverpod/enable_widget.dart';

var log = logger.Logger(
  printer: logger.PrettyPrinter(),
  level: logger.Level.info,
);

var logNoStack = logger.Logger(
  printer: logger.PrettyPrinter(methodCount: 0),
  level: logger.Level.info,
);

typedef ValidateFunction<String> = bool Function(String value);

class TextFormFieldWidget extends ConsumerStatefulWidget {
  const TextFormFieldWidget({super.key,
  required this.fieldCode,
  this.enabled = true,
  required this.itemCategory, 
  required this.itemName, 
  required this.itemValidation, 
  required this.regex,
  this.optional = false,
  this.forceLowercase = false,
  this.forceUppercase = false,  
  this.textCapitalization = TextCapitalization.none,
  this.onValidate,
  });
  
  final String fieldCode;
  final bool enabled;
  final String itemCategory;
  final String itemName;
  final String itemValidation;
  final bool optional;
  final String regex;
  final bool forceLowercase;
  final bool forceUppercase;
  final TextCapitalization textCapitalization;
  final ValidateFunction<String>? onValidate;


  @override
  ConsumerState<TextFormFieldWidget> createState() =>
      _TextFormFieldWidgetState();
}



class _TextFormFieldWidgetState
    extends ConsumerState<TextFormFieldWidget> {
  final GlobalKey<FormFieldState> itemFormFieldKey =
      GlobalKey<FormFieldState>();
  final Debouncer _debouncer = Debouncer(milliseconds: 500);
  String? _olderValue;
  List<TextInputFormatter>? inputFormatters = [];

  @override
  void initState() {
    super.initState();
    if (widget.forceLowercase) { // should be enum
      inputFormatters = [LowerCaseTextFormatter()];
    } else if (widget.forceUppercase) { // should be enum
      inputFormatters = [UpperCaseTextFormatter()];
    }
     ref.watch(enableWidgetProvider(widget.fieldCode).notifier).setEnabled(widget.enabled);
  }

  @override
  void dispose() {
    _debouncer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var enableWidget = ref.watch(enableWidgetProvider(widget.fieldCode));
    return TextFormField(
      key: itemFormFieldKey,
      enabled: enableWidget,
      inputFormatters: [...inputFormatters!],
      textCapitalization: widget.textCapitalization,
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
    if (widget.optional) {
      return true;
    }
    if (value == null) {
      return false;
    }
    if (widget.onValidate != null) {
      return widget.onValidate!(value);
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
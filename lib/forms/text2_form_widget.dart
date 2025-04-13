import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import 'package:logger/logger.dart' as logger;
import 'package:notifi/i18n/strings.g.dart' as nt;
import 'package:notifi/helpers/debouncer.dart';
import 'package:notifi/helpers/text_formatter.dart';
import 'package:notifi/riverpod/enable_widget.dart';
import 'package:notifi/riverpod/refresh_widget.dart';

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
  const TextFormFieldWidget({
    super.key,
    required this.formKey,
    required this.formCode,
    required this.fieldCode,
    this.initialValue = "",
    this.enabled = true,
    this.readOnly = false,
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

  final GlobalKey<FormState> formKey;
  final String formCode;
  final String fieldCode;
  final String initialValue;
  final bool readOnly;
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

class _TextFormFieldWidgetState extends ConsumerState<TextFormFieldWidget> {
  final GlobalKey<FormFieldState> itemFormFieldKey =
      GlobalKey<FormFieldState>();
  final Debouncer _debouncer = Debouncer(milliseconds: 500);
  String? _olderValue;
  bool isValid = false;
  bool isEmpty = true;
  late bool enableWidget;
  List<TextInputFormatter>? inputFormatters = [];

  @override
  void initState() {
    super.initState();
    if (widget.forceLowercase) {
      // should be enum
      inputFormatters = [LowerCaseTextFormatter()];
    } else if (widget.forceUppercase) {
      // should be enum
      inputFormatters = [UpperCaseTextFormatter()];
    }
    isEmpty = widget.initialValue.isEmpty;
    enableWidget = widget.enabled;
    // ref.read(enableWidgetProvider(widget.fieldCode).notifier).setEnabled(widget.enabled);
  }

  Color statusColor() {
    logNoStack.i(
      "StatusColor: ${widget.fieldCode} enabled:$enableWidget isValid:$isValid isEmpty:$isEmpty optional:${widget.optional}",
    );
    if (enableWidget == false) {
      return Colors.grey;
    } else if (isEmpty && widget.optional) {
      return Colors.green;
    } else if (isEmpty) {
      return Colors.black;
    } else if (!isEmpty && isValid) {
      return Colors.green;
    } else {
      return Colors.red;
    }
  }

  TextInputType textInputType() {
    if (widget.fieldCode.contains("email")) {
      return TextInputType.emailAddress;
    } else if (widget.fieldCode.contains("url")) {
      return TextInputType.url;
    } else if (widget.fieldCode.contains("name")) {
      return TextInputType.name;
    } else if (widget.fieldCode.contains("number")) {
      return TextInputType.number;
    } else {
      return TextInputType.text;
    }
  }

  @override
  void dispose() {
    _debouncer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    enableWidget = ref.watch(enableWidgetProvider(widget.fieldCode));
    ref.watch(refreshWidgetProvider(widget.fieldCode));

    logNoStack.i(
        "TEXT_FORM_WIDGET: BUILD: ${widget.fieldCode} enableWidget:$enableWidget");
    return TextFormField(
     decoration: InputDecoration(labelText: widget.itemName),
    keyboardType: textInputType(),
    autovalidateMode: AutovalidateMode.always,
    validator: FormBuilderValidators.compose([
        /// Makes this field required
        FormBuilderValidators.required(),

        /// Ensures the value entered is numeric - with a custom error message
        FormBuilderValidators.numeric(errorText: widget.itemValidation),

        /// Sets a maximum value of 70
        //FormBuilderValidators.max(70),

        /// Include your own custom `FormFieldValidator` function, if you want
        /// Ensures positive values only. We could also have used `FormBuilderValidators.min(0)` instead
        (val) {
            // final number = int.tryParse(val);
            // if (number == null) return null;
            // if (number < 0) return 'We cannot have a negative age';
            // return null;
        },
    ]),
);
  }

  bool isValidInput(String? value) {
    if (!enableWidget) {
      isValid = true;
    } else if (value == null || value.isEmpty) {
      if (!widget.optional) {
        isValid = false;
      } else {
        isValid = true;
      }
    } else if (widget.onValidate != null) {
      logNoStack.i(
        "Checking validation using onValidate ${widget.onValidate!(value) ? 'GOOD' : 'BAD'}",
      );
      isValid = widget.onValidate!(value);
    } else {
      isValid = RegExp(
        widget.regex,
        caseSensitive: false,
        unicode: true,
        dotAll: true,
      ).hasMatch(value);
    }
    logNoStack.i(
      "Checking validation for enabled:$enableWidget ${widget.fieldCode} $value optional:${widget.optional} isValid:$isValid",
    );

    return isValid;
  }

  bool _isEmptyOlderValue(String? value) {
    return value == null || value.isEmpty;
  }

  bool _isEmptyValue(String? value) {
    return value == null || value.isEmpty;
  }
}

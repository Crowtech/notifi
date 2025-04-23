import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart' as logger;
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

class CheckboxFormFieldWidget extends ConsumerStatefulWidget {
  CheckboxFormFieldWidget({
    super.key,
    required this.fieldValues,
    this.isValidatingMessage,
    this.valueIsEmptyMessage = 'please enter a value',
    this.valueIsInvalidMessage = 'please enter a valid value',
    this.valueIsExisting,
    this.hintText = '',
    required this.formCode,
    required this.fieldCode,
    required this.initialValue,
    this.readOnly = false,
    this.enabled = true,
    required this.itemCategory,
    required this.itemName,
    this.itemExists = false,
    this.optional = false,
  });

  //Future<bool> Function(String) validator;
  final Map<String, dynamic> fieldValues;
  String hintText;
  String? isValidatingMessage;
  String valueIsEmptyMessage;
  String valueIsInvalidMessage;
  String? valueIsExisting;
  final String formCode;
  final String fieldCode;
  bool? initialValue;
  bool readOnly;
  bool enabled;
  final String itemCategory;
  final String itemName;
  bool itemExists;

  bool optional;

  @override
  ConsumerState<CheckboxFormFieldWidget> createState() =>
      _CheckboxFormFieldWidgetState();
}

class _CheckboxFormFieldWidgetState
    extends ConsumerState<CheckboxFormFieldWidget> {
  final GlobalKey<FormFieldState> itemFormFieldKey =
      GlobalKey<FormFieldState>();

  var isValidating = false;
  var isValid = false;
  var isExisting = false;
  var isDirty = false;
  var isWaiting = false;

  bool isEmpty = true;
  late bool enableWidget;
  bool initialValid = false;
  late String pureFieldCode;
  bool? checkedValue;

  @override
  void initState() {
    super.initState();
    pureFieldCode =
        widget.fieldCode.substring(widget.fieldCode.indexOf('-') + 1);

    isEmpty = widget.initialValue == null;
    enableWidget = widget.enabled;
    checkedValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    enableWidget = ref.watch(enableWidgetProvider(widget.fieldCode));
    ref.watch(refreshWidgetProvider(widget.fieldCode));

    logNoStack.i(
        "CHECKBOX_FORM_WIDGET: BUILD: ${widget.fieldCode} enableWidget:$enableWidget");

    return CheckboxListTile(
      enabled: enableWidget,
      title: Text(widget.itemName),
      value: checkedValue,
      onChanged: (newValue) {
        setState(() {
          checkedValue = newValue;
          widget.fieldValues[pureFieldCode] = newValue;
        });
      },
      controlAffinity: ListTileControlAffinity.leading, //  <-- leading Checkbox
    );
  }
}

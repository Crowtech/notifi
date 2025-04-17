import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart' as logger;
import 'package:notifi/i18n/strings.g.dart' as nt;
import 'package:notifi/helpers/debouncer.dart';
import 'package:notifi/helpers/text_formatter.dart';
import 'package:notifi/riverpod/enable_widget.dart';
import 'package:notifi/riverpod/refresh_widget.dart';
import 'package:notifi/riverpod/validate_form.dart';

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
    required this.fieldValues,
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

  final Map<String,dynamic> fieldValues;
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
  bool initialValid = false;

  @override
  Future<void> initState() async {
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
    initialValid = isValidInput(widget.initialValue);
    await Future<void>.delayed(const Duration(milliseconds: 500));
   ref.read(validateFormProvider(widget.formCode).notifier).add(widget.fieldCode, initialValid);
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

  @override
  void dispose() {
    _debouncer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
     
    enableWidget = ref.watch(enableWidgetProvider(widget.fieldCode)); 
    ref.watch(refreshWidgetProvider(widget.fieldCode));

    logNoStack.i("TEXT_FORM_WIDGET: BUILD: ${widget.fieldCode} enableWidget:$enableWidget");
    return TextFormField(
      key: itemFormFieldKey,
      //controller: widget.textController,
      initialValue: widget.initialValue,
      autocorrect: true,
      readOnly: widget.readOnly,
      enabled: enableWidget,
      inputFormatters: [...inputFormatters!],
      textCapitalization: widget.textCapitalization,
      decoration: InputDecoration(
        errorStyle: const TextStyle(color: Colors.red),
        labelText: widget.optional ? "${widget.itemName} (${nt.t.optional})" : widget.itemName,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: statusColor(), width: 3.0),
          borderRadius: BorderRadius.circular(10.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: statusColor(),
            width: isValid ? 2.0 : 1.0,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),

        disabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey, width: 1.0),
          borderRadius: BorderRadius.circular(10.0),
        ),

        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 3.0),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      validator: (value) {
        String? result =
            (!_isEmptyOlderValue(_olderValue)) && value!.isEmpty
                ? null
                : !isValidInput(value)
                ? widget.itemValidation
                : null;
        _olderValue = _isEmptyValue(value) ? value : _olderValue;
        isEmpty = _isEmptyValue(value);
        String fieldCode = widget.fieldCode.substring(widget.fieldCode.indexOf('-') + 1); // remove the true/false-
        widget.fieldValues[fieldCode] = value;
        ref.read(validateFormProvider(widget.formCode).notifier).add(fieldCode, isValid);
        return result;
      },
      onChanged:
          (value) => _debouncer.run(() {
            _olderValue = value.isEmpty ? _olderValue : value;
            itemFormFieldKey.currentState?.validate();
            //ref.read(refreshWidgetProvider("organization").notifier).refresh();
            //ref.read(refreshWidgetProvider(widget.fieldCode).notifier).refresh();
            //ref.read(refreshWidgetProvider("${widget.formCode}-submit").notifier).refresh();
          }),
      onFieldSubmitted: (value) {
        isValidInput(value);
        
      },
    );
  }

  bool isValidInput(String? value) {
    if (!enableWidget) {
      isValid = true;
    }
    else if (value == null || value.isEmpty) {
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

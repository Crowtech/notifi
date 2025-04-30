import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart' as logger;
import 'package:notifi/api_utils.dart';
import 'package:notifi/credentials.dart';
import 'package:notifi/riverpod/enable_widget.dart';
import 'package:notifi/riverpod/refresh_widget.dart';
import 'package:notifi/riverpod/validate_form.dart';
import 'package:notifi/state/nest_auth2.dart';

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
  TextFormFieldWidget({
    super.key,
    required this.fieldValues,
    //required this.validator,
    this.validationDebounce = const Duration(milliseconds: 500),
    required this.controller,
    this.isValidatingMessage,
    this.valueIsEmptyMessage = 'please enter a value',
    this.valueIsInvalidMessage = 'please enter a valid value',
    this.valueIsExisting,
    this.hintText = '',
    required this.formCode,
    required this.fieldCode,
    this.initialValue = "",
    this.readOnly = false,
    this.enabled = true,
    required this.itemCategory,
    required this.itemName,
    required this.itemValidation,
    this.itemExists = false,
    this.optional = false,
    this.regex = r"^[\p{L} ,.'-0-9]*$",
    this.textCapitalization = TextCapitalization.none,
    this.onValidate,
    this.inputFormatters = const [],
  });

  //Future<bool> Function(String) validator;
  final Map<String, dynamic> fieldValues;
  Duration validationDebounce;
  final TextEditingController controller;
  String hintText;
  String? isValidatingMessage;
  String valueIsEmptyMessage;
  String valueIsInvalidMessage;
  String? valueIsExisting;
  final String formCode;
  final String fieldCode;
  String initialValue;
  bool readOnly;
  bool enabled;
  final String itemCategory;
  final String itemName;
  final String itemValidation;
  bool itemExists;

  bool optional;
  String regex;
  TextCapitalization textCapitalization;
  ValidateFunction<String>? onValidate;

  List<TextInputFormatter> inputFormatters;

  @override
  ConsumerState<TextFormFieldWidget> createState() =>
      _TextFormFieldWidgetState();
}

class _TextFormFieldWidgetState extends ConsumerState<TextFormFieldWidget> {
  final GlobalKey<FormFieldState> itemFormFieldKey =
      GlobalKey<FormFieldState>();

  Timer? _debounce;
  var isValidating = false;
  var isValid = false;
  var isExisting = false;
  var isDirty = false;
  var isWaiting = false;

  bool isEmpty = true;
  late bool enableWidget;
  bool initialValid = false;
  late List<TextInputFormatter>? inputFormatters;
  late String pureFieldCode;

  @override
  void initState() {
    super.initState();
    pureFieldCode =
        widget.fieldCode.substring(widget.fieldCode.indexOf('-') + 1);
    inputFormatters = widget.inputFormatters;

    isEmpty = widget.initialValue.isEmpty;
    enableWidget = widget.enabled;
    //initialValid = isValidInput(widget.initialValue);
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

  Future<bool> validate(String value) async {
    var isValid = isValidInput(value);
    isExisting = false;

    if (isValid && (widget.isValidatingMessage != null)) {
      setState(() {
        isValidating = true;
        isExisting = false;
      });
      var token = ref.read(nestAuthProvider.notifier).token;
      var apiPath =
          "$defaultAPIBaseUrl$defaultApiPrefixPath/${widget.itemName}s/check/$pureFieldCode/";
      apiPath = "$apiPath${Uri.encodeComponent(value)}";
      logNoStack.i("TEXT_FORM_WIDGET: check encodedApiPath is $apiPath");
      var response = await apiGetData(token!, apiPath, "application/json");
      isExisting =
          response.body.contains("true"); // if existing then it returns true
      if (isExisting) {
        isValid = false;

        setState(() {
          isValidating = false;
          isExisting = true;
          isValid = false;
        });
      } else {
        setState(() {
          isValidating = false;
          isExisting = false;
          isValid = true;
        });
      }
    }
    widget.fieldValues[pureFieldCode] = value;
    ref
        .read(validateFormProvider(widget.formCode).notifier)
        .add(pureFieldCode, isValid);
    return isValid;
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    enableWidget = ref.watch(enableWidgetProvider(widget.fieldCode));
    ref.watch(refreshWidgetProvider(widget.fieldCode));

    logNoStack.i(
        "TEXT_FORM_WIDGET: BUILD: ${widget.fieldCode} enableWidget:$enableWidget");
    if (enableWidget == false) {
      isValid = true; // force it.
      widget.controller.text = "";
      widget.fieldValues[pureFieldCode] = "";
      isEmpty = true;
      isWaiting = false;
      isValidating = false;
      isExisting = false;
      isDirty = false;
    }

    return TextFormField(
     // initialValue: widget.initialValue,
     // autocorrect: true,
    //  readOnly: widget.readOnly,
      enabled: enableWidget,
      inputFormatters: inputFormatters,
      textCapitalization: widget.textCapitalization,
      key: itemFormFieldKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (enableWidget == false) {
          return null;
        }
        if (isValidating) {
          return widget.isValidatingMessage;
        }
        if (value?.isEmpty ?? false) {
          return widget.valueIsEmptyMessage;
        }

        if (!isWaiting && !isValid && isExisting) {
          return widget.valueIsExisting;
        }
        if (!isWaiting && !isValid) {
          return widget.valueIsInvalidMessage;
        }
        return null;
      },
      onChanged: (text) async {
        isDirty = true;
        if (text.isEmpty) {
          setState(() {
            isValid = false;
            logNoStack.i('is empty');
          });
          cancelTimer();
          return;
        }
        isWaiting = true;
        cancelTimer();
        _debounce = Timer(widget.validationDebounce, () async {
          isWaiting = false;
          isValid = await validate(text);
          logNoStack.i(isValid);
          setState(() {});
          isValidating = false;
        });
      },
      textAlign: TextAlign.start,
      controller: widget.controller,
      maxLines: 1,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          suffix: SizedBox(height: 20, width: 20, child: _getSuffixIcon()),
          hintText: widget.hintText),
    );

    //   decoration: InputDecoration(
    //     hintText: widget.hintText,
    //     errorStyle: const TextStyle(color: Colors.red),
    //     labelText: widget.optional
    //         ? "${widget.itemName} (${nt.t.optional})"
    //         : widget.itemName,
    //     focusedBorder: OutlineInputBorder(
    //       borderSide: BorderSide(color: statusColor(), width: 3.0),
    //       borderRadius: BorderRadius.circular(10.0),
    //     ),
    //     enabledBorder: OutlineInputBorder(
    //       borderSide: BorderSide(
    //         color: statusColor(),
    //         width: isValid ? 2.0 : 1.0,
    //       ),
    //       borderRadius: BorderRadius.circular(10.0),
    //     ),
    //     disabledBorder: OutlineInputBorder(
    //       borderSide: const BorderSide(color: Colors.grey, width: 1.0),
    //       borderRadius: BorderRadius.circular(10.0),
    //     ),
    //     errorBorder: OutlineInputBorder(
    //       borderSide: const BorderSide(color: Colors.red, width: 3.0),
    //       borderRadius: BorderRadius.circular(10.0),
    //     ),
    //   ),
    //     validator: (value) {
    //     if (isValidating) {
    //       return widget.isValidatingMessage;
    //     }
    //     if (value?.isEmpty ?? false) {
    //       return widget.valueIsEmptyMessage;
    //     }
    //     if (!isWaiting && !isValid) {
    //       return widget.valueIsInvalidMessage;
    //     }
    //     return null;
    //   },
    //   onChanged: (text) async {
    //     isDirty = true;
    //     if (text.isEmpty) {
    //       setState(() {
    //         isValid = false;
    //         print('is empty');
    //       });
    //       cancelTimer();
    //       return;
    //     }
    //     isWaiting = true;
    //     cancelTimer();
    //     _debounce = Timer(widget.validationDebounce, () async {
    //       isWaiting = false;
    //       isValid = await validate(text);
    //       print(isValid);
    //       setState(() {});
    //       isValidating = false;
    //     });
    //   },
    // );
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
      "Checking validation for enabled:$enableWidget ${widget.fieldCode} $value optional:${widget.optional} isValid:$isValid isDirty:$isDirty",
    );

    return isValid;
  }

  void cancelTimer() {
    if (_debounce?.isActive ?? false) {
      _debounce?.cancel();
    }
  }

  Widget _getSuffixIcon() {
    logNoStack.i(
      "Checking validationSuffixIcon for enabled:$enableWidget ${widget.fieldCode} isValid:$isValid isDirty:$isDirty",
    );
    if (isValidating) {
      return const CircularProgressIndicator(
        strokeWidth: 2.0,
        valueColor: AlwaysStoppedAnimation(Colors.blue),
      );
    } else {
      if (!isValid && isDirty) {
        return const Icon(
          Icons.cancel,
          color: Colors.red,
          size: 20,
        );
      } else if (isValid) {
        return const Icon(
          Icons.check_circle,
          color: Colors.green,
          size: 20,
        );
      } else {
        return Container();
      }
    }
  }
}

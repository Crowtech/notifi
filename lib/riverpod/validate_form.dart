import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:logger/logger.dart' as logger;


part 'validate_form.g.dart';

var log = logger.Logger(
  printer: logger.PrettyPrinter(),
  level: logger.Level.info,
);

var logNoStack = logger.Logger(
  printer: logger.PrettyPrinter(methodCount: 0),
  level: logger.Level.info,
);

@Riverpod(keepAlive: true)
class InitialFormValidations extends _$InitialFormValidations {
  Map<String, bool> fields = {};
  @override
  Map<String,bool> build(String code) => {};

  void add(String fieldCode,bool initialFieldValidation) {
    fields[fieldCode] = initialFieldValidation;
    state = fields;
  }

  void clear()
  {
    fields.clear();
    state = fields;
  }
}


@Riverpod(keepAlive: true)
class ValidateForm extends _$ValidateForm {
  Map<String, bool> fields = {};
  @override
  bool build(String code) => false;

  void add(String fieldCode,bool fieldValid) {
    fields[fieldCode] = fieldValid;
    logNoStack.i("VALIDATE_FORM: add $fieldCode $fieldValid");
    bool isValid = true;
    for (var fieldValue in fields.values) {
      isValid = isValid && fieldValue;
    }
    state = isValid;
  }
}

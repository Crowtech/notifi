import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';



part 'enable_widget.g.dart';

@riverpod
class EnableWidget extends _$EnableWidget {
  @override
  bool build(String code) => false;   // enable as false

  void setEnabled(bool enabled) {
    state = enabled;
  }
}

@riverpod
class EnableWidgetTrue extends _$EnableWidgetTrue {
  @override
  bool build(String code) => true;   // enable as false

  void setEnabled(bool enabled) {
    state = enabled;
  }
}

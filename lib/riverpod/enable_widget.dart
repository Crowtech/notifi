import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';



part 'enable_widget.g.dart';

@riverpod
class EnableWidget extends _$EnableWidget {
  @override
  bool build(String code) => false;   // enable as false

  void set(bool enable) {
    state = enable;
  }
}

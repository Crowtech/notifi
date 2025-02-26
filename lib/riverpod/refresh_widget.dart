import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod/riverpod.dart';



part 'refresh_widget.g.dart';

@riverpod
class RefreshWidget extends _$RefreshWidget {
  @override
  bool build(String code) => false;

  void refresh() {
    state = true;
  }
}

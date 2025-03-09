import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';



part 'refresh_widget.g.dart';

@riverpod
class RefreshWidget extends _$RefreshWidget {
  @override
  String build(String code) => const Uuid().v4().toUpperCase();

  void refresh() {
    state = const Uuid().v4().toUpperCase();
  }
}

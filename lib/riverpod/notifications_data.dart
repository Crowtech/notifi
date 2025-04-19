import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';



part 'notifications_data.g.dart';

@riverpod
class NotificationsData extends _$NotificationsData {
  @override
  Map<String, dynamic> build(String code) => {};

  void update(Map<String,dynamic> mapData) {
    state = mapData;
  }
}

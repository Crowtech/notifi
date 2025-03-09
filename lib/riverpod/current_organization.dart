import 'package:notifi/models/organization.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';



part 'current_organization.g.dart';

@riverpod
class CurrentOrganization extends _$CurrentOrganization {
  @override
  Organization build() => defaultOrganization;

  // void refresh() {
  //   state = const Uuid().v4().toUpperCase();
  // }
}

import 'package:notifi/models/organization.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:logger/logger.dart' as logger;

part 'selected_organizations.g.dart';



var log = logger.Logger(
  printer: logger.PrettyPrinter(),
  level: logger.Level.info,
);

var logNoStack = logger.Logger(
  printer: logger.PrettyPrinter(methodCount: 0),
  level: logger.Level.info,
);


@riverpod
class SelectedOrganizations extends _$SelectedOrganizations {
  @override
  List<Organization> build() => [];

  // void refresh() {
  //   state = const Uuid().v4().toUpperCase();
  // }

  void add(Organization organization) {
     logNoStack.i("SELECTED_ORGS: add ${organization.url}");
    state = [...state, organization];
  }



}

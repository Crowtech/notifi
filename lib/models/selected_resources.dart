import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:notifi/api_utils.dart';
import 'package:logger/logger.dart' as logger;
import 'package:notifi/credentials.dart';
import 'package:notifi/state/nest_auth2.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'selected_resources.g.dart';
part 'selected_resources.freezed.dart';


var log = logger.Logger(
  printer: logger.PrettyPrinter(),
  level: logger.Level.info,
);

var logNoStack = logger.Logger(
  printer: logger.PrettyPrinter(methodCount: 0),
  level: logger.Level.info,
);


@freezed
class SelectedResources with _$SelectedResources {
  factory SelectedResources({
    required List<int> selectedResourceIds,
    required List<int> unselectedResourceIds,
   
  }) = _SelectedResources;

  factory SelectedResources.fromJson(Map<String, dynamic> json) => _$SelectedResourcesFromJson(json);
}

// This will generates a AsyncNotifier and AsyncNotifierProvider.
// The AsyncNotifier class that will be passed to our AsyncNotifierProvider.
// This class should not expose state outside of its "state" property, which means
// no public getters/properties!
// The public methods on this class will be what allow the UI to modify the state.
// Finally, we are using asyncOrgsProvider(AsyncNotifierProvider) to allow the UI to
// interact with our Orgs class.
@riverpod
class AsyncSelectedResources extends _$AsyncSelectedResources {
  Future<SelectedResources> _fetch() async {

    String token = ref.read(nestAuthProvider.notifier).token!;
   
    var response = await apiGetData(
        token,
        "$defaultAPIBaseUrl$defaultApiPrefixPath/resources/sources/selected");
    // .then((response) {
    logNoStack.i("SELECTED_RESOURCES: result ${response.body.toString()}");
    final map = jsonDecode(response.body);

    SelectedResources selectedResources =
        SelectedResources
            .fromJson(map);
   return selectedResources;
    }
  

  @override
  FutureOr<SelectedResources> build() async {
    // Load initial selectedResources from the remote repository
    return _fetch();
  }

  Future<void> setSelectedResourceIds(SelectedResources selectedResources) async {
    // Set the state to loading
    state = const AsyncValue.loading();
    // Add the new selectedResource and reload the selectedResources from the remote repository
    state = await AsyncValue.guard(() async {

    String token = ref.read(nestAuthProvider.notifier).token!;
   logNoStack.i("SELECTED_RESOURCES: setSelectedResourceIds $selectedResources");
   logNoStack.i("SELECTED_RESOURCES: api path=>$defaultAPIBaseUrl$defaultApiPrefixPath/resources/sources/selected");
    var response = await apiPostDataNoLocale(
        token,
        "$defaultAPIBaseUrl$defaultApiPrefixPath/resources/sources/selected",
        "selectedResources",
        jsonEncode(selectedResources));
    // .then((response) {
    logNoStack.i("SELECTED_RESOURCES: result ${response.body.toString()}");

     return _fetch();
    });
  }

  // Let's allow removing selectedResources
  // Future<void> removeSelectedResourceId(int resourceId) async {
  //   state = const AsyncValue.loading();
  //   state = await AsyncValue.guard(() async {

  //     return _fetch();
  //   });
  // }

  // Let's toggle a resource
  // Future<void> toggle(int resourceId) async {
  //   state = const AsyncValue.loading();
  //   state = await AsyncValue.guard(() async {

  //     return _fetch();
  //   });
  // }
}
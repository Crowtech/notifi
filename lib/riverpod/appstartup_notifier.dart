import 'package:riverpod_annotation/riverpod_annotation.dart';

@riverpod
class AppStartupNotifier extends _$AppStartupNotifier {
  @override
  Future<void> build() async {
    // Initially, load the database from JSON
    await _complexInitializationLogic();
  }

  Future<void> _complexInitializationLogic() async {
    // some complex initialization logic    
  }

  Future<void> retry() async {
    // use AsyncValue.guard to handle errors gracefully
    state = await AsyncValue.guard(_complexInitializationLogic);
  }
}
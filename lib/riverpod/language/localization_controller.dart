import 'package:notifi/riverpod/language/language_enum.dart';
import 'package:notifi/riverpod/language/language_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'localization_controller.g.dart';

@riverpod
class LocalizationController extends _$LocalizationController {
  @override
  FutureOr<void> build() async {
    return;
  }

  Future<void> setLanguage(LanguageEnum language) async {
    final languageRepo = ref.read(languageRepositoryProvider);
    await languageRepo.setLanguage(language);
  }

  /// Get language
  Future<LanguageEnum> getLanguage() async {
    final languageRepo = ref.read(languageRepositoryProvider);
    return languageRepo.getLanguage();
  }
}
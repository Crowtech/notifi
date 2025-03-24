import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:notifi/riverpod/language/language_enum.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'language_repository.g.dart';

class LanguageRepository {
  final Ref ref;

  LanguageRepository(this.ref);

  final storage = const FlutterSecureStorage();

  /// Method to store the language in the secure storage
  Future<void> setLanguage(LanguageEnum language) async {
    await storage.write(key: 'language', value: language.code);
    ref.read(currentLanguageProvider.notifier).set(language);
  }

  /// Method to get the language from the secure storage
  Future<LanguageEnum> getLanguage() async {
    final code = await storage.read(key: 'language');
    // If the language is not set, return the default language and set it in the secure storage
    if (code == null) {
      const defaultLanguage = LanguageEnum.en;
      await setLanguage(defaultLanguage);
      return defaultLanguage;
    }
    for (var value in LanguageEnum.values) {
      if (value.code == code) {
        ref.read(currentLanguageProvider.notifier).set(value);
        return value;
      }
    }
    return LanguageEnum.en;
  }
}

// Riverpod provider for the language repository
@Riverpod(keepAlive: true)
LanguageRepository languageRepository(LanguageRepositoryRef ref) {
  return LanguageRepository(ref);
}

/// Language provider
@Riverpod(keepAlive: true)
class CurrentLanguage extends _$CurrentLanguage {
  Future<LanguageEnum> _getLanguage() async {
    return ref.watch(languageRepositoryProvider).getLanguage();
  }

  @override
  FutureOr<LanguageEnum> build() async {
    return _getLanguage();
  }

  void set(LanguageEnum value) {
    state = AsyncValue.data(value);
  }
}
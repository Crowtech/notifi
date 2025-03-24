// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'language_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$languageRepositoryHash() =>
    r'beac213b6d7d1ff7c823845676f5a8fae7ccd524';

/// See also [languageRepository].
@ProviderFor(languageRepository)
final languageRepositoryProvider = Provider<LanguageRepository>.internal(
  languageRepository,
  name: r'languageRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$languageRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef LanguageRepositoryRef = ProviderRef<LanguageRepository>;
String _$currentLanguageHash() => r'20db6341210e993420fd55beec3754abe7ef10d5';

/// Language provider
///
/// Copied from [CurrentLanguage].
@ProviderFor(CurrentLanguage)
final currentLanguageProvider =
    AsyncNotifierProvider<CurrentLanguage, LanguageEnum>.internal(
  CurrentLanguage.new,
  name: r'currentLanguageProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$currentLanguageHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CurrentLanguage = AsyncNotifier<LanguageEnum>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package

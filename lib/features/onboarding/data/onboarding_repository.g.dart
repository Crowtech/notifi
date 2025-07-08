// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'onboarding_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$onboardingRepositoryHash() =>
    r'445c529dd1ac7515d8be0abd6159af6958ff3c5c';

/// Riverpod provider for the OnboardingRepository
///
/// This provider creates and manages the OnboardingRepository instance,
/// ensuring proper dependency injection and lifecycle management. It's
/// marked as keepAlive to maintain the repository instance across the
/// application lifecycle, preventing unnecessary recreation.
///
/// The provider depends on the SharedPreferences provider and waits for
/// it to be available before creating the repository instance. This ensures
/// the repository is ready for use when accessed by other parts of the app.
///
/// Usage in widgets and other providers:
/// ```dart
/// final repository = await ref.watch(onboardingRepositoryProvider.future);
/// ```
///
/// Copied from [onboardingRepository].
@ProviderFor(onboardingRepository)
final onboardingRepositoryProvider =
    FutureProvider<OnboardingRepository>.internal(
  onboardingRepository,
  name: r'onboardingRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$onboardingRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef OnboardingRepositoryRef = FutureProviderRef<OnboardingRepository>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package

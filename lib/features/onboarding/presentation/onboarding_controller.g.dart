// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'onboarding_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$onboardingControllerHash() =>
    r'232966a6326a75bb5f5166c8b76bbbb15087adaf';

/// Controller for managing onboarding flow and user interactions
///
/// This class implements the presentation layer logic for the onboarding feature,
/// providing reactive state management and business logic coordination. It extends
/// AsyncNotifier to handle asynchronous operations with proper loading states,
/// error handling, and success callbacks.
///
/// Key Responsibilities:
/// - Coordinate onboarding completion workflow
/// - Manage async state for UI feedback
/// - Handle errors gracefully during onboarding
/// - Provide clean interface for UI components
///
/// State Management:
/// - AsyncLoading: When completing onboarding process
/// - AsyncData: When operations complete successfully
/// - AsyncError: When operations fail (network, storage, etc.)
///
/// Usage in UI:
/// ```dart
/// final controller = ref.watch(onboardingControllerProvider.notifier);
/// await controller.completeOnboarding();
/// ```
///
/// Copied from [OnboardingController].
@ProviderFor(OnboardingController)
final onboardingControllerProvider =
    AutoDisposeAsyncNotifierProvider<OnboardingController, void>.internal(
  OnboardingController.new,
  name: r'onboardingControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$onboardingControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$OnboardingController = AutoDisposeAsyncNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package

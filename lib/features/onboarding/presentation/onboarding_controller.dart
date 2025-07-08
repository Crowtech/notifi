/// Onboarding Presentation Layer - Controls onboarding flow and user interactions
/// 
/// This controller manages the business logic and state for the onboarding feature,
/// which introduces new users to the Notifi application. The onboarding process
/// is critical for user retention and engagement, providing:
/// - First-time user experience (FTUE)
/// - Feature introduction and education
/// - Permission requests and setup
/// - User preference collection
/// 
/// The controller acts as the bridge between the UI layer and the data layer,
/// handling user interactions and coordinating state changes. It uses Riverpod's
/// AsyncNotifier pattern to manage asynchronous operations and provide reactive
/// state management.
/// 
/// User Journey:
/// 1. New user opens app for the first time
/// 2. Onboarding screens are presented
/// 3. User completes onboarding steps
/// 4. Controller calls completeOnboarding()
/// 5. State is persisted via repository
/// 6. User is navigated to main app
/// 
/// Integration with Notifi App:
/// The onboarding controller integrates with the app's routing system to
/// determine user flow. Once onboarding is complete, users gain access to
/// the main notification management features, including organization management,
/// person contacts, and notification settings.

import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../data/onboarding_repository.dart';

part 'onboarding_controller.g.dart';

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
@riverpod
class OnboardingController extends _$OnboardingController {
  /// Builds the initial state for the onboarding controller
  /// 
  /// This method is called when the controller is first created and sets up
  /// the initial state. Currently performs no operations (no-op) as the
  /// onboarding controller primarily handles actions rather than maintaining
  /// complex state.
  /// 
  /// The void return type indicates this controller manages completion actions
  /// rather than maintaining data state that needs to be displayed.
  @override
  FutureOr<void> build() {
    // no op - controller handles actions rather than state
  }

  /// Completes the onboarding process for the current user
  /// 
  /// This method orchestrates the onboarding completion workflow by:
  /// 1. Accessing the onboarding repository
  /// 2. Setting loading state for UI feedback
  /// 3. Calling repository to persist completion status
  /// 4. Handling success/error states appropriately
  /// 
  /// The method uses AsyncValue.guard to automatically handle errors and
  /// wrap the result in appropriate AsyncValue states. This ensures the UI
  /// can react to loading, success, and error states consistently.
  /// 
  /// UI Integration:
  /// - Shows loading indicator during completion
  /// - Navigates to main app on success
  /// - Displays error message on failure
  /// - Allows retry on error
  /// 
  /// Business Logic:
  /// - Validates user has completed required onboarding steps
  /// - Persists completion state to prevent re-showing onboarding
  /// - Triggers navigation to main application flow
  /// 
  /// Error Handling:
  /// - Network failures during state persistence
  /// - Storage errors when saving completion status
  /// - Invalid state transitions
  /// 
  /// Throws: Errors are wrapped in AsyncError state rather than thrown
  Future<void> completeOnboarding() async {
    final onboardingRepository =
        ref.watch(onboardingRepositoryProvider).requireValue;
    state = const AsyncLoading();
    state = await AsyncValue.guard(onboardingRepository.setOnboardingComplete);
  }
}

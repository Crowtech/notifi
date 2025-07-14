/// Onboarding Data Layer - Manages user onboarding state persistence
/// 
/// This repository handles the data layer for the onboarding feature, which is
/// responsible for guiding new users through the initial setup and introduction
/// to the Notifi application. The onboarding process typically includes:
/// - Welcome screens introducing key features
/// - Initial configuration setup
/// - Permission requests (notifications, location, etc.)
/// - Tutorial walkthrough of main functionality
/// 
/// The repository uses SharedPreferences to persist onboarding completion state
/// across app sessions, ensuring users don't see the onboarding flow repeatedly.
/// This is crucial for providing a smooth user experience and preventing 
/// repetitive introductory content.
/// 
/// Architecture:
/// - Data Layer: This file (persistence via SharedPreferences)
/// - Presentation Layer: OnboardingController (business logic)
/// - UI Layer: Onboarding screens and widgets
/// 
/// Integration with Notifi App:
/// The onboarding feature serves as the entry point for new users, collecting
/// necessary permissions and preferences before they can access the main
/// notification management functionality. It integrates with the app's routing
/// system to determine whether to show onboarding or navigate directly to
/// the main application flow.
library;

import '../../../utils/shared_preferences_provider.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'onboarding_repository.g.dart';

/// Repository for managing onboarding state persistence
/// 
/// This class encapsulates all data operations related to user onboarding,
/// providing a clean interface for checking and updating onboarding completion
/// status. It abstracts away the SharedPreferences implementation details
/// and provides a consistent API for the presentation layer.
/// 
/// Business Logic:
/// - Tracks whether a user has completed the initial onboarding process
/// - Prevents showing onboarding screens to returning users
/// - Ensures onboarding state persists across app restarts
/// 
/// Usage:
/// ```dart
/// final repository = await ref.watch(onboardingRepositoryProvider.future);
/// final isComplete = repository.isOnboardingComplete();
/// await repository.setOnboardingComplete();
/// ```
class OnboardingRepository {
  /// Creates an onboarding repository with the provided SharedPreferences instance
  /// 
  /// [sharedPreferences] The SharedPreferences instance for data persistence
  OnboardingRepository(this.sharedPreferences);
  
  /// SharedPreferences instance for persistent storage of onboarding state
  final SharedPreferences sharedPreferences;

  /// Key used to store onboarding completion status in SharedPreferences
  /// 
  /// This constant ensures consistent storage and retrieval of the onboarding
  /// state across the application. The key is used to store a boolean value
  /// indicating whether the user has completed the onboarding process.
  static const onboardingCompleteKey = 'onboardingComplete';

  /// Marks the onboarding process as complete for the current user
  /// 
  /// This method should be called when the user successfully completes all
  /// onboarding steps, including:
  /// - Viewing introduction screens
  /// - Granting necessary permissions
  /// - Completing initial setup
  /// 
  /// The completion state is persisted to SharedPreferences to ensure
  /// the user won't see the onboarding flow again on subsequent app launches.
  /// 
  /// Throws: [Exception] if SharedPreferences write operation fails
  Future<void> setOnboardingComplete() async {
    await sharedPreferences.setBool(onboardingCompleteKey, true);
  }

  /// Checks if the user has completed the onboarding process
  /// 
  /// Returns `true` if the user has previously completed onboarding,
  /// `false` otherwise. This method is used by the app's routing logic
  /// to determine whether to show onboarding screens or navigate directly
  /// to the main application.
  /// 
  /// Default Value: Returns `false` for new users who haven't completed
  /// onboarding yet, ensuring they see the introduction flow.
  /// 
  /// Returns: Boolean indicating onboarding completion status
  bool isOnboardingComplete() =>
      sharedPreferences.getBool(onboardingCompleteKey) ?? false;
}

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
@Riverpod(keepAlive: true)
Future<OnboardingRepository> onboardingRepository(Ref ref) async {
  final sharedPreferences = await ref.watch(sharedPreferencesProvider.future);
  return OnboardingRepository(sharedPreferences);
}

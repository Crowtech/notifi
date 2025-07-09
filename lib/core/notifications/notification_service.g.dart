// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$notificationServiceHash() =>
    r'd9317c9e999da0ca358f1296216334e6a498235a';

/// Main notification service that handles Firebase messaging,
/// local notifications, and topic management.
///
/// Copied from [NotificationService].
@ProviderFor(NotificationService)
final notificationServiceProvider =
    AsyncNotifierProvider<NotificationService, void>.internal(
  NotificationService.new,
  name: r'notificationServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$notificationServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$NotificationService = AsyncNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package

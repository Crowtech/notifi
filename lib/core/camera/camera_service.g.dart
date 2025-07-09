// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'camera_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$availableCamerasListHash() =>
    r'cee710d8aa87d08e449f26a8622b01780d4824ce';

/// Available cameras in the system
///
/// Copied from [availableCamerasList].
@ProviderFor(availableCamerasList)
final availableCamerasListProvider =
    FutureProvider<List<CameraDescription>>.internal(
  availableCamerasList,
  name: r'availableCamerasListProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$availableCamerasListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AvailableCamerasListRef = FutureProviderRef<List<CameraDescription>>;
String _$cameraServiceHash() => r'ce1beeded908d1baa8b897db81f36708488e3d73';

/// Camera service for managing camera functionality
///
/// Copied from [CameraService].
@ProviderFor(CameraService)
final cameraServiceProvider =
    AsyncNotifierProvider<CameraService, CameraState>.internal(
  CameraService.new,
  name: r'cameraServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$cameraServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CameraService = AsyncNotifier<CameraState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package

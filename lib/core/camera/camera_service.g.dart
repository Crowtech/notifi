// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'camera_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$availableCamerasHash() => r'7a791b6a218540ef961ca805ab70a30dd83c8d14';

/// Available cameras in the system
///
/// Copied from [availableCameras].
@ProviderFor(availableCameras)
final availableCamerasProvider =
    FutureProvider<List<CameraDescription>>.internal(
  availableCameras,
  name: r'availableCamerasProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$availableCamerasHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AvailableCamerasRef = FutureProviderRef<List<CameraDescription>>;
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

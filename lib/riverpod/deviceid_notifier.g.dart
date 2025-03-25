// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deviceid_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$fetchDeviceCodeHash() => r'c35ff99fef1bc019610359a89b6f4acf0a6ba82d';

/// See also [fetchDeviceCode].
@ProviderFor(fetchDeviceCode)
final fetchDeviceCodeProvider = AutoDisposeFutureProvider<String>.internal(
  fetchDeviceCode,
  name: r'fetchDeviceCodeProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$fetchDeviceCodeHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FetchDeviceCodeRef = AutoDisposeFutureProviderRef<String>;
String _$deviceIdNotifierHash() => r'ee6f0eead077be53d74bf35d241ba1cfdbbba5c7';

/// See also [DeviceIdNotifier].
@ProviderFor(DeviceIdNotifier)
final deviceIdNotifierProvider =
    NotifierProvider<DeviceIdNotifier, String>.internal(
  DeviceIdNotifier.new,
  name: r'deviceIdNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$deviceIdNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$DeviceIdNotifier = Notifier<String>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package

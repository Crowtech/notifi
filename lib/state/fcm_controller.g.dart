// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fcm_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$fcmHash() => r'30b33ac8e19232e21625a5a3f015ef0a0b14b1fc';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [fcm].
@ProviderFor(fcm)
const fcmProvider = FcmFamily();

/// See also [fcm].
class FcmFamily extends Family<AsyncValue<Fcm>> {
  /// See also [fcm].
  const FcmFamily();

  /// See also [fcm].
  FcmProvider call(FirebaseOptions? options) {
    return FcmProvider(options);
  }

  @override
  FcmProvider getProviderOverride(covariant FcmProvider provider) {
    return call(provider.options);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'fcmProvider';
}

/// See also [fcm].
class FcmProvider extends AutoDisposeFutureProvider<Fcm> {
  /// See also [fcm].
  FcmProvider(FirebaseOptions? options)
    : this._internal(
        (ref) => fcm(ref as FcmRef, options),
        from: fcmProvider,
        name: r'fcmProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product') ? null : _$fcmHash,
        dependencies: FcmFamily._dependencies,
        allTransitiveDependencies: FcmFamily._allTransitiveDependencies,
        options: options,
      );

  FcmProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.options,
  }) : super.internal();

  final FirebaseOptions? options;

  @override
  Override overrideWith(FutureOr<Fcm> Function(FcmRef provider) create) {
    return ProviderOverride(
      origin: this,
      override: FcmProvider._internal(
        (ref) => create(ref as FcmRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        options: options,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Fcm> createElement() {
    return _FcmProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FcmProvider && other.options == options;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, options.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin FcmRef on AutoDisposeFutureProviderRef<Fcm> {
  /// The parameter `options` of this provider.
  FirebaseOptions? get options;
}

class _FcmProviderElement extends AutoDisposeFutureProviderElement<Fcm>
    with FcmRef {
  _FcmProviderElement(super.provider);

  @override
  FirebaseOptions? get options => (origin as FcmProvider).options;
}

String _$fcmControllerHash() => r'38515adc759847875b5e03c71b6494110178047d';

abstract class _$FcmController extends BuildlessAutoDisposeAsyncNotifier<Fcm> {
  late final FirebaseOptions options;

  FutureOr<Fcm> build(FirebaseOptions options);
}

/// This controller is an [AsyncNotifier] that holds and handles our authentication state
///
/// Copied from [FcmController].
@ProviderFor(FcmController)
const fcmControllerProvider = FcmControllerFamily();

/// This controller is an [AsyncNotifier] that holds and handles our authentication state
///
/// Copied from [FcmController].
class FcmControllerFamily extends Family<AsyncValue<Fcm>> {
  /// This controller is an [AsyncNotifier] that holds and handles our authentication state
  ///
  /// Copied from [FcmController].
  const FcmControllerFamily();

  /// This controller is an [AsyncNotifier] that holds and handles our authentication state
  ///
  /// Copied from [FcmController].
  FcmControllerProvider call(FirebaseOptions options) {
    return FcmControllerProvider(options);
  }

  @override
  FcmControllerProvider getProviderOverride(
    covariant FcmControllerProvider provider,
  ) {
    return call(provider.options);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'fcmControllerProvider';
}

/// This controller is an [AsyncNotifier] that holds and handles our authentication state
///
/// Copied from [FcmController].
class FcmControllerProvider
    extends AutoDisposeAsyncNotifierProviderImpl<FcmController, Fcm> {
  /// This controller is an [AsyncNotifier] that holds and handles our authentication state
  ///
  /// Copied from [FcmController].
  FcmControllerProvider(FirebaseOptions options)
    : this._internal(
        () => FcmController()..options = options,
        from: fcmControllerProvider,
        name: r'fcmControllerProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$fcmControllerHash,
        dependencies: FcmControllerFamily._dependencies,
        allTransitiveDependencies:
            FcmControllerFamily._allTransitiveDependencies,
        options: options,
      );

  FcmControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.options,
  }) : super.internal();

  final FirebaseOptions options;

  @override
  FutureOr<Fcm> runNotifierBuild(covariant FcmController notifier) {
    return notifier.build(options);
  }

  @override
  Override overrideWith(FcmController Function() create) {
    return ProviderOverride(
      origin: this,
      override: FcmControllerProvider._internal(
        () => create()..options = options,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        options: options,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<FcmController, Fcm> createElement() {
    return _FcmControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FcmControllerProvider && other.options == options;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, options.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin FcmControllerRef on AutoDisposeAsyncNotifierProviderRef<Fcm> {
  /// The parameter `options` of this provider.
  FirebaseOptions get options;
}

class _FcmControllerProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<FcmController, Fcm>
    with FcmControllerRef {
  _FcmControllerProviderElement(super.provider);

  @override
  FirebaseOptions get options => (origin as FcmControllerProvider).options;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package

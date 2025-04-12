// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'refresh_widget.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$refreshWidgetHash() => r'27769cf83021e9af4b5a6e18c6fbd2b190e8155c';

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

abstract class _$RefreshWidget extends BuildlessAutoDisposeNotifier<String> {
  late final String code;

  String build(
    String code,
  );
}

/// See also [RefreshWidget].
@ProviderFor(RefreshWidget)
const refreshWidgetProvider = RefreshWidgetFamily();

/// See also [RefreshWidget].
class RefreshWidgetFamily extends Family<String> {
  /// See also [RefreshWidget].
  const RefreshWidgetFamily();

  /// See also [RefreshWidget].
  RefreshWidgetProvider call(
    String code,
  ) {
    return RefreshWidgetProvider(
      code,
    );
  }

  @override
  RefreshWidgetProvider getProviderOverride(
    covariant RefreshWidgetProvider provider,
  ) {
    return call(
      provider.code,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'refreshWidgetProvider';
}

/// See also [RefreshWidget].
class RefreshWidgetProvider
    extends AutoDisposeNotifierProviderImpl<RefreshWidget, String> {
  /// See also [RefreshWidget].
  RefreshWidgetProvider(
    String code,
  ) : this._internal(
          () => RefreshWidget()..code = code,
          from: refreshWidgetProvider,
          name: r'refreshWidgetProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$refreshWidgetHash,
          dependencies: RefreshWidgetFamily._dependencies,
          allTransitiveDependencies:
              RefreshWidgetFamily._allTransitiveDependencies,
          code: code,
        );

  RefreshWidgetProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.code,
  }) : super.internal();

  final String code;

  @override
  String runNotifierBuild(
    covariant RefreshWidget notifier,
  ) {
    return notifier.build(
      code,
    );
  }

  @override
  Override overrideWith(RefreshWidget Function() create) {
    return ProviderOverride(
      origin: this,
      override: RefreshWidgetProvider._internal(
        () => create()..code = code,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        code: code,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<RefreshWidget, String> createElement() {
    return _RefreshWidgetProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is RefreshWidgetProvider && other.code == code;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, code.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin RefreshWidgetRef on AutoDisposeNotifierProviderRef<String> {
  /// The parameter `code` of this provider.
  String get code;
}

class _RefreshWidgetProviderElement
    extends AutoDisposeNotifierProviderElement<RefreshWidget, String>
    with RefreshWidgetRef {
  _RefreshWidgetProviderElement(super.provider);

  @override
  String get code => (origin as RefreshWidgetProvider).code;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package

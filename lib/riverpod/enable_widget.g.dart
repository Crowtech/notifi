// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'enable_widget.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$enableWidgetHash() => r'c479d88deede761a5a26f3089a104a5b5bfecbb5';

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

abstract class _$EnableWidget extends BuildlessAutoDisposeNotifier<bool> {
  late final String code;

  bool build(
    String code,
  );
}

/// See also [EnableWidget].
@ProviderFor(EnableWidget)
const enableWidgetProvider = EnableWidgetFamily();

/// See also [EnableWidget].
class EnableWidgetFamily extends Family<bool> {
  /// See also [EnableWidget].
  const EnableWidgetFamily();

  /// See also [EnableWidget].
  EnableWidgetProvider call(
    String code,
  ) {
    return EnableWidgetProvider(
      code,
    );
  }

  @override
  EnableWidgetProvider getProviderOverride(
    covariant EnableWidgetProvider provider,
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
  String? get name => r'enableWidgetProvider';
}

/// See also [EnableWidget].
class EnableWidgetProvider
    extends AutoDisposeNotifierProviderImpl<EnableWidget, bool> {
  /// See also [EnableWidget].
  EnableWidgetProvider(
    String code,
  ) : this._internal(
          () => EnableWidget()..code = code,
          from: enableWidgetProvider,
          name: r'enableWidgetProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$enableWidgetHash,
          dependencies: EnableWidgetFamily._dependencies,
          allTransitiveDependencies:
              EnableWidgetFamily._allTransitiveDependencies,
          code: code,
        );

  EnableWidgetProvider._internal(
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
  bool runNotifierBuild(
    covariant EnableWidget notifier,
  ) {
    return notifier.build(
      code,
    );
  }

  @override
  Override overrideWith(EnableWidget Function() create) {
    return ProviderOverride(
      origin: this,
      override: EnableWidgetProvider._internal(
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
  AutoDisposeNotifierProviderElement<EnableWidget, bool> createElement() {
    return _EnableWidgetProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is EnableWidgetProvider && other.code == code;
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
mixin EnableWidgetRef on AutoDisposeNotifierProviderRef<bool> {
  /// The parameter `code` of this provider.
  String get code;
}

class _EnableWidgetProviderElement
    extends AutoDisposeNotifierProviderElement<EnableWidget, bool>
    with EnableWidgetRef {
  _EnableWidgetProviderElement(super.provider);

  @override
  String get code => (origin as EnableWidgetProvider).code;
}

String _$enableWidgetTrueHash() => r'113063abc481c00a6417288b9a6cf45eba8dcd9e';

abstract class _$EnableWidgetTrue extends BuildlessAutoDisposeNotifier<bool> {
  late final String code;

  bool build(
    String code,
  );
}

/// See also [EnableWidgetTrue].
@ProviderFor(EnableWidgetTrue)
const enableWidgetTrueProvider = EnableWidgetTrueFamily();

/// See also [EnableWidgetTrue].
class EnableWidgetTrueFamily extends Family<bool> {
  /// See also [EnableWidgetTrue].
  const EnableWidgetTrueFamily();

  /// See also [EnableWidgetTrue].
  EnableWidgetTrueProvider call(
    String code,
  ) {
    return EnableWidgetTrueProvider(
      code,
    );
  }

  @override
  EnableWidgetTrueProvider getProviderOverride(
    covariant EnableWidgetTrueProvider provider,
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
  String? get name => r'enableWidgetTrueProvider';
}

/// See also [EnableWidgetTrue].
class EnableWidgetTrueProvider
    extends AutoDisposeNotifierProviderImpl<EnableWidgetTrue, bool> {
  /// See also [EnableWidgetTrue].
  EnableWidgetTrueProvider(
    String code,
  ) : this._internal(
          () => EnableWidgetTrue()..code = code,
          from: enableWidgetTrueProvider,
          name: r'enableWidgetTrueProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$enableWidgetTrueHash,
          dependencies: EnableWidgetTrueFamily._dependencies,
          allTransitiveDependencies:
              EnableWidgetTrueFamily._allTransitiveDependencies,
          code: code,
        );

  EnableWidgetTrueProvider._internal(
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
  bool runNotifierBuild(
    covariant EnableWidgetTrue notifier,
  ) {
    return notifier.build(
      code,
    );
  }

  @override
  Override overrideWith(EnableWidgetTrue Function() create) {
    return ProviderOverride(
      origin: this,
      override: EnableWidgetTrueProvider._internal(
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
  AutoDisposeNotifierProviderElement<EnableWidgetTrue, bool> createElement() {
    return _EnableWidgetTrueProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is EnableWidgetTrueProvider && other.code == code;
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
mixin EnableWidgetTrueRef on AutoDisposeNotifierProviderRef<bool> {
  /// The parameter `code` of this provider.
  String get code;
}

class _EnableWidgetTrueProviderElement
    extends AutoDisposeNotifierProviderElement<EnableWidgetTrue, bool>
    with EnableWidgetTrueRef {
  _EnableWidgetTrueProviderElement(super.provider);

  @override
  String get code => (origin as EnableWidgetTrueProvider).code;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package

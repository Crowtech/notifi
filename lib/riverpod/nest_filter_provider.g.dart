// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nest_filter_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$adamNestFilterHash() => r'ad662a2fd2df53d3614e32c2e5da8cf9225bfd66';

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

abstract class _$AdamNestFilter extends BuildlessNotifier<NestFilter> {
  late final NestFilterType nestFilterType;

  NestFilter build(
    NestFilterType nestFilterType,
  );
}

/// See also [AdamNestFilter].
@ProviderFor(AdamNestFilter)
const adamNestFilterProvider = AdamNestFilterFamily();

/// See also [AdamNestFilter].
class AdamNestFilterFamily extends Family<NestFilter> {
  /// See also [AdamNestFilter].
  const AdamNestFilterFamily();

  /// See also [AdamNestFilter].
  AdamNestFilterProvider call(
    NestFilterType nestFilterType,
  ) {
    return AdamNestFilterProvider(
      nestFilterType,
    );
  }

  @override
  AdamNestFilterProvider getProviderOverride(
    covariant AdamNestFilterProvider provider,
  ) {
    return call(
      provider.nestFilterType,
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
  String? get name => r'adamNestFilterProvider';
}

/// See also [AdamNestFilter].
class AdamNestFilterProvider
    extends NotifierProviderImpl<AdamNestFilter, NestFilter> {
  /// See also [AdamNestFilter].
  AdamNestFilterProvider(
    NestFilterType nestFilterType,
  ) : this._internal(
          () => AdamNestFilter()..nestFilterType = nestFilterType,
          from: adamNestFilterProvider,
          name: r'adamNestFilterProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$adamNestFilterHash,
          dependencies: AdamNestFilterFamily._dependencies,
          allTransitiveDependencies:
              AdamNestFilterFamily._allTransitiveDependencies,
          nestFilterType: nestFilterType,
        );

  AdamNestFilterProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.nestFilterType,
  }) : super.internal();

  final NestFilterType nestFilterType;

  @override
  NestFilter runNotifierBuild(
    covariant AdamNestFilter notifier,
  ) {
    return notifier.build(
      nestFilterType,
    );
  }

  @override
  Override overrideWith(AdamNestFilter Function() create) {
    return ProviderOverride(
      origin: this,
      override: AdamNestFilterProvider._internal(
        () => create()..nestFilterType = nestFilterType,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        nestFilterType: nestFilterType,
      ),
    );
  }

  @override
  NotifierProviderElement<AdamNestFilter, NestFilter> createElement() {
    return _AdamNestFilterProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AdamNestFilterProvider &&
        other.nestFilterType == nestFilterType;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, nestFilterType.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin AdamNestFilterRef on NotifierProviderRef<NestFilter> {
  /// The parameter `nestFilterType` of this provider.
  NestFilterType get nestFilterType;
}

class _AdamNestFilterProviderElement
    extends NotifierProviderElement<AdamNestFilter, NestFilter>
    with AdamNestFilterRef {
  _AdamNestFilterProviderElement(super.provider);

  @override
  NestFilterType get nestFilterType =>
      (origin as AdamNestFilterProvider).nestFilterType;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package

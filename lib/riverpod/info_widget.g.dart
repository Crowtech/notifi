// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'info_widget.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$infoDataHash() => r'e1586828a1a0caa7d7cede8f84931a197f251c52';

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

abstract class _$InfoData
    extends BuildlessAutoDisposeNotifier<Map<String, dynamic>> {
  late final String code;

  Map<String, dynamic> build(
    String code,
  );
}

/// See also [InfoData].
@ProviderFor(InfoData)
const infoDataProvider = InfoDataFamily();

/// See also [InfoData].
class InfoDataFamily extends Family<Map<String, dynamic>> {
  /// See also [InfoData].
  const InfoDataFamily();

  /// See also [InfoData].
  InfoDataProvider call(
    String code,
  ) {
    return InfoDataProvider(
      code,
    );
  }

  @override
  InfoDataProvider getProviderOverride(
    covariant InfoDataProvider provider,
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
  String? get name => r'infoDataProvider';
}

/// See also [InfoData].
class InfoDataProvider
    extends AutoDisposeNotifierProviderImpl<InfoData, Map<String, dynamic>> {
  /// See also [InfoData].
  InfoDataProvider(
    String code,
  ) : this._internal(
          () => InfoData()..code = code,
          from: infoDataProvider,
          name: r'infoDataProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$infoDataHash,
          dependencies: InfoDataFamily._dependencies,
          allTransitiveDependencies: InfoDataFamily._allTransitiveDependencies,
          code: code,
        );

  InfoDataProvider._internal(
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
  Map<String, dynamic> runNotifierBuild(
    covariant InfoData notifier,
  ) {
    return notifier.build(
      code,
    );
  }

  @override
  Override overrideWith(InfoData Function() create) {
    return ProviderOverride(
      origin: this,
      override: InfoDataProvider._internal(
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
  AutoDisposeNotifierProviderElement<InfoData, Map<String, dynamic>>
      createElement() {
    return _InfoDataProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is InfoDataProvider && other.code == code;
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
mixin InfoDataRef on AutoDisposeNotifierProviderRef<Map<String, dynamic>> {
  /// The parameter `code` of this provider.
  String get code;
}

class _InfoDataProviderElement
    extends AutoDisposeNotifierProviderElement<InfoData, Map<String, dynamic>>
    with InfoDataRef {
  _InfoDataProviderElement(super.provider);

  @override
  String get code => (origin as InfoDataProvider).code;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package

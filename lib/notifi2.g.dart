// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notifi2.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$notifi2Hash() => r'd6d5f4b4c553b6b447dfb3b304f07ec39faccfd0';

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

/// See also [Notifi2].
@ProviderFor(Notifi2)
const notifi2Provider = Notifi2Family();

/// See also [Notifi2].
class Notifi2Family extends Family<void> {
  /// See also [Notifi2].
  const Notifi2Family();

  /// See also [Notifi2].
  Notifi2Provider call(
    FirebaseOptions options,
    dynamic secondsToast,
    List<String>? topics,
  ) {
    return Notifi2Provider(
      options,
      secondsToast,
      topics,
    );
  }

  @override
  Notifi2Provider getProviderOverride(
    covariant Notifi2Provider provider,
  ) {
    return call(
      provider.options,
      provider.secondsToast,
      provider.topics,
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
  String? get name => r'notifi2Provider';
}

/// See also [Notifi2].
class Notifi2Provider extends Provider<void> {
  /// See also [Notifi2].
  Notifi2Provider(
    FirebaseOptions options,
    dynamic secondsToast,
    List<String>? topics,
  ) : this._internal(
          (ref) => Notifi2(
            ref as Notifi2Ref,
            options,
            secondsToast,
            topics,
          ),
          from: notifi2Provider,
          name: r'notifi2Provider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$notifi2Hash,
          dependencies: Notifi2Family._dependencies,
          allTransitiveDependencies: Notifi2Family._allTransitiveDependencies,
          options: options,
          secondsToast: secondsToast,
          topics: topics,
        );

  Notifi2Provider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.options,
    required this.secondsToast,
    required this.topics,
  }) : super.internal();

  final FirebaseOptions options;
  final dynamic secondsToast;
  final List<String>? topics;

  @override
  Override overrideWith(
    void Function(Notifi2Ref provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: Notifi2Provider._internal(
        (ref) => create(ref as Notifi2Ref),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        options: options,
        secondsToast: secondsToast,
        topics: topics,
      ),
    );
  }

  @override
  ProviderElement<void> createElement() {
    return _Notifi2ProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is Notifi2Provider &&
        other.options == options &&
        other.secondsToast == secondsToast &&
        other.topics == topics;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, options.hashCode);
    hash = _SystemHash.combine(hash, secondsToast.hashCode);
    hash = _SystemHash.combine(hash, topics.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin Notifi2Ref on ProviderRef<void> {
  /// The parameter `options` of this provider.
  FirebaseOptions get options;

  /// The parameter `secondsToast` of this provider.
  dynamic get secondsToast;

  /// The parameter `topics` of this provider.
  List<String>? get topics;
}

class _Notifi2ProviderElement extends ProviderElement<void> with Notifi2Ref {
  _Notifi2ProviderElement(super.provider);

  @override
  FirebaseOptions get options => (origin as Notifi2Provider).options;
  @override
  dynamic get secondsToast => (origin as Notifi2Provider).secondsToast;
  @override
  List<String>? get topics => (origin as Notifi2Provider).topics;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fcm_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$sendFcmHash() => r'1bdfb6f2561373af38810bd264fa37eee348c938';

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

/// See also [sendFcm].
@ProviderFor(sendFcm)
const sendFcmProvider = SendFcmFamily();

/// See also [sendFcm].
class SendFcmFamily extends Family<void> {
  /// See also [sendFcm].
  const SendFcmFamily();

  /// See also [sendFcm].
  SendFcmProvider call(
    String fcm,
  ) {
    return SendFcmProvider(
      fcm,
    );
  }

  @override
  SendFcmProvider getProviderOverride(
    covariant SendFcmProvider provider,
  ) {
    return call(
      provider.fcm,
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
  String? get name => r'sendFcmProvider';
}

/// See also [sendFcm].
class SendFcmProvider extends Provider<void> {
  /// See also [sendFcm].
  SendFcmProvider(
    String fcm,
  ) : this._internal(
          (ref) => sendFcm(
            ref as SendFcmRef,
            fcm,
          ),
          from: sendFcmProvider,
          name: r'sendFcmProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$sendFcmHash,
          dependencies: SendFcmFamily._dependencies,
          allTransitiveDependencies: SendFcmFamily._allTransitiveDependencies,
          fcm: fcm,
        );

  SendFcmProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.fcm,
  }) : super.internal();

  final String fcm;

  @override
  Override overrideWith(
    void Function(SendFcmRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SendFcmProvider._internal(
        (ref) => create(ref as SendFcmRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        fcm: fcm,
      ),
    );
  }

  @override
  ProviderElement<void> createElement() {
    return _SendFcmProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SendFcmProvider && other.fcm == fcm;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, fcm.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin SendFcmRef on ProviderRef<void> {
  /// The parameter `fcm` of this provider.
  String get fcm;
}

class _SendFcmProviderElement extends ProviderElement<void> with SendFcmRef {
  _SendFcmProviderElement(super.provider);

  @override
  String get fcm => (origin as SendFcmProvider).fcm;
}

String _$fcmNotifierHash() => r'3506619b549f51a72d27f2bbba887689363fcd49';

/// See also [FcmNotifier].
@ProviderFor(FcmNotifier)
final fcmNotifierProvider = NotifierProvider<FcmNotifier, String>.internal(
  FcmNotifier.new,
  name: r'fcmNotifierProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$fcmNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$FcmNotifier = Notifier<String>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notifications_data.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$notificationsDataHash() => r'fd8ae7f7bed0eafdf8234619583afa76cef4db6a';

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

abstract class _$NotificationsData
    extends BuildlessAutoDisposeNotifier<Map<String, dynamic>> {
  late final String code;

  Map<String, dynamic> build(
    String code,
  );
}

/// See also [NotificationsData].
@ProviderFor(NotificationsData)
const notificationsDataProvider = NotificationsDataFamily();

/// See also [NotificationsData].
class NotificationsDataFamily extends Family<Map<String, dynamic>> {
  /// See also [NotificationsData].
  const NotificationsDataFamily();

  /// See also [NotificationsData].
  NotificationsDataProvider call(
    String code,
  ) {
    return NotificationsDataProvider(
      code,
    );
  }

  @override
  NotificationsDataProvider getProviderOverride(
    covariant NotificationsDataProvider provider,
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
  String? get name => r'notificationsDataProvider';
}

/// See also [NotificationsData].
class NotificationsDataProvider extends AutoDisposeNotifierProviderImpl<
    NotificationsData, Map<String, dynamic>> {
  /// See also [NotificationsData].
  NotificationsDataProvider(
    String code,
  ) : this._internal(
          () => NotificationsData()..code = code,
          from: notificationsDataProvider,
          name: r'notificationsDataProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$notificationsDataHash,
          dependencies: NotificationsDataFamily._dependencies,
          allTransitiveDependencies:
              NotificationsDataFamily._allTransitiveDependencies,
          code: code,
        );

  NotificationsDataProvider._internal(
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
    covariant NotificationsData notifier,
  ) {
    return notifier.build(
      code,
    );
  }

  @override
  Override overrideWith(NotificationsData Function() create) {
    return ProviderOverride(
      origin: this,
      override: NotificationsDataProvider._internal(
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
  AutoDisposeNotifierProviderElement<NotificationsData, Map<String, dynamic>>
      createElement() {
    return _NotificationsDataProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is NotificationsDataProvider && other.code == code;
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
mixin NotificationsDataRef
    on AutoDisposeNotifierProviderRef<Map<String, dynamic>> {
  /// The parameter `code` of this provider.
  String get code;
}

class _NotificationsDataProviderElement
    extends AutoDisposeNotifierProviderElement<NotificationsData,
        Map<String, dynamic>> with NotificationsDataRef {
  _NotificationsDataProviderElement(super.provider);

  @override
  String get code => (origin as NotificationsDataProvider).code;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package

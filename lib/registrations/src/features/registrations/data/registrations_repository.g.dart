// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'registrations_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$registrationsRepositoryHash() =>
    r'a4086afe4f4b7f41e6dca8d05e81cec59e251f96';

/// See also [registrationsRepository].
@ProviderFor(registrationsRepository)
final registrationsRepositoryProvider =
    AutoDisposeProvider<RegistrationsRepository>.internal(
  registrationsRepository,
  name: r'registrationsRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$registrationsRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef RegistrationsRepositoryRef
    = AutoDisposeProviderRef<RegistrationsRepository>;
String _$registrationHash() => r'3226faa1ff913ead73b7fa2bd61d02ed8d8ec594';

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

/// Provider to fetch a registration by ID
///
/// Copied from [registration].
@ProviderFor(registration)
const registrationProvider = RegistrationFamily();

/// Provider to fetch a registration by ID
///
/// Copied from [registration].
class RegistrationFamily extends Family<AsyncValue<Registration>> {
  /// Provider to fetch a registration by ID
  ///
  /// Copied from [registration].
  const RegistrationFamily();

  /// Provider to fetch a registration by ID
  ///
  /// Copied from [registration].
  RegistrationProvider call({
    required int registrationId,
  }) {
    return RegistrationProvider(
      registrationId: registrationId,
    );
  }

  @override
  RegistrationProvider getProviderOverride(
    covariant RegistrationProvider provider,
  ) {
    return call(
      registrationId: provider.registrationId,
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
  String? get name => r'registrationProvider';
}

/// Provider to fetch a registration by ID
///
/// Copied from [registration].
class RegistrationProvider extends AutoDisposeFutureProvider<Registration> {
  /// Provider to fetch a registration by ID
  ///
  /// Copied from [registration].
  RegistrationProvider({
    required int registrationId,
  }) : this._internal(
          (ref) => registration(
            ref as RegistrationRef,
            registrationId: registrationId,
          ),
          from: registrationProvider,
          name: r'registrationProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$registrationHash,
          dependencies: RegistrationFamily._dependencies,
          allTransitiveDependencies:
              RegistrationFamily._allTransitiveDependencies,
          registrationId: registrationId,
        );

  RegistrationProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.registrationId,
  }) : super.internal();

  final int registrationId;

  @override
  Override overrideWith(
    FutureOr<Registration> Function(RegistrationRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: RegistrationProvider._internal(
        (ref) => create(ref as RegistrationRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        registrationId: registrationId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Registration> createElement() {
    return _RegistrationProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is RegistrationProvider &&
        other.registrationId == registrationId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, registrationId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin RegistrationRef on AutoDisposeFutureProviderRef<Registration> {
  /// The parameter `registrationId` of this provider.
  int get registrationId;
}

class _RegistrationProviderElement
    extends AutoDisposeFutureProviderElement<Registration>
    with RegistrationRef {
  _RegistrationProviderElement(super.provider);

  @override
  int get registrationId => (origin as RegistrationProvider).registrationId;
}

String _$fetchRegistrationsHash() =>
    r'07c034f760ec3a7c447bcf038674cb80fd8b5c4c';

/// Provider to fetch paginated registrations data
///
/// Copied from [fetchRegistrations].
@ProviderFor(fetchRegistrations)
const fetchRegistrationsProvider = FetchRegistrationsFamily();

/// Provider to fetch paginated registrations data
///
/// Copied from [fetchRegistrations].
class FetchRegistrationsFamily
    extends Family<AsyncValue<RegistrationsResponse>> {
  /// Provider to fetch paginated registrations data
  ///
  /// Copied from [fetchRegistrations].
  const FetchRegistrationsFamily();

  /// Provider to fetch paginated registrations data
  ///
  /// Copied from [fetchRegistrations].
  FetchRegistrationsProvider call({
    required ({int page, String query}) queryData,
  }) {
    return FetchRegistrationsProvider(
      queryData: queryData,
    );
  }

  @override
  FetchRegistrationsProvider getProviderOverride(
    covariant FetchRegistrationsProvider provider,
  ) {
    return call(
      queryData: provider.queryData,
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
  String? get name => r'fetchRegistrationsProvider';
}

/// Provider to fetch paginated registrations data
///
/// Copied from [fetchRegistrations].
class FetchRegistrationsProvider
    extends AutoDisposeFutureProvider<RegistrationsResponse> {
  /// Provider to fetch paginated registrations data
  ///
  /// Copied from [fetchRegistrations].
  FetchRegistrationsProvider({
    required ({int page, String query}) queryData,
  }) : this._internal(
          (ref) => fetchRegistrations(
            ref as FetchRegistrationsRef,
            queryData: queryData,
          ),
          from: fetchRegistrationsProvider,
          name: r'fetchRegistrationsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$fetchRegistrationsHash,
          dependencies: FetchRegistrationsFamily._dependencies,
          allTransitiveDependencies:
              FetchRegistrationsFamily._allTransitiveDependencies,
          queryData: queryData,
        );

  FetchRegistrationsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.queryData,
  }) : super.internal();

  final ({int page, String query}) queryData;

  @override
  Override overrideWith(
    FutureOr<RegistrationsResponse> Function(FetchRegistrationsRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FetchRegistrationsProvider._internal(
        (ref) => create(ref as FetchRegistrationsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        queryData: queryData,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<RegistrationsResponse> createElement() {
    return _FetchRegistrationsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FetchRegistrationsProvider && other.queryData == queryData;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, queryData.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin FetchRegistrationsRef
    on AutoDisposeFutureProviderRef<RegistrationsResponse> {
  /// The parameter `queryData` of this provider.
  ({int page, String query}) get queryData;
}

class _FetchRegistrationsProviderElement
    extends AutoDisposeFutureProviderElement<RegistrationsResponse>
    with FetchRegistrationsRef {
  _FetchRegistrationsProviderElement(super.provider);

  @override
  ({int page, String query}) get queryData =>
      (origin as FetchRegistrationsProvider).queryData;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package

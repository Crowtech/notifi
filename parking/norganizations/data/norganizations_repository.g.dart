// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'norganizations_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$norganizationsRepositoryHash() =>
    r'802572be91b5f198d369fdfb171819c5325e26fc';

/// See also [norganizationsRepository].
@ProviderFor(norganizationsRepository)
final norganizationsRepositoryProvider =
    AutoDisposeProvider<NOrganizationsRepository>.internal(
  norganizationsRepository,
  name: r'norganizationsRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$norganizationsRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef NorganizationsRepositoryRef
    = AutoDisposeProviderRef<NOrganizationsRepository>;
String _$organizationHash() => r'60f431111f72bc63bd0a7d0b72e341a433922fcf';

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

/// Provider to fetch a movie by ID
///
/// Copied from [organization].
@ProviderFor(organization)
const organizationProvider = OrganizationFamily();

/// Provider to fetch a movie by ID
///
/// Copied from [organization].
class OrganizationFamily extends Family<AsyncValue<NOrganization>> {
  /// Provider to fetch a movie by ID
  ///
  /// Copied from [organization].
  const OrganizationFamily();

  /// Provider to fetch a movie by ID
  ///
  /// Copied from [organization].
  OrganizationProvider call({
    required int organizationId,
  }) {
    return OrganizationProvider(
      organizationId: organizationId,
    );
  }

  @override
  OrganizationProvider getProviderOverride(
    covariant OrganizationProvider provider,
  ) {
    return call(
      organizationId: provider.organizationId,
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
  String? get name => r'organizationProvider';
}

/// Provider to fetch a movie by ID
///
/// Copied from [organization].
class OrganizationProvider extends AutoDisposeFutureProvider<NOrganization> {
  /// Provider to fetch a movie by ID
  ///
  /// Copied from [organization].
  OrganizationProvider({
    required int organizationId,
  }) : this._internal(
          (ref) => organization(
            ref as OrganizationRef,
            organizationId: organizationId,
          ),
          from: organizationProvider,
          name: r'organizationProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$organizationHash,
          dependencies: OrganizationFamily._dependencies,
          allTransitiveDependencies:
              OrganizationFamily._allTransitiveDependencies,
          organizationId: organizationId,
        );

  OrganizationProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.organizationId,
  }) : super.internal();

  final int organizationId;

  @override
  Override overrideWith(
    FutureOr<NOrganization> Function(OrganizationRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: OrganizationProvider._internal(
        (ref) => create(ref as OrganizationRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        organizationId: organizationId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<NOrganization> createElement() {
    return _OrganizationProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is OrganizationProvider &&
        other.organizationId == organizationId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, organizationId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin OrganizationRef on AutoDisposeFutureProviderRef<NOrganization> {
  /// The parameter `organizationId` of this provider.
  int get organizationId;
}

class _OrganizationProviderElement
    extends AutoDisposeFutureProviderElement<NOrganization>
    with OrganizationRef {
  _OrganizationProviderElement(super.provider);

  @override
  int get organizationId => (origin as OrganizationProvider).organizationId;
}

String _$fetchNOrganizationsHash() =>
    r'74c4fd346d6859452111e8cb998448db839294b3';

/// Provider to fetch paginated organizations data
///
/// Copied from [fetchNOrganizations].
@ProviderFor(fetchNOrganizations)
const fetchNOrganizationsProvider = FetchNOrganizationsFamily();

/// Provider to fetch paginated organizations data
///
/// Copied from [fetchNOrganizations].
class FetchNOrganizationsFamily
    extends Family<AsyncValue<NOrganizationsResponse>> {
  /// Provider to fetch paginated organizations data
  ///
  /// Copied from [fetchNOrganizations].
  const FetchNOrganizationsFamily();

  /// Provider to fetch paginated organizations data
  ///
  /// Copied from [fetchNOrganizations].
  FetchNOrganizationsProvider call({
    required ({int page, String query}) queryData,
  }) {
    return FetchNOrganizationsProvider(
      queryData: queryData,
    );
  }

  @override
  FetchNOrganizationsProvider getProviderOverride(
    covariant FetchNOrganizationsProvider provider,
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
  String? get name => r'fetchNOrganizationsProvider';
}

/// Provider to fetch paginated organizations data
///
/// Copied from [fetchNOrganizations].
class FetchNOrganizationsProvider
    extends AutoDisposeFutureProvider<NOrganizationsResponse> {
  /// Provider to fetch paginated organizations data
  ///
  /// Copied from [fetchNOrganizations].
  FetchNOrganizationsProvider({
    required ({int page, String query}) queryData,
  }) : this._internal(
          (ref) => fetchNOrganizations(
            ref as FetchNOrganizationsRef,
            queryData: queryData,
          ),
          from: fetchNOrganizationsProvider,
          name: r'fetchNOrganizationsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$fetchNOrganizationsHash,
          dependencies: FetchNOrganizationsFamily._dependencies,
          allTransitiveDependencies:
              FetchNOrganizationsFamily._allTransitiveDependencies,
          queryData: queryData,
        );

  FetchNOrganizationsProvider._internal(
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
    FutureOr<NOrganizationsResponse> Function(FetchNOrganizationsRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FetchNOrganizationsProvider._internal(
        (ref) => create(ref as FetchNOrganizationsRef),
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
  AutoDisposeFutureProviderElement<NOrganizationsResponse> createElement() {
    return _FetchNOrganizationsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FetchNOrganizationsProvider && other.queryData == queryData;
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
mixin FetchNOrganizationsRef
    on AutoDisposeFutureProviderRef<NOrganizationsResponse> {
  /// The parameter `queryData` of this provider.
  ({int page, String query}) get queryData;
}

class _FetchNOrganizationsProviderElement
    extends AutoDisposeFutureProviderElement<NOrganizationsResponse>
    with FetchNOrganizationsRef {
  _FetchNOrganizationsProviderElement(super.provider);

  @override
  ({int page, String query}) get queryData =>
      (origin as FetchNOrganizationsProvider).queryData;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package

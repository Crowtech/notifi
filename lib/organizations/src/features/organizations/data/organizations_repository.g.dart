// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'organizations_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$organizationsRepositoryHash() =>
    r'684a800c9a63ac20e8232933bfa6b891458b0367';

/// See also [organizationsRepository].
@ProviderFor(organizationsRepository)
final organizationsRepositoryProvider =
    AutoDisposeProvider<OrganizationsRepository>.internal(
  organizationsRepository,
  name: r'organizationsRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$organizationsRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef OrganizationsRepositoryRef
    = AutoDisposeProviderRef<OrganizationsRepository>;
String _$organizationHash() => r'ec2e28115bf886b9369600845ab291e89ed54381';

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

/// Provider to fetch a organization by ID
///
/// Copied from [organization].
@ProviderFor(organization)
const organizationProvider = OrganizationFamily();

/// Provider to fetch a organization by ID
///
/// Copied from [organization].
class OrganizationFamily extends Family<AsyncValue<NOrganization>> {
  /// Provider to fetch a organization by ID
  ///
  /// Copied from [organization].
  const OrganizationFamily();

  /// Provider to fetch a organization by ID
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

/// Provider to fetch a organization by ID
///
/// Copied from [organization].
class OrganizationProvider extends AutoDisposeFutureProvider<NOrganization> {
  /// Provider to fetch a organization by ID
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

String _$fetchOrganizationsHash() =>
    r'dec90a3a10bc345344eca266f28d547f09b0411b';

/// Provider to fetch paginated organizations data
///
/// Copied from [fetchOrganizations].
@ProviderFor(fetchOrganizations)
const fetchOrganizationsProvider = FetchOrganizationsFamily();

/// Provider to fetch paginated organizations data
///
/// Copied from [fetchOrganizations].
class FetchOrganizationsFamily
    extends Family<AsyncValue<NOrganizationsResponse>> {
  /// Provider to fetch paginated organizations data
  ///
  /// Copied from [fetchOrganizations].
  const FetchOrganizationsFamily();

  /// Provider to fetch paginated organizations data
  ///
  /// Copied from [fetchOrganizations].
  FetchOrganizationsProvider call({
    required ({int page, String query}) queryData,
  }) {
    return FetchOrganizationsProvider(
      queryData: queryData,
    );
  }

  @override
  FetchOrganizationsProvider getProviderOverride(
    covariant FetchOrganizationsProvider provider,
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
  String? get name => r'fetchOrganizationsProvider';
}

/// Provider to fetch paginated organizations data
///
/// Copied from [fetchOrganizations].
class FetchOrganizationsProvider
    extends AutoDisposeFutureProvider<NOrganizationsResponse> {
  /// Provider to fetch paginated organizations data
  ///
  /// Copied from [fetchOrganizations].
  FetchOrganizationsProvider({
    required ({int page, String query}) queryData,
  }) : this._internal(
          (ref) => fetchOrganizations(
            ref as FetchOrganizationsRef,
            queryData: queryData,
          ),
          from: fetchOrganizationsProvider,
          name: r'fetchOrganizationsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$fetchOrganizationsHash,
          dependencies: FetchOrganizationsFamily._dependencies,
          allTransitiveDependencies:
              FetchOrganizationsFamily._allTransitiveDependencies,
          queryData: queryData,
        );

  FetchOrganizationsProvider._internal(
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
    FutureOr<NOrganizationsResponse> Function(FetchOrganizationsRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FetchOrganizationsProvider._internal(
        (ref) => create(ref as FetchOrganizationsRef),
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
    return _FetchOrganizationsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FetchOrganizationsProvider && other.queryData == queryData;
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
mixin FetchOrganizationsRef
    on AutoDisposeFutureProviderRef<NOrganizationsResponse> {
  /// The parameter `queryData` of this provider.
  ({int page, String query}) get queryData;
}

class _FetchOrganizationsProviderElement
    extends AutoDisposeFutureProviderElement<NOrganizationsResponse>
    with FetchOrganizationsRef {
  _FetchOrganizationsProviderElement(super.provider);

  @override
  ({int page, String query}) get queryData =>
      (origin as FetchOrganizationsProvider).queryData;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package

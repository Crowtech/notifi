// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'organizations_repository_nf.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$organizationsRepositoryNestFilterHash() =>
    r'92d24feebe0da67c644219721b91b14f2b1884ca';

/// See also [organizationsRepositoryNestFilter].
@ProviderFor(organizationsRepositoryNestFilter)
final organizationsRepositoryNestFilterProvider =
    AutoDisposeProvider<OrganizationsRepositoryNestFilter>.internal(
  organizationsRepositoryNestFilter,
  name: r'organizationsRepositoryNestFilterProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$organizationsRepositoryNestFilterHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef OrganizationsRepositoryNestFilterRef
    = AutoDisposeProviderRef<OrganizationsRepositoryNestFilter>;
String _$organization2Hash() => r'a0c0ed97d628b88242996a0971c2b40d941794ca';

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
/// Copied from [organization2].
@ProviderFor(organization2)
const organization2Provider = Organization2Family();

/// Provider to fetch a organization by ID
///
/// Copied from [organization2].
class Organization2Family extends Family<AsyncValue<Organization>> {
  /// Provider to fetch a organization by ID
  ///
  /// Copied from [organization2].
  const Organization2Family();

  /// Provider to fetch a organization by ID
  ///
  /// Copied from [organization2].
  Organization2Provider call({
    required int organizationId,
  }) {
    return Organization2Provider(
      organizationId: organizationId,
    );
  }

  @override
  Organization2Provider getProviderOverride(
    covariant Organization2Provider provider,
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
  String? get name => r'organization2Provider';
}

/// Provider to fetch a organization by ID
///
/// Copied from [organization2].
class Organization2Provider extends AutoDisposeFutureProvider<Organization> {
  /// Provider to fetch a organization by ID
  ///
  /// Copied from [organization2].
  Organization2Provider({
    required int organizationId,
  }) : this._internal(
          (ref) => organization2(
            ref as Organization2Ref,
            organizationId: organizationId,
          ),
          from: organization2Provider,
          name: r'organization2Provider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$organization2Hash,
          dependencies: Organization2Family._dependencies,
          allTransitiveDependencies:
              Organization2Family._allTransitiveDependencies,
          organizationId: organizationId,
        );

  Organization2Provider._internal(
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
    FutureOr<Organization> Function(Organization2Ref provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: Organization2Provider._internal(
        (ref) => create(ref as Organization2Ref),
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
  AutoDisposeFutureProviderElement<Organization> createElement() {
    return _Organization2ProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is Organization2Provider &&
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
mixin Organization2Ref on AutoDisposeFutureProviderRef<Organization> {
  /// The parameter `organizationId` of this provider.
  int get organizationId;
}

class _Organization2ProviderElement
    extends AutoDisposeFutureProviderElement<Organization>
    with Organization2Ref {
  _Organization2ProviderElement(super.provider);

  @override
  int get organizationId => (origin as Organization2Provider).organizationId;
}

String _$fetchOrganizationsNestFilterHash() =>
    r'9245314ab3c2aada527f23a495ddf6df0ad8890d';

/// Provider to fetch paginated organizations data
///
/// Copied from [fetchOrganizationsNestFilter].
@ProviderFor(fetchOrganizationsNestFilter)
const fetchOrganizationsNestFilterProvider =
    FetchOrganizationsNestFilterFamily();

/// Provider to fetch paginated organizations data
///
/// Copied from [fetchOrganizationsNestFilter].
class FetchOrganizationsNestFilterFamily
    extends Family<AsyncValue<OrganizationsResponse>> {
  /// Provider to fetch paginated organizations data
  ///
  /// Copied from [fetchOrganizationsNestFilter].
  const FetchOrganizationsNestFilterFamily();

  /// Provider to fetch paginated organizations data
  ///
  /// Copied from [fetchOrganizationsNestFilter].
  FetchOrganizationsNestFilterProvider call({
    required NestFilter nestFilter,
  }) {
    return FetchOrganizationsNestFilterProvider(
      nestFilter: nestFilter,
    );
  }

  @override
  FetchOrganizationsNestFilterProvider getProviderOverride(
    covariant FetchOrganizationsNestFilterProvider provider,
  ) {
    return call(
      nestFilter: provider.nestFilter,
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
  String? get name => r'fetchOrganizationsNestFilterProvider';
}

/// Provider to fetch paginated organizations data
///
/// Copied from [fetchOrganizationsNestFilter].
class FetchOrganizationsNestFilterProvider
    extends AutoDisposeFutureProvider<OrganizationsResponse> {
  /// Provider to fetch paginated organizations data
  ///
  /// Copied from [fetchOrganizationsNestFilter].
  FetchOrganizationsNestFilterProvider({
    required NestFilter nestFilter,
  }) : this._internal(
          (ref) => fetchOrganizationsNestFilter(
            ref as FetchOrganizationsNestFilterRef,
            nestFilter: nestFilter,
          ),
          from: fetchOrganizationsNestFilterProvider,
          name: r'fetchOrganizationsNestFilterProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$fetchOrganizationsNestFilterHash,
          dependencies: FetchOrganizationsNestFilterFamily._dependencies,
          allTransitiveDependencies:
              FetchOrganizationsNestFilterFamily._allTransitiveDependencies,
          nestFilter: nestFilter,
        );

  FetchOrganizationsNestFilterProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.nestFilter,
  }) : super.internal();

  final NestFilter nestFilter;

  @override
  Override overrideWith(
    FutureOr<OrganizationsResponse> Function(
            FetchOrganizationsNestFilterRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FetchOrganizationsNestFilterProvider._internal(
        (ref) => create(ref as FetchOrganizationsNestFilterRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        nestFilter: nestFilter,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<OrganizationsResponse> createElement() {
    return _FetchOrganizationsNestFilterProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FetchOrganizationsNestFilterProvider &&
        other.nestFilter == nestFilter;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, nestFilter.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin FetchOrganizationsNestFilterRef
    on AutoDisposeFutureProviderRef<OrganizationsResponse> {
  /// The parameter `nestFilter` of this provider.
  NestFilter get nestFilter;
}

class _FetchOrganizationsNestFilterProviderElement
    extends AutoDisposeFutureProviderElement<OrganizationsResponse>
    with FetchOrganizationsNestFilterRef {
  _FetchOrganizationsNestFilterProviderElement(super.provider);

  @override
  NestFilter get nestFilter =>
      (origin as FetchOrganizationsNestFilterProvider).nestFilter;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package

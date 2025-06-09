// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'npersons_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$npersonsRepositoryHash() =>
    r'2a6bf96399391a9e3eccee34dd21833a7d2d1b7c';

/// See also [npersonsRepository].
@ProviderFor(npersonsRepository)
final npersonsRepositoryProvider =
    AutoDisposeProvider<NPersonsRepository>.internal(
  npersonsRepository,
  name: r'npersonsRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$npersonsRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef NpersonsRepositoryRef = AutoDisposeProviderRef<NPersonsRepository>;
String _$personHash() => r'130b593ec4c7bb2ec391edb99bdc6a125d3556ea';

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
/// Copied from [person].
@ProviderFor(person)
const personProvider = PersonFamily();

/// Provider to fetch a movie by ID
///
/// Copied from [person].
class PersonFamily extends Family<AsyncValue<NPerson>> {
  /// Provider to fetch a movie by ID
  ///
  /// Copied from [person].
  const PersonFamily();

  /// Provider to fetch a movie by ID
  ///
  /// Copied from [person].
  PersonProvider call({
    required int personId,
  }) {
    return PersonProvider(
      personId: personId,
    );
  }

  @override
  PersonProvider getProviderOverride(
    covariant PersonProvider provider,
  ) {
    return call(
      personId: provider.personId,
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
  String? get name => r'personProvider';
}

/// Provider to fetch a movie by ID
///
/// Copied from [person].
class PersonProvider extends AutoDisposeFutureProvider<NPerson> {
  /// Provider to fetch a movie by ID
  ///
  /// Copied from [person].
  PersonProvider({
    required int personId,
  }) : this._internal(
          (ref) => person(
            ref as PersonRef,
            personId: personId,
          ),
          from: personProvider,
          name: r'personProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$personHash,
          dependencies: PersonFamily._dependencies,
          allTransitiveDependencies: PersonFamily._allTransitiveDependencies,
          personId: personId,
        );

  PersonProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.personId,
  }) : super.internal();

  final int personId;

  @override
  Override overrideWith(
    FutureOr<NPerson> Function(PersonRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: PersonProvider._internal(
        (ref) => create(ref as PersonRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        personId: personId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<NPerson> createElement() {
    return _PersonProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PersonProvider && other.personId == personId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, personId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin PersonRef on AutoDisposeFutureProviderRef<NPerson> {
  /// The parameter `personId` of this provider.
  int get personId;
}

class _PersonProviderElement extends AutoDisposeFutureProviderElement<NPerson>
    with PersonRef {
  _PersonProviderElement(super.provider);

  @override
  int get personId => (origin as PersonProvider).personId;
}

String _$fetchNPersonsHash() => r'bbe6bbb00ede3c2d73c2d4e2c1c0a60957f1820d';

/// Provider to fetch paginated movies data
///
/// Copied from [fetchNPersons].
@ProviderFor(fetchNPersons)
const fetchNPersonsProvider = FetchNPersonsFamily();

/// Provider to fetch paginated movies data
///
/// Copied from [fetchNPersons].
class FetchNPersonsFamily extends Family<AsyncValue<NPersonsResponse>> {
  /// Provider to fetch paginated movies data
  ///
  /// Copied from [fetchNPersons].
  const FetchNPersonsFamily();

  /// Provider to fetch paginated movies data
  ///
  /// Copied from [fetchNPersons].
  FetchNPersonsProvider call({
    required ({int page, String query}) queryData,
  }) {
    return FetchNPersonsProvider(
      queryData: queryData,
    );
  }

  @override
  FetchNPersonsProvider getProviderOverride(
    covariant FetchNPersonsProvider provider,
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
  String? get name => r'fetchNPersonsProvider';
}

/// Provider to fetch paginated movies data
///
/// Copied from [fetchNPersons].
class FetchNPersonsProvider
    extends AutoDisposeFutureProvider<NPersonsResponse> {
  /// Provider to fetch paginated movies data
  ///
  /// Copied from [fetchNPersons].
  FetchNPersonsProvider({
    required ({int page, String query}) queryData,
  }) : this._internal(
          (ref) => fetchNPersons(
            ref as FetchNPersonsRef,
            queryData: queryData,
          ),
          from: fetchNPersonsProvider,
          name: r'fetchNPersonsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$fetchNPersonsHash,
          dependencies: FetchNPersonsFamily._dependencies,
          allTransitiveDependencies:
              FetchNPersonsFamily._allTransitiveDependencies,
          queryData: queryData,
        );

  FetchNPersonsProvider._internal(
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
    FutureOr<NPersonsResponse> Function(FetchNPersonsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FetchNPersonsProvider._internal(
        (ref) => create(ref as FetchNPersonsRef),
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
  AutoDisposeFutureProviderElement<NPersonsResponse> createElement() {
    return _FetchNPersonsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FetchNPersonsProvider && other.queryData == queryData;
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
mixin FetchNPersonsRef on AutoDisposeFutureProviderRef<NPersonsResponse> {
  /// The parameter `queryData` of this provider.
  ({int page, String query}) get queryData;
}

class _FetchNPersonsProviderElement
    extends AutoDisposeFutureProviderElement<NPersonsResponse>
    with FetchNPersonsRef {
  _FetchNPersonsProviderElement(super.provider);

  @override
  ({int page, String query}) get queryData =>
      (origin as FetchNPersonsProvider).queryData;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package

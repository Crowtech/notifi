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
String _$personHash() => r'2c332d36800481dbbd0bc26d6182fc6c2d382a71';

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
    required int movieId,
  }) {
    return PersonProvider(
      movieId: movieId,
    );
  }

  @override
  PersonProvider getProviderOverride(
    covariant PersonProvider provider,
  ) {
    return call(
      movieId: provider.movieId,
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
    required int movieId,
  }) : this._internal(
          (ref) => person(
            ref as PersonRef,
            movieId: movieId,
          ),
          from: personProvider,
          name: r'personProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$personHash,
          dependencies: PersonFamily._dependencies,
          allTransitiveDependencies: PersonFamily._allTransitiveDependencies,
          movieId: movieId,
        );

  PersonProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.movieId,
  }) : super.internal();

  final int movieId;

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
        movieId: movieId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<NPerson> createElement() {
    return _PersonProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PersonProvider && other.movieId == movieId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, movieId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin PersonRef on AutoDisposeFutureProviderRef<NPerson> {
  /// The parameter `movieId` of this provider.
  int get movieId;
}

class _PersonProviderElement extends AutoDisposeFutureProviderElement<NPerson>
    with PersonRef {
  _PersonProviderElement(super.provider);

  @override
  int get movieId => (origin as PersonProvider).movieId;
}

String _$fetchNPersonsHash() => r'a032acc160d8ad9a0e5c9f324e4eceac0a061fe8';

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

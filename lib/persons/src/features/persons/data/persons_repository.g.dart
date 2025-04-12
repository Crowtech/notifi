// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'persons_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$personsRepositoryHash() => r'6c2ec24f561bb955d8e9e98fbacaa749e8d381c0';

/// See also [personsRepository].
@ProviderFor(personsRepository)
final personsRepositoryProvider =
    AutoDisposeProvider<PersonsRepository>.internal(
  personsRepository,
  name: r'personsRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$personsRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef PersonsRepositoryRef = AutoDisposeProviderRef<PersonsRepository>;
String _$personHash() => r'7b968001bf5e3e4925030142ea956dd26cbd367c';

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

/// Provider to fetch a person by ID
///
/// Copied from [person].
@ProviderFor(person)
const personProvider = PersonFamily();

/// Provider to fetch a person by ID
///
/// Copied from [person].
class PersonFamily extends Family<AsyncValue<NPerson>> {
  /// Provider to fetch a person by ID
  ///
  /// Copied from [person].
  const PersonFamily();

  /// Provider to fetch a person by ID
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

/// Provider to fetch a person by ID
///
/// Copied from [person].
class PersonProvider extends AutoDisposeFutureProvider<NPerson> {
  /// Provider to fetch a person by ID
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

String _$fetchPersonsHash() => r'b24a9df50b26e6b4fb1d4753fa875cd4ed8d3b83';

/// Provider to fetch paginated persons data
///
/// Copied from [fetchPersons].
@ProviderFor(fetchPersons)
const fetchPersonsProvider = FetchPersonsFamily();

/// Provider to fetch paginated persons data
///
/// Copied from [fetchPersons].
class FetchPersonsFamily extends Family<AsyncValue<NPersonsResponse>> {
  /// Provider to fetch paginated persons data
  ///
  /// Copied from [fetchPersons].
  const FetchPersonsFamily();

  /// Provider to fetch paginated persons data
  ///
  /// Copied from [fetchPersons].
  FetchPersonsProvider call({
    required ({int page, String query}) queryData,
  }) {
    return FetchPersonsProvider(
      queryData: queryData,
    );
  }

  @override
  FetchPersonsProvider getProviderOverride(
    covariant FetchPersonsProvider provider,
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
  String? get name => r'fetchPersonsProvider';
}

/// Provider to fetch paginated persons data
///
/// Copied from [fetchPersons].
class FetchPersonsProvider extends AutoDisposeFutureProvider<NPersonsResponse> {
  /// Provider to fetch paginated persons data
  ///
  /// Copied from [fetchPersons].
  FetchPersonsProvider({
    required ({int page, String query}) queryData,
  }) : this._internal(
          (ref) => fetchPersons(
            ref as FetchPersonsRef,
            queryData: queryData,
          ),
          from: fetchPersonsProvider,
          name: r'fetchPersonsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$fetchPersonsHash,
          dependencies: FetchPersonsFamily._dependencies,
          allTransitiveDependencies:
              FetchPersonsFamily._allTransitiveDependencies,
          queryData: queryData,
        );

  FetchPersonsProvider._internal(
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
    FutureOr<NPersonsResponse> Function(FetchPersonsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FetchPersonsProvider._internal(
        (ref) => create(ref as FetchPersonsRef),
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
    return _FetchPersonsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FetchPersonsProvider && other.queryData == queryData;
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
mixin FetchPersonsRef on AutoDisposeFutureProviderRef<NPersonsResponse> {
  /// The parameter `queryData` of this provider.
  ({int page, String query}) get queryData;
}

class _FetchPersonsProviderElement
    extends AutoDisposeFutureProviderElement<NPersonsResponse>
    with FetchPersonsRef {
  _FetchPersonsProviderElement(super.provider);

  @override
  ({int page, String query}) get queryData =>
      (origin as FetchPersonsProvider).queryData;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package

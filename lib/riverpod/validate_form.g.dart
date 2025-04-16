// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'validate_form.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$validateFormHash() => r'69da5a0d1cb8ff71b060176d2ec36538bc3d096a';

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

abstract class _$ValidateForm extends BuildlessAutoDisposeNotifier<bool> {
  late final String code;

  bool build(
    String code,
  );
}

/// See also [ValidateForm].
@ProviderFor(ValidateForm)
const validateFormProvider = ValidateFormFamily();

/// See also [ValidateForm].
class ValidateFormFamily extends Family<bool> {
  /// See also [ValidateForm].
  const ValidateFormFamily();

  /// See also [ValidateForm].
  ValidateFormProvider call(
    String code,
  ) {
    return ValidateFormProvider(
      code,
    );
  }

  @override
  ValidateFormProvider getProviderOverride(
    covariant ValidateFormProvider provider,
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
  String? get name => r'validateFormProvider';
}

/// See also [ValidateForm].
class ValidateFormProvider
    extends AutoDisposeNotifierProviderImpl<ValidateForm, bool> {
  /// See also [ValidateForm].
  ValidateFormProvider(
    String code,
  ) : this._internal(
          () => ValidateForm()..code = code,
          from: validateFormProvider,
          name: r'validateFormProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$validateFormHash,
          dependencies: ValidateFormFamily._dependencies,
          allTransitiveDependencies:
              ValidateFormFamily._allTransitiveDependencies,
          code: code,
        );

  ValidateFormProvider._internal(
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
  bool runNotifierBuild(
    covariant ValidateForm notifier,
  ) {
    return notifier.build(
      code,
    );
  }

  @override
  Override overrideWith(ValidateForm Function() create) {
    return ProviderOverride(
      origin: this,
      override: ValidateFormProvider._internal(
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
  AutoDisposeNotifierProviderElement<ValidateForm, bool> createElement() {
    return _ValidateFormProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ValidateFormProvider && other.code == code;
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
mixin ValidateFormRef on AutoDisposeNotifierProviderRef<bool> {
  /// The parameter `code` of this provider.
  String get code;
}

class _ValidateFormProviderElement
    extends AutoDisposeNotifierProviderElement<ValidateForm, bool>
    with ValidateFormRef {
  _ValidateFormProviderElement(super.provider);

  @override
  String get code => (origin as ValidateFormProvider).code;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package

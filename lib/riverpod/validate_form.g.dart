// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'validate_form.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$initialFormValidationsHash() =>
    r'23183d850aab82fbca09f3db98e07aaf69952a0a';

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

abstract class _$InitialFormValidations
    extends BuildlessNotifier<Map<String, bool>> {
  late final String code;

  Map<String, bool> build(
    String code,
  );
}

/// See also [InitialFormValidations].
@ProviderFor(InitialFormValidations)
const initialFormValidationsProvider = InitialFormValidationsFamily();

/// See also [InitialFormValidations].
class InitialFormValidationsFamily extends Family<Map<String, bool>> {
  /// See also [InitialFormValidations].
  const InitialFormValidationsFamily();

  /// See also [InitialFormValidations].
  InitialFormValidationsProvider call(
    String code,
  ) {
    return InitialFormValidationsProvider(
      code,
    );
  }

  @override
  InitialFormValidationsProvider getProviderOverride(
    covariant InitialFormValidationsProvider provider,
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
  String? get name => r'initialFormValidationsProvider';
}

/// See also [InitialFormValidations].
class InitialFormValidationsProvider
    extends NotifierProviderImpl<InitialFormValidations, Map<String, bool>> {
  /// See also [InitialFormValidations].
  InitialFormValidationsProvider(
    String code,
  ) : this._internal(
          () => InitialFormValidations()..code = code,
          from: initialFormValidationsProvider,
          name: r'initialFormValidationsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$initialFormValidationsHash,
          dependencies: InitialFormValidationsFamily._dependencies,
          allTransitiveDependencies:
              InitialFormValidationsFamily._allTransitiveDependencies,
          code: code,
        );

  InitialFormValidationsProvider._internal(
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
  Map<String, bool> runNotifierBuild(
    covariant InitialFormValidations notifier,
  ) {
    return notifier.build(
      code,
    );
  }

  @override
  Override overrideWith(InitialFormValidations Function() create) {
    return ProviderOverride(
      origin: this,
      override: InitialFormValidationsProvider._internal(
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
  NotifierProviderElement<InitialFormValidations, Map<String, bool>>
      createElement() {
    return _InitialFormValidationsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is InitialFormValidationsProvider && other.code == code;
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
mixin InitialFormValidationsRef on NotifierProviderRef<Map<String, bool>> {
  /// The parameter `code` of this provider.
  String get code;
}

class _InitialFormValidationsProviderElement
    extends NotifierProviderElement<InitialFormValidations, Map<String, bool>>
    with InitialFormValidationsRef {
  _InitialFormValidationsProviderElement(super.provider);

  @override
  String get code => (origin as InitialFormValidationsProvider).code;
}

String _$validateFormHash() => r'0ff96b238ef6055984ebaf795108b68766cfedd3';

abstract class _$ValidateForm extends BuildlessNotifier<bool> {
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
class ValidateFormProvider extends NotifierProviderImpl<ValidateForm, bool> {
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
  NotifierProviderElement<ValidateForm, bool> createElement() {
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
mixin ValidateFormRef on NotifierProviderRef<bool> {
  /// The parameter `code` of this provider.
  String get code;
}

class _ValidateFormProviderElement
    extends NotifierProviderElement<ValidateForm, bool> with ValidateFormRef {
  _ValidateFormProviderElement(super.provider);

  @override
  String get code => (origin as ValidateFormProvider).code;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package

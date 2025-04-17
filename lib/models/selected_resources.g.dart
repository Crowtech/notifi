// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'selected_resources.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SelectedResourcesImpl _$$SelectedResourcesImplFromJson(
        Map<String, dynamic> json) =>
    _$SelectedResourcesImpl(
      selectedResourceIds: (json['selectedResourceIds'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      unselectedResourceIds: (json['unselectedResourceIds'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
    );

Map<String, dynamic> _$$SelectedResourcesImplToJson(
        _$SelectedResourcesImpl instance) =>
    <String, dynamic>{
      'selectedResourceIds': instance.selectedResourceIds,
      'unselectedResourceIds': instance.unselectedResourceIds,
    };

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$asyncSelectedResourcesHash() =>
    r'c136f654adaf9c7d535e399b64e080b6351a32c8';

/// See also [AsyncSelectedResources].
@ProviderFor(AsyncSelectedResources)
final asyncSelectedResourcesProvider = AutoDisposeAsyncNotifierProvider<
    AsyncSelectedResources, SelectedResources>.internal(
  AsyncSelectedResources.new,
  name: r'asyncSelectedResourcesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$asyncSelectedResourcesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AsyncSelectedResources = AutoDisposeAsyncNotifier<SelectedResources>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package

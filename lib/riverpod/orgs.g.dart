// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orgs.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OrgImpl _$$OrgImplFromJson(Map<String, dynamic> json) => _$OrgImpl(
  orgid: (json['orgid'] as num).toInt(),
  id: (json['id'] as num).toInt(),
  code: json['code'] as String,
  created: DateTime.parse(json['created'] as String),
  updated: DateTime.parse(json['updated'] as String),
  name: json['name'] as String,
  description: json['description'] as String,
  location: json['location'] as String,
  devicecode: json['devicecode'] as String,
  avatarUrl: json['avatarUrl'] as String,
  gps: GPS.fromJson(json['gps'] as Map<String, dynamic>),
  selected: json['selected'] as bool,
  orgType: json['orgType'] as String,
  url: json['url'] as String,
);

Map<String, dynamic> _$$OrgImplToJson(_$OrgImpl instance) => <String, dynamic>{
  'orgid': instance.orgid,
  'id': instance.id,
  'code': instance.code,
  'created': instance.created.toIso8601String(),
  'updated': instance.updated.toIso8601String(),
  'name': instance.name,
  'description': instance.description,
  'location': instance.location,
  'devicecode': instance.devicecode,
  'avatarUrl': instance.avatarUrl,
  'gps': instance.gps,
  'selected': instance.selected,
  'orgType': instance.orgType,
  'url': instance.url,
};

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$asyncOrgsHash() => r'f46ec11eff2b56f9745f8a95bf0d31190b13c72a';

/// See also [AsyncOrgs].
@ProviderFor(AsyncOrgs)
final asyncOrgsProvider =
    AutoDisposeAsyncNotifierProvider<AsyncOrgs, List<Org>>.internal(
      AsyncOrgs.new,
      name: r'asyncOrgsProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$asyncOrgsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$AsyncOrgs = AutoDisposeAsyncNotifier<List<Org>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package

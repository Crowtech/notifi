// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nestfilter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NestFilter _$NestFilterFromJson(Map<String, dynamic> json) => NestFilter(
      orgIdList: (json['orgIdList'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      resourceCodeList: (json['resourceCodeList'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      resourceIdList: (json['resourceIdList'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      deviceCodeList: (json['deviceCodeList'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      query: json['query'] as String,
      limit: (json['limit'] as num).toInt(),
      offset: (json['offset'] as num).toInt(),
      sortby: json['sortby'] as String,
      caseinsensitive: json['caseinsensitive'] as bool,
      distinctField: json['distinctField'] as String,
    );

Map<String, dynamic> _$NestFilterToJson(NestFilter instance) =>
    <String, dynamic>{
      'orgIdList': instance.orgIdList,
      'resourceCodeList': instance.resourceCodeList,
      'resourceIdList': instance.resourceIdList,
      'deviceCodeList': instance.deviceCodeList,
      'query': instance.query,
      'limit': instance.limit,
      'offset': instance.offset,
      'sortby': instance.sortby,
      'caseinsensitive': instance.caseinsensitive,
      'distinctField': instance.distinctField,
    };

_$NestFilterImpl _$$NestFilterImplFromJson(Map<String, dynamic> json) =>
    _$NestFilterImpl(
      orgIdList: (json['orgIdList'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          const [],
      resourceCodeList: (json['resourceCodeList'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      resourceIdList: (json['resourceIdList'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          const [],
      deviceCodeList: (json['deviceCodeList'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      query: json['query'] as String? ?? '',
      limit: (json['limit'] as num?)?.toInt() ?? 10,
      offset: (json['offset'] as num?)?.toInt() ?? 0,
      sortby: json['sortby'] as String? ?? '',
      caseinsensitive: json['caseinsensitive'] as bool? ?? true,
      distinctField: json['distinctField'] as String? ?? '',
    );

Map<String, dynamic> _$$NestFilterImplToJson(_$NestFilterImpl instance) =>
    <String, dynamic>{
      'orgIdList': instance.orgIdList,
      'resourceCodeList': instance.resourceCodeList,
      'resourceIdList': instance.resourceIdList,
      'deviceCodeList': instance.deviceCodeList,
      'query': instance.query,
      'limit': instance.limit,
      'offset': instance.offset,
      'sortby': instance.sortby,
      'caseinsensitive': instance.caseinsensitive,
      'distinctField': instance.distinctField,
    };

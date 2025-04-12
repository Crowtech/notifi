// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nestfilter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NestFilter _$NestFilterFromJson(Map<String, dynamic> json) => NestFilter(
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
      targetIdList: (json['targetIdList'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          const [],
      deviceCodeList: (json['deviceCodeList'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      query: json['query'] as String? ?? "",
      offset: (json['offset'] as num?)?.toInt() ?? 0,
      limit: (json['limit'] as num?)?.toInt() ?? 10,
      sortby: json['sortby'] as String? ?? "",
      caseinsensitive: json['caseinsensitive'] as bool? ?? true,
      distinctField: json['distinctField'] as String? ?? "",
      includeGPS: json['includeGPS'] as bool? ?? true,
    );

Map<String, dynamic> _$NestFilterToJson(NestFilter instance) =>
    <String, dynamic>{
      'orgIdList': instance.orgIdList,
      'resourceCodeList': instance.resourceCodeList,
      'resourceIdList': instance.resourceIdList,
      'targetIdList': instance.targetIdList,
      'deviceCodeList': instance.deviceCodeList,
      'query': instance.query,
      'limit': instance.limit,
      'offset': instance.offset,
      'sortby': instance.sortby,
      'caseinsensitive': instance.caseinsensitive,
      'distinctField': instance.distinctField,
      'includeGPS': instance.includeGPS,
    };

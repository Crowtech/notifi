// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'crowtech_basepage.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CrowtechBasePage<T> _$CrowtechBasePageFromJson<T extends CrowtechBase<dynamic>>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    CrowtechBasePage<T>(
      created: json['created'] == null
          ? null
          : DateTime.parse(json['created'] as String),
      startIndex: (json['startIndex'] as num?)?.toInt(),
      items: (json['items'] as List<dynamic>?)?.map(fromJsonT).toList(),
      totalItems: (json['totalItems'] as num?)?.toInt(),
      processingTime: (json['processingTime'] as num?)?.toInt(),
    );

Map<String, dynamic> _$CrowtechBasePageToJson<T extends CrowtechBase<dynamic>>(
  CrowtechBasePage<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'created': instance.created?.toIso8601String(),
      'startIndex': instance.startIndex,
      'items': instance.items?.map(toJsonT).toList(),
      'totalItems': instance.totalItems,
      'processingTime': instance.processingTime,
    };

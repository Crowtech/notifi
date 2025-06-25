// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'registrations_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RegistrationsResponse _$RegistrationsResponseFromJson(
        Map<String, dynamic> json) =>
    _RegistrationsResponse(
      startIndex: (json['startIndex'] as num).toInt(),
      items: (json['items'] as List<dynamic>)
          .map((e) => Registration.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalResults: (json['total_results'] as num).toInt(),
      totalItems: (json['totalItems'] as num).toInt(),
      errors: (json['errors'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$RegistrationsResponseToJson(
        _RegistrationsResponse instance) =>
    <String, dynamic>{
      'startIndex': instance.startIndex,
      'items': instance.items,
      'total_results': instance.totalResults,
      'totalItems': instance.totalItems,
      'errors': instance.errors,
    };

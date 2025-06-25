// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'registrations_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegistrationsResponse _$RegistrationsResponseFromJson(
        Map<String, dynamic> json) =>
    RegistrationsResponse(
      startIndex: (json['startIndex'] as num).toInt(),
      items: (json['items'] as List<dynamic>)
          .map((e) => Registration.fromJson(e as Map<String, dynamic>))
          .toList(),
      resultCount: (json['resultCount'] as num).toInt(),
      totalItems: (json['totalItems'] as num).toInt(),
    );

Map<String, dynamic> _$RegistrationsResponseToJson(
        RegistrationsResponse instance) =>
    <String, dynamic>{
      'startIndex': instance.startIndex,
      'items': instance.items,
      'resultCount': instance.resultCount,
      'totalItems': instance.totalItems,
    };

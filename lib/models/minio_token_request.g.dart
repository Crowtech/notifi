// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'minio_token_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MinioTokenRequest _$MinioTokenRequestFromJson(Map<String, dynamic> json) =>
    MinioTokenRequest(
      WebIdentityToken: json['WebIdentityToken'] as String,
    )
      ..Action = json['Action'] as String
      ..Version = json['Version'] as String
      ..DurationSeconds = json['DurationSeconds'] as String;

Map<String, dynamic> _$MinioTokenRequestToJson(MinioTokenRequest instance) =>
    <String, dynamic>{
      'Action': instance.Action,
      'Version': instance.Version,
      'DurationSeconds': instance.DurationSeconds,
      'WebIdentityToken': instance.WebIdentityToken,
    };

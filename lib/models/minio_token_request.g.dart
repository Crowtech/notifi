// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'minio_token_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MinioTokenRequest _$MinioTokenRequestFromJson(Map<String, dynamic> json) =>
    MinioTokenRequest(
      WebidentityToken: json['WebidentityToken'] as String,
    )
      ..Action = json['Action'] as String
      ..Version = json['Version'] as String
      ..Duration = (json['Duration'] as num).toInt();

Map<String, dynamic> _$MinioTokenRequestToJson(MinioTokenRequest instance) =>
    <String, dynamic>{
      'Action': instance.Action,
      'Version': instance.Version,
      'Duration': instance.Duration,
      'WebidentityToken': instance.WebidentityToken,
    };

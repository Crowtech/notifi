import 'package:json_annotation/json_annotation.dart';

import 'package:logger/logger.dart';
part 'minio_token_request.g.dart';

var logger = Logger(
  printer: PrettyPrinter(),
);

@JsonSerializable(explicitToJson: true)
class MinioTokenRequest {
  static String className = "MinioTokenRequest";
  static String tablename = className.toLowerCase();

  String Action = 'AssumeRoleWithWebIdentity';
  String Version = '2011-06-15';
  String DurationSeconds = "86000";
  String WebIdentityToken;

  MinioTokenRequest({required this.WebIdentityToken});

  factory MinioTokenRequest.fromJson(Map<String, dynamic> json) =>
      _$MinioTokenRequestFromJson(json);
  Map<String, dynamic> toJson() => _$MinioTokenRequestToJson(this);

  @override
  MinioTokenRequest fromJson(Map<String, dynamic> json) {
    return MinioTokenRequest.fromJson(json);
  }

  @override
  String toString() {
    return "MinioTokenRequest:$Action $Version $DurationSeconds $WebIdentityToken";
  }

  MinioTokenRequest copyWith({
    final String? query,
  }) {
    return MinioTokenRequest(
      WebIdentityToken: WebIdentityToken ?? WebIdentityToken,
    );
  }
}

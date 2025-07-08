library;

import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../../models/registration.dart';

part 'registrations_response.freezed.dart';
part 'registrations_response.g.dart';

@freezed
abstract class RegistrationsResponse with _$RegistrationsResponse {
  const factory RegistrationsResponse({
    @JsonKey(name: 'startIndex') int? startIndex,
    @JsonKey(name: 'items') List<Registration>? items,
    @JsonKey(name: 'resultCount') int? resultCount,
    @JsonKey(name: 'totalItems') int? totalItems,
  }) = _RegistrationsResponse;

  factory RegistrationsResponse.fromJson(Map<String, Object?> json)
      => _$RegistrationsResponseFromJson(json);
}

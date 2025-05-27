library core;

import 'package:freezed_annotation/freezed_annotation.dart';
import 'registration.dart';

part 'registrations_response.freezed.dart';
part 'registrations_response.g.dart';

@freezed
class RegistrationsResponse with _$RegistrationsResponse {
  factory RegistrationsResponse({
    @JsonKey(name: 'startIndex') required int page,
    @JsonKey(name: 'items') required List<Registration> results,
    @JsonKey(name: 'resultCount') required int totalResults,
    @JsonKey(name: 'totalItems') required int totalPages,
    @Default([]) List<String> errors,
  }) = _RegistrationsResponse;

  factory RegistrationsResponse.fromJson(Map<String, dynamic> json) =>
      _$RegistrationsResponseFromJson(json);
}

extension RegistrationResponseX on RegistrationsResponse {
  //@late
  bool get isEmpty => !hasResults();

  bool hasResults() {
    return results.isNotEmpty;
  }

  bool hasErrors() {
    return errors.isNotEmpty;
  }
}

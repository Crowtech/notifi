library core;

import 'package:freezed_annotation/freezed_annotation.dart';
import 'registration.dart';

part 'registrations_response.freezed.dart';
part 'registrations_response.g.dart';

@freezed
sealed class RegistrationsResponse with _$RegistrationsResponse {
  factory RegistrationsResponse({
    @JsonKey(name: 'startIndex') required int startIndex,
    @JsonKey(name: 'items') required List<Registration> items,
    @JsonKey(name: 'total_results') required int totalResults,
    @JsonKey(name: 'totalItems') required int totalItems,
    @Default([]) List<String> errors,
  }) = _RegistrationsResponse;

  factory RegistrationsResponse.fromJson(Map<String, dynamic> json) =>
      _$RegistrationsResponseFromJson(json);
}

extension RegistrationResponseX on RegistrationsResponse {
  //@late
  bool get isEmpty => !hasItems();

  bool hasItems() {
    return items.isNotEmpty;
  }

  bool hasErrors() {
    return errors.isNotEmpty;
  }
}

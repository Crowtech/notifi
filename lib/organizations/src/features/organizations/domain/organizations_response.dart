library core;

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:notifi/models/organization.dart';

part 'organizations_response.freezed.dart';
part 'organizations_response.g.dart';

@freezed
class OrganizationsResponse with _$OrganizationsResponse {
  factory OrganizationsResponse({
    @JsonKey(name: 'startIndex') required int page,
    @JsonKey(name: 'items') required List<Organization> results,
    @JsonKey(name: 'resultCount') required int totalResults,
    @JsonKey(name: 'totalItems') required int totalPages,
    @Default([]) List<String> errors,
  }) = _OrganizationsResponse;

  factory OrganizationsResponse.fromJson(Map<String, dynamic> json) =>
      _$OrganizationsResponseFromJson(json);
}

extension NOrganizationsResponseX on OrganizationsResponse {
  //@late
  bool get isEmpty => !hasResults();

  bool hasResults() {
    return results.isNotEmpty;
  }

  bool hasErrors() {
    return errors.isNotEmpty;
  }
}

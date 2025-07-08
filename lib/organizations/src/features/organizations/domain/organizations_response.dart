import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:notifi/models/organization.dart';


part 'organizations_response.freezed.dart';
part 'organizations_response.g.dart';



@freezed
abstract class OrganizationsResponse with _$OrganizationsResponse {
  const factory OrganizationsResponse({
    @JsonKey(name: 'startIndex') int? startIndex,
    @JsonKey(name: 'items') List<Organization>? items,
    @JsonKey(name: 'resultCount') int? resultCount,
    @JsonKey(name: 'totalItems') int? totalItems,
  }) = _OrganizationsResponse;

  factory OrganizationsResponse.fromJson(Map<String, Object?> json)
      => _$OrganizationsResponseFromJson(json);
}
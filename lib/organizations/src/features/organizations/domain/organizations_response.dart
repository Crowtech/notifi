import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:notifi/models/organization.dart';


part 'organizations_response.freezed.dart';
part 'organizations_response.g.dart';


@freezed
@JsonSerializable()
class OrganizationsResponse with _$OrganizationsResponse {
  OrganizationsResponse({
    @JsonKey(name: 'startIndex') required int startIndex,
    @JsonKey(name: 'items') required List<Organization> items,
    @JsonKey(name: 'resultCount') required int resultCount,
    @JsonKey(name: 'totalItems') required int totalItems,
  });

  @override
  int startIndex=0;
  @override
  List<Organization> items=[];
  @override
  int resultCount=0;
  @override
  int totalItems=0;

  factory OrganizationsResponse.fromJson(Map<String, Object?> json) =>
      _$OrganizationsResponseFromJson(json);

  Map<String, Object?> toJson() => _$OrganizationsResponseToJson(this);
}

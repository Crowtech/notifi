import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:notifi/models/organization.dart';


part 'organizations_response.freezed.dart';
part 'organizations_response.g.dart';



@freezed
@JsonSerializable()
class OrganizationsResponse with _$OrganizationsResponse {
  const OrganizationsResponse({
    @JsonKey(name: 'startIndex') required this.startIndex,
    @JsonKey(name: 'items') required this.items,
    @JsonKey(name: 'resultCount') required this.resultCount,
    @JsonKey(name: 'totalItems') required this.totalItems,
  });

  @override
  final int startIndex;
  @override
  final List<Organization> items;
  @override
  final int resultCount;
  @override
  final int totalItems;

  factory OrganizationsResponse.fromJson(Map<String, Object?> json)
      => _$OrganizationsResponseFromJson(json);

  Map<String, Object?> toJson() => _$OrganizationsResponseToJson(this);
}

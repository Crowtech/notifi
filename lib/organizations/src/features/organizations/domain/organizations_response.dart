import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:notifi/models/organization.dart';


part 'organizations_response.freezed.dart';
part 'organizations_response.g.dart';


@freezed
@JsonSerializable()
sealed class OrganizationsResponse with _$OrganizationsResponse {
  OrganizationsResponse({
    @JsonKey(name: 'startIndex') required this.startIndex,
    @JsonKey(name: 'items') required this.items,
    @JsonKey(name: 'resultCount') required this.resultCount,
    @JsonKey(name: 'totalItems') required int totalItems,

  });

  @override
  int startIndex=0;
  @override
  List<Organization> items = [];
  @override
  int resultCount=0;
    @override
  int totalItems=0;

  factory OrganizationsResponse.fromJson(Map<String, Object?> json)
      => _$OrganizationsResponseFromJson(json);

  Map<String, Object?> toJson() => _$OrganizationsResponseToJson(this);
}

// @freezed
// sealed class OrganizationsResponse with _$OrganizationsResponse {
//    @JsonSerializable(explicitToJson: true)
//   OrganizationsResponse({
//     @JsonKey(name: 'startIndex') required this.page,
//     @JsonKey(name: 'items') required this.results,
//     @JsonKey(name: 'resultCount') required this.totalItems,
//     @JsonKey(name: 'totalItems') required this.totalPages,
//   }) ;

//   final int page;
//   final List<Organization> results;
//   final int totalItems;
//   final int totalPages;


// factory OrganizationsResponse.fromJson(Map<String, dynamic> json) => _$OrganizationsResponseFromJson(json);

// // extension NOrganizationsResponseX on OrganizationsResponse {
// //   //@late
// //   bool get isEmpty => !hasResults();

// //   bool hasResults() {
// //     return results.isNotEmpty;
// //   }

// //   bool hasErrors() {
// //     return errors.isNotEmpty;
// //   }
// // }
// }
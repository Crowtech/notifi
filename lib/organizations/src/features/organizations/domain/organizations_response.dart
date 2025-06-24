import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:notifi/models/organization.dart';


part 'organizations_response.freezed.dart';
part 'organizations_response.g.dart';


@freezed
@JsonSerializable()
class OrganizationsResponse with _$OrganizationsResponse {
  const OrganizationsResponse({
    @JsonKey(name: 'startIndex') required this.page,
    @JsonKey(name: 'items') required this.results,
    @JsonKey(name: 'resultCount') required this.totalResults,
    @JsonKey(name: 'totalItems') required this.totalPages,

  });

  @override
  final int page;
  @override
  final List<Organization> results;
  @override
    final int totalResults;
    @override
  final int totalPages;

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
//     @JsonKey(name: 'resultCount') required this.totalResults,
//     @JsonKey(name: 'totalItems') required this.totalPages,
//   }) ;

//   final int page;
//   final List<Organization> results;
//   final int totalResults;
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
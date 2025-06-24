import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:notifi/models/organization.dart';

//part 'organizations_response.g.dart';
part 'organizations_response.freezed.dart';


@freezed
sealed class OrganizationsResponse with _$OrganizationsResponse {
  OrganizationsResponse({
    @JsonKey(name: 'startIndex') required this.page,
    @JsonKey(name: 'items') required this.results,
    @JsonKey(name: 'resultCount') required this.totalResults,
    @JsonKey(name: 'totalItems') required this.totalPages,
   // @Default([]) List<String>?  this.errors,
  }) ;

  final int page;
  final List<Organization> results;
  final int totalResults;
  final int totalPages;
 // final List<String>? errors;

  // factory OrganizationsResponse.fromJson(Map<String, dynamic> json) =>
  //     _$OrganizationsResponseFromJson(json);


// extension NOrganizationsResponseX on OrganizationsResponse {
//   //@late
//   bool get isEmpty => !hasResults();

//   bool hasResults() {
//     return results.isNotEmpty;
//   }

//   bool hasErrors() {
//     return errors.isNotEmpty;
//   }
// }
}
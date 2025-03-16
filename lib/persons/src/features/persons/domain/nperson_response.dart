library core;

import 'package:freezed_annotation/freezed_annotation.dart';
import 'nperson.dart';

part 'nperson_response.freezed.dart';
part 'nperson_response.g.dart';

//{created: 2025-03-12T06:36:41.331630375, startIndex: 0, items: [{id: 1, created: 2025-01-08T12:29:22.045304, updated: 2025-03-10T23:56:09.999705, code: ORG_PANTA, name: Panta, orgId: 2, description: Panta,
//avatarUrl: ORG_PANTA-avatar-2025-03-09T16:40:51.725539.png, orgType: org, url: https://www.pantagroup.org}, {id: 10251, created: 2025-03-06T01:53:08.333173, updated: 2025-03-10T23:56:09.987446, code: ORG_CROWTECH, name: Crowtech, orgId: 2, description: Crowtech,
//avatarUrl: ORG_CROWTECH-avatar-2025-03-09T16:40:51.725539.png, orgType: org, url: https://crowtech.com.au}], totalItems: 2, processingTime: 9414451}
@freezed
class NPersonsResponse with _$NPersonsResponse {
  factory NPersonsResponse({
    @JsonKey(name: 'startIndex') required int page,
    @JsonKey(name: 'items') required List<NPerson> results,
    @JsonKey(name: 'resultCount') required int totalResults,
    @JsonKey(name: 'totalItems') required int totalPages,
    @Default([]) List<String> errors,
  }) = _NPersonsResponse;

  factory NPersonsResponse.fromJson(Map<String, dynamic> json) =>
      _$NPersonsResponseFromJson(json);
}

extension NPersonsResponseX on NPersonsResponse {
  //@late
  bool get isEmpty => !hasResults();

  bool hasResults() {
    return results.isNotEmpty;
  }

  bool hasErrors() {
    return errors.isNotEmpty;
  }
}

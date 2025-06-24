library core;

import 'package:freezed_annotation/freezed_annotation.dart';
import 'nperson.dart';

part 'npersons_response.freezed.dart';
part 'npersons_response.g.dart';

//{created: 2025-03-12T06:36:41.331630375, startIndex: 0, items: [{id: 1, created: 2025-01-08T12:29:22.045304, updated: 2025-03-10T23:56:09.999705, code: ORG_PANTA, name: Panta, orgId: 2, description: Panta,
//avatarUrl: ORG_PANTA-avatar-2025-03-09T16:40:51.725539.png, orgType: org, url: https://www.pantagroup.org}, {id: 10251, created: 2025-03-06T01:53:08.333173, updated: 2025-03-10T23:56:09.987446, code: ORG_CROWTECH, name: Crowtech, orgId: 2, description: Crowtech,
//avatarUrl: ORG_CROWTECH-avatar-2025-03-09T16:40:51.725539.png, orgType: org, url: https://crowtech.com.au}], totalItems: 2, processingTime: 9414451}

@freezed
@JsonSerializable()
class NPersonsResponse with _$NPersonsResponse {
  const NPersonsResponse({
    @JsonKey(name: 'startIndex') required this.page,
    @JsonKey(name: 'items') required this.results,
    @JsonKey(name: 'resultCount') required this.totalResults,
    @JsonKey(name: 'totalItems') required this.totalPages,

  });

  @override
  final int page;
  @override
  final List<NPerson> results;
  @override
    final int totalResults;
    @override
  final int totalPages;

  factory NPersonsResponse.fromJson(Map<String, Object?> json)
      => _$NPersonsResponseFromJson(json);

  Map<String, Object?> toJson() => _$NPersonsResponseToJson(this);
}

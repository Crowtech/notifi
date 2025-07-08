library;

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:notifi/models/person.dart';


part 'persons_response.freezed.dart';
part 'persons_response.g.dart';




@freezed
abstract class PersonsResponse with _$PersonsResponse {
  const factory PersonsResponse({
    @JsonKey(name: 'startIndex') int? startIndex,
    @JsonKey(name: 'items') List<Person>? items,
    @JsonKey(name: 'resultCount') int? resultCount,
    @JsonKey(name: 'totalItems') int? totalItems,
  }) = _PersonsResponse;

  factory PersonsResponse.fromJson(Map<String, Object?> json)
      => _$PersonsResponseFromJson(json);
}
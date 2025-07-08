library;

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:notifi/models/person.dart';
import 'nperson.dart';

part 'npersons_response.freezed.dart';
part 'npersons_response.g.dart';




@freezed
@JsonSerializable()
class NPersonsResponse with _$NPersonsResponse {
  const NPersonsResponse({
    @JsonKey(name: 'startIndex') required this.startIndex,
    @JsonKey(name: 'items') required this.items,
    @JsonKey(name: 'resultCount') required this.resultCount,
    @JsonKey(name: 'totalItems') required this.totalItems,
  });

  @override
  final int startIndex;
  @override
  final List<Person> items;
  @override
  final int resultCount;
  @override
  final int totalItems;

  factory NPersonsResponse.fromJson(Map<String, Object?> json)
      => _$NPersonsResponseFromJson(json);

  Map<String, Object?> toJson() => _$NPersonsResponseToJson(this);
}

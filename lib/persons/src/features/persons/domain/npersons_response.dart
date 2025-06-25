library core;

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:notifi/models/person.dart';
import 'nperson.dart';

part 'npersons_response.freezed.dart';
part 'npersons_response.g.dart';


@freezed
@JsonSerializable()
class NPersonsResponse with _$NPersonsResponse {
  NPersonsResponse({
    @JsonKey(name: 'startIndex') required int startIndex,
    @JsonKey(name: 'items') required List<Person> items,
    @JsonKey(name: 'resultCount') required int resultCount,
    @JsonKey(name: 'totalItems') required int totalItems,
  });

  @override
  int startIndex=0;
  @override
  List<Person> items=[];
  @override
  int resultCount=0;
  @override
  int totalItems=0;

  factory NPersonsResponse.fromJson(Map<String, Object?> json) =>
      _$NPersonsResponseFromJson(json);

  Map<String, Object?> toJson() => _$NPersonsResponseToJson(this);
}

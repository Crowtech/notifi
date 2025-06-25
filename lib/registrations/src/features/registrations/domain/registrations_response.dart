library core;

import 'package:freezed_annotation/freezed_annotation.dart';
import 'registration.dart';

part 'registrations_response.freezed.dart';
part 'registrations_response.g.dart';

@freezed
@JsonSerializable()
class RegistrationsResponse with _$RegistrationsResponse {
  const RegistrationsResponse({
    @JsonKey(name: 'startIndex') required this.startIndex,
    @JsonKey(name: 'items') required this.items,
    @JsonKey(name: 'resultCount') required this.resultCount,
    @JsonKey(name: 'totalItems') required this.totalItems,
  });

  @override
  final int startIndex;
  @override
  final List<Registration> items;
  @override
  final int resultCount;
  @override
  final int totalItems;

  factory RegistrationsResponse.fromJson(Map<String, Object?> json)
      => _$RegistrationsResponseFromJson(json);

  Map<String, Object?> toJson() => _$RegistrationsResponseToJson(this);
}

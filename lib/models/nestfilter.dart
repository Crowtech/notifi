import 'package:json_annotation/json_annotation.dart';

import 'package:logger/logger.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'nestfilter.freezed.dart';

var logger = Logger(
  printer: PrettyPrinter(),
);

// @freezed
// class ComplexState with _$ComplexState {
//   const ComplexState._();

//   const factory ComplexState({
//     required String var1,
//     required double var2,
//     required bool var3,
//     required int var4,
//   }) = _ComplexState;
// }

@freezed
@JsonSerializable(explicitToJson: true)
class NestFilter with _$NestFilter {
  const NestFilter._();

  const factory NestFilter({
    @Default([]) List<int> orgIdList,
    @Default([]) List<String> resourceCodeList,
    @Default([]) List<int> resourceIdList,
    @Default([]) List<String> deviceCodeList,
    @Default('') String query,
    @Default(10) int limit,
    @Default(0) int offset,
    @Default('') String sortby,
    @Default(true) bool caseinsensitive,
    @Default('') String distinctField,
  }) = _NestFilter;

  // factory NestFilter.fromJson(Map<String, dynamic> json) =>
  //     _$NestFilterFromJson(json);
  //Map<String, dynamic> toJson() => _$NestFilterToJson(this);


  factory NestFilter.fromJson(Map<String, dynamic> json) => _$NestFilterFromJson(json);

  @override
  NestFilter fromJson(Map<String, dynamic> json) {
    return NestFilter.fromJson(json);
  }

  @override
  String toString() {
    return "Filter:$orgIdList $resourceCodeList $deviceCodeList $query $offset $limit $sortby $caseinsensitive ";
  }
}

// @JsonSerializable(explicitToJson: true)
// class NestFilter {
//   static String className = "NestFilter";
//   static String tablename = className.toLowerCase();

//   List<int> orgIdList = <int>[];
//   List<String> resourceCodeList = [];
//   List<int> resourceIdList = [];
//   List<String> deviceCodeList = [];
//   String query;
//   int limit;
//   int offset;
//   String sortby;
//   bool caseinsensitive;
//   String distinctField;

//   NestFilter(
//       {this.orgIdList = const [],
//       this.resourceCodeList = const [],
//       this.resourceIdList = const [],
//       this.deviceCodeList = const [],
//       this.query = "",
//       this.offset = 0,
//       this.limit = 10,
//       this.sortby = "",
//       this.caseinsensitive = true,
//       this.distinctField = ""});

//   factory NestFilter.fromJson(Map<String, dynamic> json) =>
//       _$NestFilterFromJson(json);
//   Map<String, dynamic> toJson() => _$NestFilterToJson(this);

//   @override
//   NestFilter fromJson(Map<String, dynamic> json) {
//     return NestFilter.fromJson(json);
//   }

//   @override
//   String toString() {
//     return "Filter:$orgIdList $resourceCodeList $deviceCodeList $query $offset $limit $sortby $caseinsensitive ";
//   }
// }

NestFilter defaultNestFilter = NestFilter(
  orgIdList: [],
  resourceCodeList: [],
  resourceIdList: [],
  deviceCodeList: [],
  query: "",
  offset: 0,
  limit: 10,
  sortby: "",
  caseinsensitive: true,
  distinctField: "",
); //fcm

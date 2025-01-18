import 'package:json_annotation/json_annotation.dart';

import 'package:logger/logger.dart';
part 'nestfilter.g.dart';

var logger = Logger(
  printer: PrettyPrinter(),
);

@JsonSerializable(explicitToJson: true)
class NestFilter {
  static String className = "NestFilter";
  static String tablename = className.toLowerCase();

  List<int> orgIdList =<int>[];
  List<String> resourceCodeList = [];
  List<int> resourceIdList = [];
  List<String> deviceCodeList = [];
  String query;
  int limit;
  int offset;
  String sortby;
  bool caseinsensitive;
  String distinctField;

  NestFilter(
      {
      required this.orgIdList,
      required this.resourceCodeList,
      required this.resourceIdList,
      required this.deviceCodeList,
      this.query = "",
      this.offset=0,
      this.limit=10,
      this.sortby = "",
      this.caseinsensitive = true,
      this.distinctField = ""});

  factory NestFilter.fromJson(Map<String, dynamic> json) =>
      _$NestFilterFromJson(json);
  Map<String, dynamic> toJson() => _$NestFilterToJson(this);

  @override
  NestFilter fromJson(Map<String, dynamic> json) {
    return NestFilter.fromJson(json);
  }

    @override
  String toString() {
    return "Filter:$orgIdList $resourceCodeList $deviceCodeList $query $offset $limit $sortby $caseinsensitive ";
  }
}

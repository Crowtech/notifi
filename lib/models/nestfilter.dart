import 'package:json_annotation/json_annotation.dart';

import 'package:logger/logger.dart' as logger;

part 'nestfilter.g.dart';

var log = logger.Logger(
  printer: logger.PrettyPrinter(),
  level: logger.Level.info,
);

var logNoStack = logger.Logger(
  printer: logger.PrettyPrinter(methodCount: 0),
  level: logger.Level.info,
);

@JsonSerializable(explicitToJson: true)
class NestFilter {
  static String className = "NestFilter";
  static String tablename = className.toLowerCase();

  List<int> orgIdList = <int>[];
  List<String> resourceCodeList = [];
  List<int> resourceIdList = [];
  List<int> targetIdList = [];
  List<String> deviceCodeList = [];
  String query;
  int limit;
  int offset;
  String sortby;
  bool caseinsensitive;
  String distinctField;
  bool includeGPS;

  NestFilter(
      {this.orgIdList = const [],
      this.resourceCodeList = const [],
      this.resourceIdList = const [],
      this.targetIdList = const [],
      this.deviceCodeList = const [],
      this.query = "",
      this.offset = 0,
      this.limit = 10,
      this.sortby = "",
      this.caseinsensitive = true,
      this.distinctField = "",
      this.includeGPS = true
      });

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

  NestFilter copyWith({
    final String? query,
    final List<int>? orgIdList,
    final String? sortby,
  }) {
    return NestFilter(
      query: query ?? this.query,
      orgIdList: orgIdList ?? this.orgIdList,
      sortby: sortby ?? this.sortby,
    );
  }
}

NestFilter defaultNestFilter = NestFilter(
  orgIdList: [],
  resourceCodeList: [],
  resourceIdList: [],
  targetIdList: [],
  deviceCodeList: [],
  query: "",
  offset: 0,
  limit: 20,
  sortby: "",
  caseinsensitive: true,
  distinctField: "",
); //fcm

import 'package:json_annotation/json_annotation.dart';

import 'package:logger/logger.dart';
part 'gpsfilter.g.dart';

var logger = Logger(
  printer: PrettyPrinter(),
);

@JsonSerializable(explicitToJson: true)
class GPSFilter {
  static String className = "GPSFilter";
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

  GPSFilter(
      {
      required this.orgIdList,
      required this.resourceCodeList,
      required this.resourceIdList,
      required this.deviceCodeList,
      this.query = "",
      this.offset=0,
      this.limit=10,
      this.sortby = "",
      this.caseinsensitive = true});

  factory GPSFilter.fromJson(Map<String, dynamic> json) =>
      _$GPSFilterFromJson(json);
  Map<String, dynamic> toJson() => _$GPSFilterToJson(this);

  @override
  GPSFilter fromJson(Map<String, dynamic> json) {
    return GPSFilter.fromJson(json);
  }

    @override
  String toString() {
    return "GPS:$orgIdList $resourceCodeList $deviceCodeList $query $offset $limit $sortby $caseinsensitive ";
  }
}

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import 'package:logger/logger.dart' as logger;

import '../api_utils.dart';
import '../credentials.dart';
import 'crowtech_basepage.dart';
import 'person.dart';
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
  List<String> deviceCodeList = [];
  String query;
  int limit;
  int offset;
  String sortby;
  bool caseinsensitive;
  String distinctField;

  NestFilter(
      {this.orgIdList = const [],
      this.resourceCodeList = const [],
      this.resourceIdList = const [],
      this.deviceCodeList = const [],
      this.query = "",
      this.offset = 0,
      this.limit = 10,
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

  NestFilter copyWith({
    final String? query,
  }) {
    return NestFilter(
      query: query ?? this.query,
    );
  }

  Future<CrowtechBasePage<Person>> fetchPage(
      String token, NestFilter nestfilter) async {
    String jsonDataStr = jsonEncode(nestfilter);
    logNoStack
        .i("Sending NestFilter gps $nestfilter with json as $jsonDataStr");

    var response = await apiPostDataStrNoLocale(
        token, "$defaultApiPrefixPath/persons/get", jsonDataStr);
    // .then((response) {
    logNoStack.d("result ${response.body.toString()}");
    final map = jsonDecode(response.body);

    CrowtechBasePage<Person> page =
        CrowtechBasePage<Person>(itemFromJson: Person.fromJson).fromJson(map);
    String usersStr = "--- Users ----\n";
    for (int i = 0; i < page.itemCount(); i++) {
      usersStr += "User $i  ${page.items![i]}\n";
    }
    logNoStack.i(usersStr);
    return page;
  }
}

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

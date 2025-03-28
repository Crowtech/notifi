
import 'package:notifi/models/nest_filter_type.dart';
import 'package:notifi/models/nestfilter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:logger/logger.dart' as logger;


part 'nest_filter_provider.g.dart';

var log = logger.Logger(
  printer: logger.PrettyPrinter(),
  level: logger.Level.info,
);

var logNoStack = logger.Logger(
  printer: logger.PrettyPrinter(methodCount: 0),
  level: logger.Level.info,
);


@Riverpod(keepAlive: true)
class AdamNestFilter extends _$AdamNestFilter {

  late NestFilterType nestFilterType;

  @override
  NestFilter build(NestFilterType nestFilterType) {
    this.nestFilterType = nestFilterType;
    logNoStack.i("CurrentNestFilter: BUILD ${this.nestFilterType}");

    if (nestFilterType == NestFilterType.mapUsers) {
      // fetch all users within a map boundary
      // for now fetch them all
      NestFilter nf = defaultNestFilter.copyWith();
      nf.limit = 100000;
      nf.includeGPS = false;
      return nf;
    }
    return defaultNestFilter;
  }

  void setNestFilter(NestFilter nf) {
    logNoStack
        .i("CURRENT_NESTFILTER (${nestFilterType.name}): setNestFilter $nf");
    state = nf;
  }

  void setOffset(int offset) {
    logNoStack
        .i("CURRENT_NESTFILTER (${nestFilterType.name}): setOffset $offset");
    state = state..offset = offset;
  }

   void setLimit(int limit) {
    logNoStack
        .i("CURRENT_NESTFILTER (${nestFilterType.name}): setLimit $limit");
    state = state..limit = limit;
  }

  void setQuery(String query) {
    logNoStack
        .i("CURRENT_NESTFILTER (${nestFilterType.name}): setQuery $query");
    state = state..query = query;
  }

  void setOrganizationId(List<int> orgIdList) {
    logNoStack
        .i("CURRENT_NESTFILTER (${nestFilterType.name}): setOrgIds $orgIdList");
    state = state..orgIdList = orgIdList;
  }
}
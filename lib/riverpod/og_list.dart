import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notifi/api_utils.dart';
import 'package:notifi/credentials.dart';
import 'package:notifi/models/crowtech_basepage.dart';
import 'package:notifi/models/nestfilter.dart';
import 'package:notifi/models/organization.dart';
import 'package:notifi/models/person.dart';
import 'package:notifi/state/nest_auth2.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:logger/logger.dart' as logger;

part 'og_list.g.dart';

var log = logger.Logger(
  printer: logger.PrettyPrinter(),
  level: logger.Level.info,
);

var logNoStack = logger.Logger(
  printer: logger.PrettyPrinter(methodCount: 0),
  level: logger.Level.info,
);

@riverpod
Future<List<Organization>> ogList(Ref ref) async {
  NestFilter nestFilter = NestFilter();

  nestFilter.offset = 0;
  String jsonDataStr = jsonEncode(nestFilter);
  Person currentUser = ref.read(nestAuthProvider.notifier).currentUser;
  String token = ref.read(nestAuthProvider.notifier).token!;
  logNoStack.i(
      "Sending NestFilter org for ${currentUser.id} $nestFilter with json as $jsonDataStr");

  var response = await apiPostDataStrNoLocale(
      token,
      "$defaultAPIBaseUrl$defaultApiPrefixPath/resources/sources/${currentUser.id}",
      jsonDataStr);
  // .then((response) {
  logNoStack.i("result ${response.body.toString()}");
  final map = jsonDecode(response.body);

  CrowtechBasePage<Organization> page =
      CrowtechBasePage<Organization>(itemFromJson: Organization.fromJson)
          .fromJson(map);
  String usersStr = "--- Organizations ----\n";
  for (int i = 0; i < page.itemCount(); i++) {
    usersStr += "Org$i  ${page.items![i]}\n";
  }
  logNoStack.i(usersStr);

  return page.items!;
}

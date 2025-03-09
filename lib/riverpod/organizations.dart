import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart' as logger;
import 'package:notifi/credentials.dart';
import 'package:notifi/models/nestfilter.dart';
import 'package:notifi/models/organization.dart';
import 'package:notifi/state/nest_auth2.dart';

import '../api_utils.dart';
import '../models/crowtech_basepage.dart';
import '../models/person.dart';

var log = logger.Logger(
  printer: logger.PrettyPrinter(),
  level: logger.Level.info,
);

var logNoStack = logger.Logger(
  printer: logger.PrettyPrinter(methodCount: 0),
  level: logger.Level.info,
);

class OrganizationsFetcher extends Notifier<CrowtechBasePage<Organization>> {
  @override
  CrowtechBasePage<Organization> build() {
    return CrowtechBasePage<Organization>();
  }

  void fetch(NestFilter nestfilter) async {
    state = await fetchPage(nestfilter);
  }

  Future<CrowtechBasePage<Organization>> fetchPage(
      NestFilter nestfilter) async {
        nestfilter.offset = 0;
    String jsonDataStr = jsonEncode(nestfilter);
 Person currentUser = ref.read(nestAuthProvider.notifier).currentUser;
    String token = ref.read(nestAuthProvider.notifier).token!;
    logNoStack
        .i("Sending NestFilter org for ${currentUser.id} $nestfilter with json as $jsonDataStr");
   
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
    return page;
  }
}

// Notifier provider holding the state
final organizationsProvider =
    NotifierProvider<OrganizationsFetcher, CrowtechBasePage<Organization>>(
        OrganizationsFetcher.new);

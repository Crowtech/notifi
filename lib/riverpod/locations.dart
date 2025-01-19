import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart' as logger;
import 'package:notifi/credentials.dart';
import 'package:notifi/models/gps.dart';
import 'package:notifi/models/nestfilter.dart';
import '../api_utils.dart';
import '../models/crowtech_basepage.dart';
import '../models/nestfilter.dart';


var log = logger.Logger(
  printer: logger.PrettyPrinter(),
  level: logger.Level.info,
);

var logNoStack = logger.Logger(
  printer: logger.PrettyPrinter(methodCount: 0),
  level: logger.Level.info,
);
//void main() {
//  runApp(const ProviderScope(child: RandomNumberApp()));
//}

// Notifier for generating a random number exposed by a state notifier
// provider
class LocationsFetcher extends Notifier<CrowtechBasePage<GPS>> {
  @override
  CrowtechBasePage<GPS> build() {
    CrowtechBasePage<GPS> defaultPage = CrowtechBasePage<GPS>();
  defaultPage.processingTime = 0;
  defaultPage.startIndex = 0;
  defaultPage.totalItems=0;
    return defaultPage;
  }

  // void generate() {
  //   state = Random().nextInt(9999);
  // }

  //Future<CrowtechBasePage<GPS>> fetchGPS(
void fetchGPS(
    Locale locale, String token, int orgid, int offset, int limit) async {
  List<int> orgIdList = [];
  orgIdList.add(orgid);

  var nestfilter = NestFilter(
      orgIdList: orgIdList,
      resourceCodeList: [],
      resourceIdList: [],
      deviceCodeList: [],
      query: '',
      offset: offset,
      limit: limit,
      sortby: 'id DESC',
      caseinsensitive: true,
      distinctField: 'resourcecode');

  String jsonDataStr = jsonEncode(nestfilter);
  logNoStack.i("Sending NestFilter gps $nestfilter with json as $jsonDataStr");

  var response = await apiPostDataStr(locale, token, "$defaultApiPrefixPath/gps/fetch", jsonDataStr);
     // .then((response) {
    logNoStack.d("result ${response.body.toString()}");
    final map = jsonDecode(response.body);

    if (map["totalItems"] == 0) {
      logNoStack.i("Empty List");
      CrowtechBasePage<GPS> page =
          CrowtechBasePage<GPS>(itemFromJson: GPS.fromJson).fromJson(map);

      state = page;
    } else {
      logNoStack.d("map = $map");

      CrowtechBasePage<GPS> page =
          CrowtechBasePage<GPS>(itemFromJson: GPS.fromJson).fromJson(map);
     
      state =  page;
    }

}

}

// Notifier provider holding the state
final locationsProvider =
    NotifierProvider<LocationsFetcher, CrowtechBasePage<GPS>>(LocationsFetcher.new);



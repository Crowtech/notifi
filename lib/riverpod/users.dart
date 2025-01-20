import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart' as logger;
import 'package:notifi/credentials.dart';
import 'package:notifi/models/nestfilter.dart';

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

class UsersFetcher extends Notifier<CrowtechBasePage<Person>> {


  @override
  CrowtechBasePage<Person> build() {
    return CrowtechBasePage<Person>();
  }

  void fetchUsers(
      Locale locale, String token, NestFilter nestfilter) async {

    String jsonDataStr = jsonEncode(nestfilter);
    logNoStack
        .i("Sending NestFilter gps $nestfilter with json as $jsonDataStr");

    var response = await apiPostDataStr(
        locale, token, "$defaultApiPrefixPath/persons/get", jsonDataStr);
    // .then((response) {
    logNoStack.d("result ${response.body.toString()}");
    final map = jsonDecode(response.body);

  
      CrowtechBasePage<Person> page =
          CrowtechBasePage<Person>(itemFromJson: Person.fromJson).fromJson(map);

      state = page;
   
      }
}

// Notifier provider holding the state
final locationsProvider =
    NotifierProvider<UsersFetcher, CrowtechBasePage<Person>>(UsersFetcher.new);
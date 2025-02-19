import 'dart:convert';
import 'dart:core';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notifi/api_utils.dart';
import 'package:notifi/credentials.dart';
import 'package:notifi/models/crowtech_basepage.dart';
import 'package:notifi/models/gps.dart';
import 'package:notifi/models/nestfilter.dart';
import 'package:notifi/models/person.dart';
import 'package:riverpod_infinite_scroll/riverpod_infinite_scroll.dart';
import 'package:logger/logger.dart' as logger;

var log = logger.Logger(
  printer: logger.PrettyPrinter(),
  level: logger.Level.info,
);

var logNoStack = logger.Logger(
  printer: logger.PrettyPrinter(methodCount: 0),
  level: logger.Level.info,
);



class UsersState extends PagedState<int, Person> {
  // We can extends [PagedState] to add custom parameters to our state
  final bool filterByCity;

  NestFilter nestfilter = NestFilter(
      orgIdList: [],
      resourceCodeList: [],
      resourceIdList: [],
      deviceCodeList: [],
      query: '',
      offset: 0,
      limit: 10,
      sortby: 'id DESC',
      caseinsensitive: true,
      distinctField: 'resourcecode');

  UsersState(
      {this.filterByCity = false,
      List<Person>? records,
      String? error,
      int? nextPageKey,
      List<int>? previousPageKeys})
      : super(records: records, error: error, nextPageKey: nextPageKey);

  // We can customize our .copyWith for example
  @override
  UsersState copyWith(
      {bool? filterByCity,
      List<Person>? records,
      dynamic error,
      dynamic nextPageKey,
      List<int>? previousPageKeys}) {
    final sup = super.copyWith(
        records: records,
        error: error,
        nextPageKey: nextPageKey,
        previousPageKeys: previousPageKeys);
    return UsersState(
        filterByCity: filterByCity ?? this.filterByCity,
        records: sup.records,
        error: sup.error,
        nextPageKey: sup.nextPageKey,
        previousPageKeys: sup.previousPageKeys);
  }
}

class UsersNotifier extends StateNotifier<UsersState>
    with PagedNotifierMixin<int, Person, UsersState> {
  //  Ref ref;
  String? token;
  NestFilter? nestFilter;
  UsersNotifier({this.token, this.nestFilter}) : super(UsersState());

  @override
  Future<List<Person>?> load(int page, int limit) async {
    try {
      //as build can be called many times, ensure
      //we only hit our page API once per page
      if (state.previousPageKeys.contains(page)) {
        await Future.delayed(const Duration(seconds: 0), () {
          state = state.copyWith();
        });
        return state.records;
      }
      // var users = await Future.delayed(const Duration(seconds: 1), () async {
      // This simulates a network call to an api that returns paginated users
      // var token = ref.read(nestAuthProvider.notifier).token;

//        // var token = app_state.cachedAuthedUser.of(context)!.token.accessToken!;
      logNoStack
          .i("UsersNotifier page is $page ,limit is $limit and token is $token");
     
     late NestFilter nf;
      if (nestFilter == null) {
          nf =  defaultNestFilter; //(offset: 0, limit: 0);
      } else {
        nf = nestFilter!.copyWith(offset: page,limit: limit);
      }



      String jsonDataStr = jsonEncode(nf);
      logNoStack.i("UsersNotifier  Sending NestFilter gps $nf with json as $jsonDataStr");

       var users = await Future.delayed(const Duration(seconds: 0), () async {

        List<Person> apiUsers = [];
       var response = await apiPostDataStrNoLocale(
           token!, "$defaultAPIBaseUrl$defaultApiPrefixPath/persons/fetch", jsonDataStr);

        //logNoStack.i("responsebody = ${response.body}");

      // // .then((response) {
      // logNoStack.i("UsersNotifier result ${response.body.toString()}");
      final map = jsonDecode(response.body);

      CrowtechBasePage<GPS> pageData =
          CrowtechBasePage<GPS>(itemFromJson: GPS.fromJson).fromJson(map);
      //String usersStr = "--- Users ----\n";
      // Ugly flip of gps and person
      List<Person> persons = [];
      for (int i = 0; i < pageData.itemCount(); i++) {
        logNoStack.i("User $i  ${pageData.items![i]}");
        persons.add(pageData.items![i].person!);
        pageData.items![i].person = null;
        logNoStack.i("PAGE GPS in person = ${pageData.items![i]}");
        persons[i].gps = pageData.items![i];
        //persons[i].id = page + i;
      }
      //logNoStack.i("USerProvider: $usersStr");

        apiUsers = persons; //pageData.items!;
     
          return apiUsers;
       });
    
      // we then update state accordingly
      state = state.copyWith(
          records: [...(state.records ?? []), ...users],
          nextPageKey: users.length < limit ? null : users[users.length - 1].id,
          previousPageKeys: {...state.previousPageKeys, page}.toList());
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
    return null;
  }

  // Super simple example of custom methods of the StateNotifier
  void add(Person user) {
    state = state.copyWith(records: [...(state.records ?? []), user]);
  }

  void delete(Person user) {
    state = state.copyWith(records: [...(state.records ?? [])]..remove(user));
  }
}

final usersProvider = StateNotifierProvider<UsersNotifier, UsersState>(
    (_) => UsersNotifier(token: ''));

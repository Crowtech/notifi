import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:notifi/credentials.dart';
import 'package:oidc/oidc.dart';


import '../api_utils.dart';
import '../models/crowtech_base.dart';
import '../models/crowtech_basepage.dart';
import 'package:notifi/app_state.dart' as app_state;
import 'package:logger/logger.dart' as logger;

import '../models/gps.dart';
import '../models/nestfilter.dart';
import 'paginations.widget.dart';

var log = logger.Logger(
  printer: logger.PrettyPrinter(),
  level: logger.Level.info,
);

var logNoStack = logger.Logger(
  printer: logger.PrettyPrinter(methodCount: 0),
  level: logger.Level.info,
);

class CrowtechBasePageWidget<T extends CrowtechBase<T>> extends StatefulWidget {
  const CrowtechBasePageWidget({super.key, required this.itemFromJson, required this.tablename});

  final String tablename;
  final T Function(Map<String, dynamic>) itemFromJson;

  @override
  _CrowtechBasePageWidgetState<T> createState() => _CrowtechBasePageWidgetState<T>();
}

class _CrowtechBasePageWidgetState<T extends CrowtechBase<T>> extends State<CrowtechBasePageWidget<T>>
    with TickerProviderStateMixin {
  late CrowtechBasePage<T> page;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late List<T> filteredItems = [];
  late T? createKey;
  // late Future<PagePerson> itemsFuture;
  String namequery = "";
  int offset = 0;
  int limit = 10;
  String sortby = "";
  bool caseinsensitive = true;
  int currentPage = 0;
  int totalItems = 0;
  int itemsPerPage = 5;
  final pageController = TextEditingController(text: '5');
  late String? token;
  // function to fetch data from api and return future list of posts
  Future<CrowtechBasePage<T>> getItems(BuildContext context, String namequery, int offset,
      int limit, String sortby, bool caseinsensitive) async {
      OidcUser? user = app_state.cachedAuthedUser.of(context);
    token = user!.token.accessToken;

   
    var gpsfilter = NestFilter(
      orgIdList: [2],
      resourceCodeList: [],
      resourceIdList: [],
      deviceCodeList: [],
      query: '',
      offset: 0,
      limit: 10,
      sortby: '',
      caseinsensitive: false,
      distinctField: ''
    );

  logNoStack.d("Sending CrowtechFilter  $gpsfilter");

    String gpsJson;
    gpsJson = jsonEncode(gpsfilter);

String? jsonDataStr;
 Locale locale = Localizations.localeOf(context);
apiPostDataStr(locale, token!, "$defaultAPIBaseUrl$defaultApiPrefixPath/gps/fetch", jsonDataStr)
      .then((response) {
    logNoStack.d("result $response");
        final map = jsonDecode(response.body);

   
    if (map["totalItems"] == 0) {
      logNoStack.i("Empty List");
      return map;
    } else {
      CrowtechBasePage<GPS> page =
          CrowtechBasePage<GPS>(itemFromJson: GPS.fromJson).fromJson(map);
      logNoStack.i(page);
      return page;
    }
    
  }).catchError((error) {
    log.d("Fetch GPSerror");
  });
  throw "Fetch GPS error";
  }

  @override
  void initState() {
    super.initState();
    print("INIT STATE - PageWidget for ${widget.tablename}");

    itemsPerPage = int.parse(pageController.text);

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  // Event handler untuk dropdown
  void _handleItemsPerPageChange(String selectedItem) {
    setState(() {
      itemsPerPage = int.parse(selectedItem);
    });
    getItems(context, namequery, offset, itemsPerPage, sortby, caseinsensitive);
  }


  void nextPage() {
    setState(() {
      currentPage++;
    });
  }

  void previousPage() {
    setState(() {
      if (currentPage > 0) {
        currentPage--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // variable to call and store future list of posts

    Future<CrowtechBasePage<T>> itemsFuture = getItems(context, namequery,
        currentPage * limit, limit, sortby, caseinsensitive);
    return FutureBuilder<CrowtechBasePage<T>>(
        future: itemsFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            page = snapshot.data!;
            createKey = page.items![0];
            filteredItems = page.items!;
          }
          return Scaffold(
            floatingActionButton: Padding(
              padding: const EdgeInsets.only(bottom: 50.0),
              child: FloatingActionButton(
                backgroundColor: Colors.white,
                onPressed: () => {
                  context.pushNamed('${widget.tablename.toLowerCase()}sCreate',
                      extra: createKey, queryParameters: {"sendToken": token})
                },
                child: const Icon(
                  Icons.add,
                  color: Color(0xFF2a6000),
                ),
              ),
            ),
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  context.pop();
                },
              ),
              title: TextField(
                decoration: const InputDecoration(
                  hintText: 'Search...',
                  border: InputBorder.none,
                ),
                onChanged: (value) {
                  // getItems(context, 1, 100, value).then((pPage) {
                  setState(() {
                    namequery = value;
                    // filteredItems = pPage.items!;
                    // .where(
                    //     (data) => data.code!.contains(value.toUpperCase()))
                    // .toList();
                  });
                },
              ),
            ),
            body: Center(
              child: snapshot.connectionState == ConnectionState.waiting
                  ? const CircularProgressIndicator()
                  : snapshot.hasData
                      ? Column(
                          children: [
                            if (filteredItems.isNotEmpty)
                              Expanded(
                                child: buildItems(filteredItems),
                              ),
                            Pagination(
                              currentPage: currentPage,
                              totalItems: totalItems,
                              itemsPerPage: itemsPerPage,
                              previousPage: previousPage,
                              nextPage: nextPage,
                              onPageChanged: _handleItemsPerPageChange,
                              pageController: pageController,
                            ),
                            const SizedBox(
                              height: 20,
                            )
                          ],
                        )
                      : const Text("No data available"),
            ),
          );
        });
  }

  Widget buildItems(List<T> filteredItems) {
    return ListView.builder(
      itemCount: filteredItems.length,
      itemBuilder: (context, index) {
        final post = filteredItems[index];
        return GestureDetector(
          onTap: () {
            // Handle the tap event here
            // context.push('/attributes_details/${post.code!}');
            // Map<String, dynamic> json = post.toJson();
            print('${widget.tablename.toLowerCase()}sDetailCreate');
            context.pushNamed('${widget.tablename.toLowerCase()}sDetailCreate',
                extra: createKey, queryParameters: {"sendToken": token});
          },
          child: Container(
            color: Colors.grey.shade300,
            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            height: 50,
            width: double.maxFinite,
            child: Row(
              children: [
                Expanded(flex: 1, child: Text(post.created.toString())),
                const SizedBox(width: 10),
                Expanded(flex: 3, child: Text(post.code!)),
              ],
            ),
          ),
        );
      },
    );
  }
}


import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart' as logger;
import 'package:notifi/credentials.dart';
import 'package:notifi/i18n/strings.g.dart' as nt;
import 'package:notifi/models/registration.dart';
import 'package:notifi/registrations/src/features/registrations/presentation/registration_details/registration_details_screen.dart';
import 'package:notifi/state/nest_auth2.dart';
import 'package:notifi/widgets/slide_left_reject.dart';
import 'package:notifi/widgets/slide_right_approve.dart';

import '../../data/registrations_repository.dart';
import 'registration_list_tile.dart';
import 'registration_list_tile_shimmer.dart';
import 'registrations_search_bar.dart';
import 'registrations_search_query_notifier.dart';
import 'package:http/http.dart' as http;

var log = logger.Logger(
  printer: logger.PrettyPrinter(),
  level: logger.Level.info,
);

var logNoStack = logger.Logger(
  printer: logger.PrettyPrinter(methodCount: 0),
  level: logger.Level.info,
);

class RegistrationsSearchScreen extends ConsumerWidget {
  const RegistrationsSearchScreen({super.key});

  static const pageSize = 20;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final query = ref.watch(registrationsSearchQueryNotifierProvider);
    // * get the first page so we can retrieve the total number of results
    final responseAsync = ref.watch(
      fetchRegistrationsProvider(queryData: (page: 0, query: query)),
    );
    final totalItems = responseAsync.valueOrNull?.totalItems;
    logNoStack.i("Registrations list: totalItems=${totalItems}");
    return Scaffold(
      appBar: AppBar(title: Text(nt.t.resources.registration)),
      body: Column(
        children: [
          const RegistrationsSearchBar(),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                // dispose all the pages previously fetched. Next read will refresh them
                ref.invalidate(fetchRegistrationsProvider);
                // keep showing the progress indicator until the first page is fetched
                try {
                  await ref.read(
                    fetchRegistrationsProvider(
                        queryData: (page: 0, query: query)).future,
                  );
                } catch (e) {
                  // fail silently as the provider error state is handled inside the ListView
                }
              },
              child: ListView.builder(
                // use a different key for each query, ensuring the scroll
                // position is reset when the query and results change
                key: ValueKey(query),
                // * pass the itemCount explicitly to prevent unnecessary renders
                // * during overscroll
                itemCount: totalItems,
                itemBuilder: (context, index) {
                  final page = index ~/ pageSize + 1;
                  final indexInPage = index % pageSize;
                  // use the fact that this is an infinite list to fetch a new page
                  // as soon as the index exceeds the page size
                  // Note that ref.watch is called for up to pageSize items
                  // with the same page and query arguments (but this is ok since data is cached)
                  final responseAsync = ref.watch(
                    fetchRegistrationsProvider(
                        queryData: (page: page, query: query)),
                  );
                  return responseAsync.when(
                    error: (err, stack) => RegistrationListTileError(
                      query: query,
                      page: page,
                      indexInPage: indexInPage,
                      error: err.toString(),
                      isLoading: responseAsync.isLoading,
                    ),
                    loading: () => const RegistrationListTileShimmer(),
                    data: (response) {
                      logNoStack.i("Registrations list1 ${response.items}");
                      logNoStack.i('Registrations list2: index: $index, page: $page, indexInPage: $indexInPage, len: ${response.items!.length}');
                      // * This condition only happens if a null itemCount is given
                      if (indexInPage >= response.items!.length) {
                        return null;
                      }
                      var registration = response.items![indexInPage];
                      return Dismissible(
                          key: Key(registration.id.toString()),
                          direction: DismissDirection.horizontal,
                          background: slideRightApprove(),
                          secondaryBackground: slideLeftReject(),
                          confirmDismiss: (direction) {
                            return showDialog<bool>(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text(nt.t.response.sure),
                                  //content: Text(nt.t.invite.reject_sure),
                                  actions: [
                                    TextButton(
                                      onPressed: () async {
                                        String reason = "No problem";
                                        registration = await submitApproval(
                                            ref, registration, true, reason);
                                        Navigator.of(context).pop(false);
                                      },
                                      child: Text(nt.t.response.ok),
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        String reason = "No";
                                        registration = await submitApproval(
                                            ref, registration, false, reason);
                                        Navigator.of(context).pop(true);
                                      },
                                      child: Text(nt.t.response.cancel),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: RegistrationListTile(
                            registration: registration,
                            debugIndex: index + 1,
                            onPressed: () {
                              logNoStack.i("Clicked on ${registration.name}");
                              showDialog(
                                context: context,
                                builder: (context) => RegistrationDetailsScreen(
                                    registrationId: registration.id!,
                                    registration: registration),
                              );
                            },
                          ));
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<Registration> submitApproval(WidgetRef ref, Registration registration,
      bool approved, String reason) async {
    String token = ref.read(nestAuthProvider.notifier).token!;
    logNoStack.i("submitApproval $token");
    logNoStack.i("Registration Code = [${registration.code}]");
    String apiPath =
        "$defaultAPIBaseUrl$defaultApiPrefixPath/registrations/approve/${registration.code}/${approved ? 'true' : 'false'}?reason=$reason";
    logNoStack.i("apipath = $apiPath");

    var url = Uri.parse(apiPath);

    http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      },
      // encoding: Encoding.getByName('utf-8'),
    ).then((response) {
      logNoStack
          .i("submitApproval result = [${response.body}] (${response.statusCode})");
    });

    // var responseMap = await apiPostDataNoLocale( token, apiPath, null, null);

    // final http.Response response = await http.post(url,
    //       headers: {
    //         "Content-Type": "application/json",
    //         "Accept": "application/json",
    //         "Authorization": "Bearer $token",
    //       },
    //       encoding: Encoding.getByName('utf-8'),
    // );

    //   // var responseMap = await apiPostDataNoLocale( token, apiPath, null, null);
    //   logNoStack.i("submitApproval result = ${response.body} ${response.statusCode}");
    registration.approved = approved;
    registration.approvalReason = reason;
    return registration;
  }
}

class RegistrationListTileError extends ConsumerWidget {
  const RegistrationListTileError({
    super.key,
    required this.query,
    required this.page,
    required this.indexInPage,
    required this.isLoading,
    required this.error,
  });
  final String query;
  final int page;
  final int indexInPage;
  final bool isLoading;
  final String error;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // * Only show error on the first item of the page
    return indexInPage == 0
        ? Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(error),
                ElevatedButton(
                  onPressed: isLoading
                      ? null
                      : () {
                          // invalidate the provider for the errored page
                          ref.invalidate(fetchRegistrationsProvider(
                              queryData: (page: page, query: query)));
                          // wait until the page is loaded again
                          return ref.read(
                            fetchRegistrationsProvider(
                                queryData: (page: page, query: query)).future,
                          );
                        },
                  child: const Text('Retry'),
                ),
              ],
            ),
          )
        : const SizedBox.shrink();
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notifi/api_utils.dart';
import 'package:notifi/credentials.dart';

import 'package:notifi/i18n/strings.g.dart' as nt;
import 'package:logger/logger.dart' as logger;
import 'package:notifi/models/nestfilter.dart';
import 'package:notifi/organizations/src/features/organizations/data/organizations_repository_nf.dart';
import 'package:notifi/organizations/src/features/organizations/presentation/organization_details/organization_details_screen.dart';
import 'package:notifi/organizations/src/features/organizations/presentation/organizations/organization_form.dart';
import 'package:notifi/state/nest_auth2.dart';
import 'package:notifi/widgets/slide_left_background.dart';
import 'package:notifi/widgets/slide_right_background.dart';
import 'package:status_alert/status_alert.dart';

import 'organization_list_tile.dart';
import 'organization_list_tile_shimmer.dart';
import 'organizations_search_bar.dart';
import 'organizations_search_query_notifier.dart';

var log = logger.Logger(
  printer: logger.PrettyPrinter(),
  level: logger.Level.info,
);

var logNoStack = logger.Logger(
  printer: logger.PrettyPrinter(methodCount: 0),
  level: logger.Level.info,
);

class OrganizationsSearchScreen extends ConsumerWidget {
  const OrganizationsSearchScreen({super.key});

  static const pageSize = 20;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final query = ref.watch(organizationsSearchQueryNotifierProvider);
    // logNoStack.i("ORGS_SEARCH_SCREEN: query is $query , now setting AdamNestFilter");
    // ref.read(AdamNestFilterProvider(NestFilterType.organizations).notifier).setQuery(";name:$query;");
    // * get the first page so we can retrieve the total number of results
   // NestFilter nestFilter = NestFilter(query: ";name:$query");

    // final responseAsync = ref.watch(
    //   fetchOrganizationsNestFilterProvider,
    // );
    final responseAsync = ref.watch(fetchOrganizationsNestFilterProvider);
    final totalResults = responseAsync.valueOrNull?.totalPages;
    return Scaffold(
      appBar: AppBar(title: Text(nt.t.resources.organization)),
      body: Column(
        children: [
          const OrganizationsSearchBar(),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                // dispose all the pages previously fetched. Next read will refresh them
                ref.invalidate(fetchOrganizationsNestFilterProvider);
                // keep showing the progress indicator until the first page is fetched
                try {
                  // await ref.read(
                  //   fetchOrganizationsNestFilterProvider.future,
                  // );
                  await ref.read(
                    fetchOrganizationsNestFilterProvider.future,
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
                itemCount: totalResults,
                itemBuilder: (context, index) {
                  final page = index ~/ pageSize + 1;
                  final indexInPage = index % pageSize;
                  // use the fact that this is an infinite list to fetch a new page
                  // as soon as the index exceeds the page size
                  // Note that ref.watch is called for up to pageSize items
                  // with the same page and query arguments (but this is ok since data is cached)
                  NestFilter nestFilter =
                      NestFilter(offset: page, query: ";name:$query;");
                  // final responseAsync = ref.watch(
                  //   fetchOrganizationsNestFilterProvider,
                  // );
                  final responseAsync = ref.watch(
                    fetchOrganizationsNestFilterProvider,
                  );
                  return responseAsync.when(
                    error: (err, stack) => OrganizationListTileError(
                      query: query,
                      page: page,
                      indexInPage: indexInPage,
                      error: err.toString(),
                      isLoading: responseAsync.isLoading,
                    ),
                    loading: () => const OrganizationListTileShimmer(),
                    data: (response) {
                      //log('index: $index, page: $page, indexInPage: $indexInPage, len: ${response.results.length}');
                      // * This condition only happens if a null itemCount is given
                      if (indexInPage >= response.results.length) {
                        return null;
                      }
                      final organization = response.results[indexInPage];
                      return Dismissible(
                          key: Key(organization.id.toString()),
                          direction: DismissDirection.horizontal,
                          background: slideRightBackground(),
                          secondaryBackground: slideLeftBackground(),
                          confirmDismiss: (direction) {
                            if (direction == DismissDirection.endToStart) {
                              return showDialog<bool>(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text(nt.t.response.delete),
                                    content: Text(nt.t.response.delete_sure),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.of(context).pop(false),
                                        child: Text(nt.t.response.cancel),
                                      ),
                                      TextButton(
                                        onPressed: () async {
                                          var token = ref
                                              .read(nestAuthProvider.notifier)
                                              .token;
                                          var apiPath =
                                              "$defaultAPIBaseUrl$defaultApiPrefixPath/resources/remove/${organization.id}";
                                          // apiPath =
                                          //     Uri.encodeComponent(apiPath);
                                          logNoStack.i(
                                              "ORG_FORM: encodedApiPath is $apiPath");
                                          var response = await apiGetData(
                                              token!,
                                              apiPath,
                                              "application/json");
                                          logNoStack.i(
                                              "ORG_SEARCH_LIST: result ${response.statusCode}");
                                          if (response.statusCode == 200) {
                                            StatusAlert.show(
                                              context,
                                              duration:
                                                  const Duration(seconds: 3),
                                              title: nt.t.organization,
                                              subtitle: nt.t.form.deleted(
                                                  item: nt.t.organization_capitalized),
                                              configuration:
                                                  const IconConfiguration(
                                                      icon: Icons.done),
                                              maxWidth: 300,
                                            );
                                          }
                                          Navigator.of(context).pop(true);
                                        },
                                        child: Text(nt.t.response.delete),
                                      ),
                                    ],
                                  );
                                },
                              );
                            } else {
                              showDialog(
                                context: context,
                                builder: (context) => OrganizationDetailsScreen(
                                    organizationId: organization.id!,
                                    organization: organization),
                              );
                              return Future.value(false);
                            }
                          },
                          child: OrganizationListTile(
                            organization: organization,
                            debugIndex: index + 1,
                            onPressed: () {
                              logNoStack.i("Clicked on ${organization.name}");
                              showDialog(
                                context: context,
                                builder: (context) => OrganizationDetailsScreen(
                                    organizationId: organization.id!,
                                    organization: organization),
                              );
                            },
                            //   context.goNamed(
                            //   "organization",
                            //   pathParameters: {
                            //     'id': organization.id.toString()
                            //   },
                            //   extra: organization,
                            // );},
                          ));
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          logNoStack.i("ORGS_SEARCH_SCREEN: Add button pressed");
          showDialog(
            context: context,
            builder: (context) =>
                CreateOrganizationForm(formCode: "organization"),
          );
        },
        // foregroundColor: customizations[index].$1,
        // backgroundColor: customizations[index].$2,
        // shape:
        child: const Icon(Icons.add),
      ),
    );
  }
}

class OrganizationListTileError extends ConsumerWidget {
  const OrganizationListTileError({
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
                          NestFilter nestFilter =
                              NestFilter(offset: page, query: ";name:$query;");
                          ref.invalidate(fetchOrganizationsNestFilterProvider);
                          // ref.invalidate(fetchOrganizationsNestFilterProvider(
                          //     nestFilter: nestFilter));
                          // wait until the page is loaded again
                          // return ref.read(
                          //   fetchOrganizationsNestFilterProvider.future,
                          // );
                          return ref.read(
                            fetchOrganizationsNestFilterProvider.future,
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

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:notifi/norganizations/data/norganizations_repository.dart';
import 'package:notifi/norganizations/presentation/norganizations/norganization_form.dart';
import 'package:notifi/norganizations/presentation/norganizations/norganization_list_tile.dart';
import 'package:notifi/norganizations/presentation/norganizations/norganization_list_tile_shimmer.dart';
import 'package:notifi/norganizations/presentation/norganizations/norganizations_search_bar.dart';
import 'package:notifi/norganizations/presentation/norganizations/norganizations_search_query_notifier.dart';
import 'package:notifi/i18n/strings.g.dart' as nt;
import 'package:logger/logger.dart' as logger;

var log = logger.Logger(
  printer: logger.PrettyPrinter(),
  level: logger.Level.info,
);

var logNoStack = logger.Logger(
  printer: logger.PrettyPrinter(methodCount: 0),
  level: logger.Level.info,
);
class NOrganizationsSearchScreen extends ConsumerWidget {
  const NOrganizationsSearchScreen({super.key});

  static const pageSize =  10;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final query = ref.watch(nOrganizationsSearchQueryNotifierProvider);
    // * get the first page so we can retrieve the total number of results
    final responseAsync = ref.watch(
      fetchNOrganizationsProvider(queryData: (page: 0, query: query)),
    );
    final totalItems = responseAsync.valueOrNull?.totalItems;
    return Scaffold(
      appBar: AppBar(title:  Text(nt.t.resources.person)),
      body: Column(
        children: [
          const NOrganizationsSearchBar(),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                logNoStack.i("Refresh! totalresults = $totalItems");
                // dispose all the pages previously fetched. Next read will refresh them
                ref.invalidate(fetchNOrganizationsProvider);
                // keep showing the progress indicator until the first page is fetched
                try {
                  await ref.read(
                    fetchNOrganizationsProvider(queryData: (page: 0, query: query))
                        .future,
                  );
                } catch (e) {
                  // fail silently as the provider error state is handled inside the ListView
                }
              },
              child: ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
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
                    fetchNOrganizationsProvider(queryData: (page: page, query: query)),
                  );
                  return responseAsync.when(
                    error: (err, stack) => MovieListTileError(
                      query: query,
                      page: page,
                      indexInPage: indexInPage,
                      error: err.toString(),
                      isLoading: responseAsync.isLoading,
                    ),
                    loading: () => const NOrganizationListTileShimmer(),
                    data: (response) {
                      logNoStack.i("NOrganizations Response = $response");
                      //log('index: $index, page: $page, indexInPage: $indexInPage, len: ${response.results.length}');
                      // * This condition only happens if a null itemCount is given
                      if (indexInPage >= response.items.length) {
                        return null;
                      }
                      final norganization = response.items[indexInPage];
                      return NOrganizationListTile(
                        norganization: norganization,
                        debugIndex: index + 1,
                        onPressed: () => context.goNamed(
                          "norganization",
                          pathParameters: {'id': norganization.id.toString()},
                          extra: norganization,
                        ),
                      );
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
          logNoStack.i("NORGANIZATIONS_SEARCH_SCREEN: Add button pressed");
          showDialog(
            context: context,
            builder: (context) => CreateNOrganizationForm(formCode: "organization"),
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

class MovieListTileError extends ConsumerWidget {
  const MovieListTileError({
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
                          ref.invalidate(fetchNOrganizationsProvider(
                              queryData: (page: page, query: query)));
                          // wait until the page is loaded again
                          return ref.read(
                            fetchNOrganizationsProvider(
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

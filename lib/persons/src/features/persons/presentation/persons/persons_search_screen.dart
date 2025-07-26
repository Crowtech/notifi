import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notifi/forms/invite_form.dart';
import 'package:notifi/forms/person_form.dart';

import 'package:notifi/i18n/strings.g.dart' as nt;
import 'package:logger/logger.dart' as logger;
import 'package:notifi/persons/src/features/persons/presentation/person_details/person_details_screen.dart';
import 'package:notifi/widgets/slide_left_background.dart';
import 'package:notifi/widgets/slide_right_background.dart';

import '../../data/persons_repository.dart';
import 'person_list_tile.dart';
import 'person_list_tile_shimmer.dart';
import 'persons_search_bar.dart';
import 'persons_search_query_notifier.dart';

var log = logger.Logger(
  printer: logger.PrettyPrinter(),
  level: logger.Level.info,
);

var logNoStack = logger.Logger(
  printer: logger.PrettyPrinter(methodCount: 0),
  level: logger.Level.info,
);

class PersonsSearchScreen extends ConsumerWidget {
  const PersonsSearchScreen({super.key});

  static const pageSize = 20;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final query = ref.watch(personsSearchQueryNotifierProvider);
    // * get the first page so we can retrieve the total number of results
    final responseAsync = ref.watch(
      fetchPersonsProvider(queryData: (page: 0, query: query)),
    );
    final totalItems = responseAsync.valueOrNull?.totalItems;
    return Scaffold(
      appBar: AppBar(title: Text(nt.t.resources.person)),
      body: Column(
        children: [
          const PersonsSearchBar(),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                logNoStack.i("Refresh! ");
                // dispose all the pages previously fetched. Next read will refresh them
                ref.invalidate(fetchPersonsProvider);
                // keep showing the progress indicator until the first page is fetched
                try {
                  await ref.read(
                    fetchPersonsProvider(queryData: (page: 0, query: query))
                        .future,
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
                    fetchPersonsProvider(queryData: (page: page, query: query)),
                  );
                  return responseAsync.when(
                    error: (err, stack) => PersonListTileError(
                      query: query,
                      page: page,
                      indexInPage: indexInPage,
                      error: err.toString(),
                      isLoading: responseAsync.isLoading,
                    ),
                    loading: () => const PersonListTileShimmer(),
                    data: (response) {
                      //log('index: $index, page: $page, indexInPage: $indexInPage, len: ${response.results.length}');
                      // * This condition only happens if a null itemCount is given
                      if (indexInPage >= response.items!.length) {
                        return null;
                      }
                      final person = response.items![indexInPage];
                      return Dismissible(
                          key: Key(person.id.toString()),
                          direction: DismissDirection.horizontal,
                          background: slideRightBackground(),
                          secondaryBackground: slideLeftBackground(),
                          confirmDismiss: (direction) {
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
                                      onPressed: () =>
                                          Navigator.of(context).pop(true),
                                      child: Text(nt.t.response.delete),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: PersonListTile(
                            person: person,
                            debugIndex: index + 1,
                            onPressed: () {
                              logNoStack.i("Clicked on ${person.name}");
                              showDialog(
                                context: context,
                                builder: (context) => PersonDetailsScreen(
                                    personId: person.id!, person: person),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          logNoStack.i("PERSONS_SEARCH_SCREEN: Add button pressed");
          showDialog(
            context: context,
           builder: (context) => CreatePersonForm(formCode: "person"),
           //  builder: (context) => InviteForm(formCode: "person"),
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

class PersonListTileError extends ConsumerWidget {
  const PersonListTileError({
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
                          ref.invalidate(fetchPersonsProvider(
                              queryData: (page: page, query: query)));
                          // wait until the page is loaded again
                          return ref.read(
                            fetchPersonsProvider(
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

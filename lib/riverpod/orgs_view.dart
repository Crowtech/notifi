import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notifi/riverpod/orgs.dart';

class OrgListView extends ConsumerWidget {
  const OrgListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // rebuild the widget when the todo list changes
    final asyncOrgs = ref.watch(asyncOrgsProvider);

    // Let's render the todos in a scrollable list view
    return switch (asyncOrgs) {
      AsyncData(:final value) => ListView(
          children: [
            for (final org in value)
              CheckboxListTile(
                value: org.selected,
                // When tapping on the todo, change its completed status
                onChanged: (value) {
                  ref.read(asyncOrgsProvider.notifier).toggle(org.id);
                },
                title: Text(org.name),
              ),
          ],
        ),
      AsyncError(:final error) => Text('Error: $error'),
      _ => const Center(child: CircularProgressIndicator()),
    };
  }
}
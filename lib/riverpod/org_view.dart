// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:notifi/models/organization.dart';
// import 'package:notifi/riverpod/OrgNotifier.dart';


// class OrgListView extends ConsumerWidget {
//   const OrgListView({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     // rebuild the widget when the organization list changes
//     List<Organization> organizations = ref.watch(orgNotifierProvider);

//     // Let's render the organizations in a scrollable list view
//     return ListView(
//       children: [
//         for (final organization in organizations)
//           CheckboxListTile(
//             value: organization.selected,
//             // When tapping on the organization, change its completed status
//             onChanged: (value) => ref.read(orgNotifierProvider.notifier).toggle(organization.id!),
//             title: Text(organization.name!),
//           ),
//       ],
//     );
//   }
// }
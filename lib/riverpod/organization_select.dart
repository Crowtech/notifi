// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:notifi/models/organization.dart';
// import 'package:notifi/riverpod/current_organization.dart';
// import 'package:provider/provider.dart';


// class OrganizationSelect extends ConsumerStatefulWidget
//     with WidgetsBindingObserver {
//   final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
//   OrganizationSelect({super.key});

//   @override
//   ConsumerState<OrganizationSelect> createState() => _OrganizationSelectState();
// }

// class _OrganizationSelectState extends ConsumerState<OrganizationSelect> {

  
//   Organization value = defaultOrganization;

//   final items = List.generate(
//     4,
//     (index) => DropdownMenuItem(
//       child: Text("Company $index"),
//       value: Organization(id: index,orgType: 'org',url: 'https://org$index.com'),
//     ),
//   );

//   @override
//   void initState() {
//     super.initState();

//     ///setting default value  on provider
//     WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
//       ref.read(currentOrganizationProvider.notifier
// ).state = items[0].value!;
//     });
//   }
  
 
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             DropdownButton(
//               items: items,
//               value: value,
//               onChanged: (value) {
//                 context.read(currentOrganizationProvider
// ).state = value as Organization;
//                 setState(() {
//                   value = value;
//                 });
//               },
//             ),
//             RiverPodResponse(),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class RiverPodResponse extends ConsumerWidget {
//   const RiverPodResponse({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final dataNotifier = ref.watch(organizationSelectProvider);
//     return Container(
//       child: Text("${dataNotifier}"),
//     );
//   }
// }


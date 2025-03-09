import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OrganizationSelect extends ConsumerStatefulWidget {
  @override
  _OrganizationSelectState createState() => _OrganizationSelectState();
}

class _OrganizationSelectState extends ConsumerState<OrganizationSelect> {
  String value = "Company 0";

  final items = List.generate(
    4,
    (index) => DropdownMenuItem(
      child: Text("Company $index"),
      value: "Company $index",
    ),
  );

  @override
  void initState() {
    super.initState();

    ///setting default value  on provider
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      ref.read(dropItemProvider).state = items[0].value!;
    });
  }
  
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownButton(
              items: items,
              value: value,
              onChanged: (value) {
                context.read(dropItemProvider).state = value as String;
                setState(() {
                  value = value;
                });
              },
            ),
            RiverPodResponse(),
          ],
        ),
      ),
    );
  }
}

class RiverPodResponse extends ConsumerWidget {
  const RiverPodResponse({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dataNotifier = ref.watch(dropItemProvider);
    return Container(
      child: Text("${dataNotifier.state}"),
    );
  }
}

final dropItemProvider = StateProvider<String>((ref) => "");
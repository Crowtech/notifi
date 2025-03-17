import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notifi/models/crowtech_basepage.dart';
import 'package:notifi/models/person.dart';
import 'package:notifi/riverpod/users.dart';

class UsersConsumer extends ConsumerWidget {
  const UsersConsumer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    CrowtechBasePage<Person> users = ref.watch(usersProvider);

    return StreamBuilder(
        //1597917013710
        stream: Stream.periodic(const Duration(seconds: 2)),
        builder: (context, snapshot) {
          if (users.itemCount() > 0) {
            return Container(
              child: Column(
                children: <Widget>[
                  // Text(users.items![0].email),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: users.itemCount(),
                    itemBuilder: (context, index) {
                      return Text(users.items![index].email);
                    },
                  )
                ],
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        });
  }
}

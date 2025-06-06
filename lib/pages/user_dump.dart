import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart' as logger;
import 'package:notifi/i18n/strings.g.dart' as nt;
import 'package:notifi/models/person.dart';
import 'package:notifi/riverpod/info_widget.dart';
import 'package:notifi/state/nest_auth2.dart';



var log = logger.Logger(
  printer: logger.PrettyPrinter(),
  level: logger.Level.info,
);

var logNoStack = logger.Logger(
  printer: logger.PrettyPrinter(methodCount: 0),
  level: logger.Level.info,
);

class UserDump extends ConsumerWidget {
  const UserDump({super.key});




  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Person currentUser = ref.read(nestAuthProvider.notifier).currentUser;
    void tap2clipboard(String text) =>
      Clipboard.setData(ClipboardData(text: text)).then((_) {
         ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(nt.t.copied_to_clipboard(item: nt.t.text)))
      );
      });

    

    return 
    Scaffold(
      appBar: AppBar(
        title: Text('${currentUser.name} dump'), 
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InfoWidget(code: currentUser.code!),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _InfoTitle extends StatelessWidget {
  const _InfoTitle();

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(vertical: 32),
      child: Text(
        '☢️ Dev? User Dump ☢️',
        style: Theme.of(context)
            .textTheme
            .titleLarge
            ?.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }
}

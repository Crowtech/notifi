import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart' as logger;
import 'package:notifi/state/nest_auth2.dart';
import 'package:notifi/i18n/strings.g.dart' as nt;


var log = logger.Logger(
  printer: logger.PrettyPrinter(),
  level: logger.Level.info,
);

var logNoStack = logger.Logger(
  printer: logger.PrettyPrinter(methodCount: 0),
  level: logger.Level.info,
);

class LogoutItem extends ConsumerWidget {
  // IconData icon;
  // String text;
  //final VoidCallback callback;
  //final Function() onPressed;
  //final Function(Ref ref) onPressed;

  // AccountItem(
  //     {super.key,
  //     required this.icon,
  //     required this.text,
  //     required this.onPressed});

  const LogoutItem({super.key});


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future<void> logout() => ref.read(nestAuthProvider.notifier).signOut();
    // Future<void> logout() =>  ref.read(nestAuthProvider.notifier).signOut();

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      minVerticalPadding: 16,
      horizontalTitleGap: 16,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      leading: Icon(
        Icons.logout,
        color: Theme.of(context).primaryColor,
        size: 26,
      ),
      title: Text(
        nt.t.logout,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.w600,
            ),
      ),
      onTap: logout,
      hoverColor: Theme.of(context).hoverColor,
      focusColor: Theme.of(context).focusColor,
      selectedTileColor: Theme.of(context).indicatorColor,
      enableFeedback: true,
      mouseCursor: SystemMouseCursors.click,
    );
  }
}

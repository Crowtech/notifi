import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart' as logger;
import 'package:notifi/widgets/about_us.dart';

import 'menu_selection.dart';

var log = logger.Logger(
  printer: logger.PrettyPrinter(),
  level: logger.Level.info,
);

var logNoStack = logger.Logger(
  printer: logger.PrettyPrinter(methodCount: 0),
  level: logger.Level.info,
);

class AboutItem extends ConsumerWidget {
  const AboutItem(this.code, this.label, this.icon, this.selectedIcon,  this.appTitle,
      {super.key});

  final String code;
  final String label;
  final Widget icon;
  final Widget selectedIcon;
  final String appTitle;


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String selectedMenuItem = ref.watch(menuIndexProvider) as String;

    // switch (selectedMenuItem) {
    //   case "TEST":
    //     context.push(Routes.testpage);

    //   default:
    //    context.pop();
    // }

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      minVerticalPadding: 8,
      horizontalTitleGap: 16,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      leading: icon,
      title: Text(
        label,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.w600,
            ),
      ),
      onTap: () {
        context.pop();
       AboutUsDialog(context,appTitle);
        // showAboutDialog(
        //   context: context,
        //   applicationName: defaultRealm.capitalise(),
        //   applicationVersion: "7.12.0",
        //   applicationIcon: ImageIcon(
        //     AssetImage("images/logo.png"),
        //     color: Colors.red,
        //     size: 24,
        //   ),
        //   applicationLegalese: "Copyright 2025 - ${defaultRealm.capitalise()}",
        // );

        
      },
      hoverColor: Theme.of(context).hoverColor,
      focusColor: Theme.of(context).focusColor,
      selectedTileColor: Theme.of(context).indicatorColor,
      enableFeedback: true,
      mouseCursor: SystemMouseCursors.click,
    );
  }
}

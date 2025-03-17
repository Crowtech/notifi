import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart' as logger;
import 'package:notifi/i18n/strings.g.dart' as nt;
import 'package:oidc/oidc.dart';



var log = logger.Logger(
  printer: logger.PrettyPrinter(),
  level: logger.Level.info,
);

var logNoStack = logger.Logger(
  printer: logger.PrettyPrinter(methodCount: 0),
  level: logger.Level.info,
);

class AccountHeader extends ConsumerStatefulWidget with WidgetsBindingObserver {
  AccountHeader({super.key,this.appTitle='Crowtech App'});
  String appTitle;

  OidcPlatformSpecificOptions_Web_NavigationMode webNavigationMode =
      OidcPlatformSpecificOptions_Web_NavigationMode.newPage;

  @override
  ConsumerState<AccountHeader> createState() => _AccountHeaderState();
}

class _AccountHeaderState extends ConsumerState<AccountHeader> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        padding: EdgeInsets.zero,
        physics: const AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context)
                  .primaryColor, //EnterpriseTheme.secondarySystemBackground,
            ),
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
            child: SafeArea(
              child: Row(
                children: [
                  Image.asset(
                    'assets/images/logo.png',
                    width: 48,
                    height: 48,
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        widget.appTitle,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                      ),
                      Text(
                        nt.t.authored_by(name: nt.t.app_title),
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.white,
                            ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // ListTile(
          //   //focusColor: ,
          //   contentPadding:
          //       const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          //   minVerticalPadding: 16,
          //   horizontalTitleGap: 16,
          //   shape: RoundedRectangleBorder(
          //     borderRadius: BorderRadius.circular(8),
          //   ),
          //   leading: Icon(
          //     Icons.home,
          //     color: Theme.of(context).primaryColor,
          //     size: 26,
          //   ),
          //   title: Text(
          //     nt.t.home,
          //     style: Theme.of(context).textTheme.titleMedium?.copyWith(
          //           color: colorSeed,
          //           fontWeight: FontWeight.w600,
          //         ),
          //   ),
          //   onTap: () {
          //     context.pop();
          //   },
          //   hoverColor: Theme.of(context).hoverColor,
          //   focusColor: colorSeed,
          //   selectedTileColor: Theme.of(context).indicatorColor,
          //   enableFeedback: true,
          //   mouseCursor: SystemMouseCursors.click,
          // ),
        //  Divider(color: Colors.grey),
        ],
      ),
    );
  }
}

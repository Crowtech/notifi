import 'package:flutter/material.dart';
import 'package:notifi/common_widgets/empty_placeholder_widget.dart';
import 'package:notifi/i18n/strings.g.dart' as nt;

/// Simple not found screen used for 404 errors (page not found on web)
class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: EmptyPlaceholderWidget(
        message: nt.t.404_notfound,
        homeRoute: "home",
        loginRoute: "login",
      ),
    );
  }
}

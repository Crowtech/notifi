// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:notifi/widgets/menus/account.dart';
import 'package:notifi/widgets/menus/topleft_menu.dart';

class Header extends StatelessWidget {

 final String headertitle;
 final Widget topLeftMenu;
 final Widget topRightMenu;

 String get dashboardtitle => headertitle;
 
  const Header({super.key, this.headertitle="Desktop",
  this.topLeftMenu = const TopLeftMenu(), this.topRightMenu = const AccountMenu()});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        leading: const TopLeftMenu(),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.settings),
            onSelected: (value) {
              if (value == "Item 3") {
                // Handle Item 3 action
              } else if (value == "Item 4") {
                // Handle Item 4 action
              }
            },
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem(
                value: "Item 3",
                child: Text("Item 3"),
              ),
              const PopupMenuItem(
                value: "Item 4",
                child: Text("Item 4"),
              ),
            ],
          ),
        ],
      ),
      body: const Center(
        child: Text(
          "Dashboard Content Here",
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
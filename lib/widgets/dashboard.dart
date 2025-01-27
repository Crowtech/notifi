import 'package:flutter/material.dart';
import 'package:notifi/widgets/menus/account.dart';
import 'package:notifi/widgets/menus/topleft_menu.dart';

import 'menus/header.dart';

class Dashboard extends StatelessWidget {


 Widget header;

 
  Dashboard({super.key, this.header =  const Header.new()});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        leading: const TopLeftMenu.new(),
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
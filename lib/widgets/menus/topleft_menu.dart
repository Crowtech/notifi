
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TopLeftMenu extends StatelessWidget {
  const TopLeftMenu({super.key});
  
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
          icon: Icon(Icons.menu),
          onSelected: (value) {
            if (value == "Item 1") {
              // Handle Item 1 action
            } else if (value == "Item 2") {
              // Handle Item 2 action
            }
          },
          itemBuilder: (BuildContext context) => [
            PopupMenuItem(
              value: "Item 1",
              child: Text("Item 1"),
            ),
            PopupMenuItem(
              value: "Item 2",
              child: Text("Item 2"),
            ),
          ],
        );
  }
}

import 'package:flutter/material.dart';

class AccountMenu extends StatelessWidget {
  const AccountMenu({super.key});
  
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
          icon: const Icon(Icons.menu),
          onSelected: (value) {
            if (value == "Account") {
              // Handle Item 1 action
            } else if (value == "Profile") {
              // Handle Item 2 action
            }
          },
          itemBuilder: (BuildContext context) => [
            const PopupMenuItem(
              value: "Account",
              child: Text("Account"),
            ),
            const PopupMenuItem(
              value: "Profile",
              child: Text("Profile"),
            ),
          ],
        );
  }
}
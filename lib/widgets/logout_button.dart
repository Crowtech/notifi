import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:notifi/state/auth_controller.dart';


import 'action_button.dart';

class LogoutButton extends ConsumerWidget {
  const LogoutButton({super.key});


  @override
  Widget build(BuildContext context, WidgetRef ref) {
     Future<void> logout() => ref.read(authControllerProvider.notifier).logout(
         context
        );
        
    return ActionButton(
      onPressed: logout,
      icon: const Icon(Icons.logout),
      label: const Text('Logout'),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../state/auth_controller.dart';

import 'action_button.dart';
import 'package:notifi/i18n/strings.g.dart' as nt;

class LogoutButton extends ConsumerWidget {
  const LogoutButton({super.key});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
        
    return ActionButton(
      onPressed: ref.read(authControllerProvider.notifier).logout,
      icon: const Icon(Icons.logout),
      label: const Text(nt.t.logout),
    );
  }



}
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../state/auth_controller.dart';

import '../state/nest_auth2.dart';
import 'action_button.dart';
import 'package:notifi/i18n/strings.g.dart' as nt;

class LogoutButton extends ConsumerWidget {
  const LogoutButton({super.key});
  
 

  @override
  Widget build(BuildContext context, WidgetRef ref) {
        
 Future<void> logout() => ref.read(nestAuthProvider.notifier).signOut();

    return ActionButton(
      onPressed:  logout,
      icon: const Icon(Icons.logout),
      label:  Text(nt.t.logout),
    );
  }



}
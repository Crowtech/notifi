import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../constants/app_sizes.dart';
import '../state/nest_auth2.dart';
import 'primary_button.dart';

/// Placeholder widget showing a message and CTA to go back to the home screen.
class EmptyPlaceholderWidget extends ConsumerWidget {
  const EmptyPlaceholderWidget({super.key, this.homeRoute='/home',this.loginRoute='/login',required this.message}); 
  
  final String message;
  final String homeRoute;
  final String loginRoute;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(Sizes.p16),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              message,
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            gapH32,
            PrimaryButton(
              onPressed: () {
                final isLoggedIn =
                    ref.read(nestAuthProvider);
                context.goNamed(
                    isLoggedIn ? homeRoute : loginRoute);
              },
              text: 'Go Home',
            )
          ],
        ),
      ),
    );
  }
}

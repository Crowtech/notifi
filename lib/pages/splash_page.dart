
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../state/auth_controller.dart';
import '../widgets/loading_spinner.dart';
import 'package:logger/logger.dart' as logger;

var log = logger.Logger(
  printer: logger.PrettyPrinter(),
  level: logger.Level.info,
);

var logNoStack = logger.Logger(
  printer: logger.PrettyPrinter(methodCount: 0),
  level: logger.Level.info,
);



class SplashPage extends ConsumerWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userName = ref.watch(
    authControllerProvider.selectAsync(
      (value) => value.map(
        signedIn: (signedIn) => signedIn.displayName,
        signedOut: (signedOut) => '',
      ),
    ),
  );
     logNoStack.i( 'SPLASH PAGE: $userName',);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Splash Page: $userName'),
            const SizedBox(height: 16),
            const LoadingSpinner(),
          ],
        ),
      ),
    );
  }
}

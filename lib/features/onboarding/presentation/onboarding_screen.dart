import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:notifi/credentials.dart';
import 'package:notifi/i18n/string_hardcoded.dart';
import 'package:notifi/jwt_utils.dart';


import '../../../common_widgets/primary_button.dart';
import '../../../common_widgets/responsive_center.dart';
import '../../../constants/app_sizes.dart';
import '../../../routing/app_router.dart';
import 'onboarding_controller.dart';
import 'package:logger/logger.dart' as logger;


var log = logger.Logger(
  printer: logger.PrettyPrinter(),
  level: logger.Level.info,
);

var logNoStack = logger.Logger(
  printer: logger.PrettyPrinter(methodCount: 0),
  level: logger.Level.info,
);

class OnboardingScreen extends ConsumerWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    logNoStack.i("ONBOARDING SCREEN: build");
    final state = ref.watch(onboardingControllerProvider);
    FlutterNativeSplash.remove();
    return Scaffold(
      body: ResponsiveCenter(
        maxContentWidth: 450,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Location As a Service.\nTrack Your Friends!',
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            gapH16,
            SvgPicture.asset(
              'assets/logo.svg',
              width: 200,
              height: 200,
              semanticsLabel: defaultRealm.capitalise(),
            ),
            gapH16,
            PrimaryButton(
              text: 'Get Started'.hardcoded,
              isLoading: state.isLoading,
              onPressed: state.isLoading
                  ? null
                  : () async {
                      await ref
                          .read(onboardingControllerProvider.notifier)
                          .completeOnboarding();
                          logNoStack.i("ONBOARDING SCREEN: completed.");
                      if (context.mounted) {
                        // go to sign in page after completing onboarding
                        context.goNamed(AppRoute.login.name);
                      }
                    },
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:logger/logger.dart' as logger;
// Importing localization strings

var log = logger.Logger(
  printer: logger.PrettyPrinter(),
  level: logger.Level.info,
);

var logNoStack = logger.Logger(
  printer: logger.PrettyPrinter(methodCount: 0),
  level: logger.Level.info,
);

class UrlLink extends ConsumerWidget {
  UrlLink(
      {super.key,
      this.url = "https://www.crowtech.com.au",
      this.sourceText = "Developed by Crowtech",
      this.linkText = "Crowtech"});

  final String url;
  String sourceText;
  String linkText;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final bodyTextStyle =
        textTheme.bodyLarge!.apply(color: colorScheme.onPrimary);

    final repoLinkIndex = sourceText.indexOf(linkText);
    final repoLinkIndexEnd = repoLinkIndex + linkText.length;
    final seeSourceFirst = sourceText.substring(0, repoLinkIndex);
    final seeSourceSecond = sourceText.substring(repoLinkIndexEnd);
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            style: bodyTextStyle,
            text: seeSourceFirst,
          ),
          TextSpan(
            style: bodyTextStyle.copyWith(
              color: colorScheme.primary,
            ),
            text: linkText,
            recognizer: TapGestureRecognizer()
              ..onTap = () async {
                if (await canLaunch(url)) {
                  await launch(
                    url,
                    forceSafariVC: false,
                  );
                }
              },
          ),
          TextSpan(
            style: bodyTextStyle,
            text: seeSourceSecond,
          ),
        ],
      ),
    );
  }
}

Future<bool> launchLink(String url, {bool isNewTab = true}) async {
    return await launchUrl(
        Uri.parse(url),
        webOnlyWindowName: isNewTab ? '_blank' : '_self',
    );
}
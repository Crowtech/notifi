
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:notifi/jwt_utils.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../credentials.dart';

void showAboutDialog({
  required BuildContext context,
  required String? name,
  required String dialogText,
  required String linkText,
  required String urlLink,
}) {
  if (name == null) {
    name = defaultRealm.capitalise();
  }
  showDialog<void>(
    context: context,
    builder: (context) {
      return _AboutDialog(name:name!,dialogText:dialogText,linkText:linkText,urlLink:urlLink);
    },
  );
}

Future<String> getVersionNumber() async {
  final packageInfo = await PackageInfo.fromPlatform();
  return packageInfo.version;
}

class _AboutDialog extends ConsumerWidget {

  _AboutDialog({required this.name, required this.dialogText,required this.linkText, required this.urlLink});

  String name;
  String dialogText;
  String linkText;
  String urlLink;
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
 final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final bodyTextStyle =
        textTheme.bodyLarge!.apply(color: colorScheme.onPrimary);

    String legalese = '© 2025 $name Pty Ltd'; // Don't need to localize.

    final repoLinkIndex = dialogText.indexOf(linkText);
    final repoLinkIndexEnd = repoLinkIndex + linkText.length;
    final seeSourceFirst = dialogText.substring(0, repoLinkIndex);
    final seeSourceSecond = dialogText.substring(repoLinkIndexEnd);

    return AlertDialog(
      backgroundColor: colorScheme.background,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      content: Container(
        constraints: const BoxConstraints(maxWidth: 400),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            FutureBuilder(
              future: getVersionNumber(),
              builder: (context, snapshot) => SelectableText(
                snapshot.hasData ? '$name ${snapshot.data}' : name,
                style: textTheme.headlineMedium!.apply(
                  color: colorScheme.onPrimary,
                ),
              ),
            ),
            const SizedBox(height: 24),
            SelectableText.rich(
              TextSpan(
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
                        final url =
                            Uri.parse(urlLink);
                        if (await canLaunchUrl(url)) {
                          await launchUrl(url);
                        }
                      },
                  ),
                  TextSpan(
                    style: bodyTextStyle,
                    text: seeSourceSecond,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            SelectableText(
              legalese,
              style: bodyTextStyle,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute<void>(
              builder: (context) => Theme(
                data: Theme.of(context).copyWith(
                  textTheme: Typography.material2018(
                    platform: Theme.of(context).platform,
                  ).black,
                  cardColor: Colors.white,
                ),
                child: LicensePage(
                  applicationName: name!,
                  applicationLegalese: legalese,
                ),
              ),
            ));
          },
          child: Text(
            MaterialLocalizations.of(context).viewLicensesButtonLabel,
          ),
        ),
        TextButton(
          onPressed: () {
            context.pop();
          },
          child: Text(MaterialLocalizations.of(context).closeButtonLabel),
        ),
      ],
    );
  }


}
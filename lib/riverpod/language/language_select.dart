import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:notifi/riverpod/async_value_widget.dart';
import 'package:notifi/riverpod/language/language_enum.dart';
import 'package:notifi/riverpod/language/language_repository.dart';
import 'package:notifi/riverpod/language/localization_controller.dart';

class SideDrawer extends StatelessWidget {
  const SideDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Column(
          children: [
            Consumer(builder: (BuildContext context, WidgetRef ref, Widget? child) {
              final language = ref.watch(currentLanguageProvider);
              return AsyncValueWidget(
                value: language,
                data: (currentLanguage) => DropdownButton(
                  value: currentLanguage,
                  items: [
                    for (var eachLanguage in LanguageEnum.values)
                      DropdownMenuItem(
                        value: eachLanguage,
                        child: Text(eachLanguage.name),
                      ),
                  ],
                  onChanged: (value) async {
                    if (value != null) {
                      await ref.read(localizationControllerProvider.notifier).setLanguage(value);
                    }
                  },
                ),
              );
                }),
              ],
            ),
        ),
      );

  }
}


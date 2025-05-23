import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:notifi/state/nuclear_codes.dart';
import 'package:notifi/i18n/strings.g.dart' as nt;
import 'package:logger/logger.dart' as logger;

var log = logger.Logger(
  printer: logger.PrettyPrinter(),
  level: logger.Level.info,
);

var logNoStack = logger.Logger(
  printer: logger.PrettyPrinter(methodCount: 0),
  level: logger.Level.info,
);

class NotifyPage extends ConsumerWidget {
  const NotifyPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final codes = ref.watch(nuclearCodesProvider);

    return Scaffold(
         appBar: AppBar(
        title: const Text('Notify'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  child: Text(nt.t.devpage,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Woah, notify!!!.',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                const Flexible(
                  child: CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(child: _NotifyTitle()),

                    ],
                  ),
                ),
                const SizedBox(height: 40),
      
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NotifyTitle extends StatelessWidget {
  const _NotifyTitle();

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(vertical: 32),
      child: Text(
        '☢️ Dev? Notify!!!! ☢️',
        style: Theme.of(context)
            .textTheme
            .titleLarge
            ?.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }
}

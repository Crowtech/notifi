import 'package:go_router/go_router.dart';

import '../providers/bottom_nav_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../i18n/strings.g.dart' as nt;
import 'package:logger/logger.dart' as logger;


var log = logger.Logger(
  printer: logger.PrettyPrinter(),
  level: logger.Level.info,
);

var logNoStack = logger.Logger(
  printer: logger.PrettyPrinter(methodCount: 0),
  level: logger.Level.info,
);

class TestPage extends ConsumerWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bodies = [
      Center(
        child: Text("Hello From ${nt.t.home}"),
      ),
      Center(
        child: Text("Hello From ${nt.t.favourite}"),
      ),
      Center(
        child: Text('Hello From ${nt.t.settings}'),
      ),
    ];
    final indexBottomNavbar = ref.watch(indexBottomNavbarProvider);
    return Scaffold(
            appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.pop();
          },
        ),
        title: Text(nt.t.test_page),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: indexBottomNavbar,
        onTap: (value) {
          ref.read(indexBottomNavbarProvider.notifier).update((state) => value);
        },
        items:  [
          BottomNavigationBarItem(icon: const Icon(Icons.home), label: nt.t.home),
          BottomNavigationBarItem(
              icon: const Icon(Icons.favorite), label: nt.t.favourite),
          BottomNavigationBarItem(icon: const Icon(Icons.settings), label: nt.t.settings),
        ],
      ),
      body: bodies[indexBottomNavbar],
    );
  }
}
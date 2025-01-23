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

class MainPage extends ConsumerWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bodies = [
      const Center(
        child: Text('Hello From Home'),
      ),
      const Center(
        child: Text('Hello From Favorite'),
      ),
      const Center(
        child: Text('Hello From Settings'),
      ),
    ];
    final indexBottomNavbar = ref.watch(indexBottomNavbarProvider);
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: indexBottomNavbar,
        onTap: (value) {
          ref.read(indexBottomNavbarProvider.notifier).update((state) => value);
        },
        items:  [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: nt.t.home),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: nt.t.favourite),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: nt.t.settings),
        ],
      ),
      body: bodies[indexBottomNavbar],
    );
  }
}
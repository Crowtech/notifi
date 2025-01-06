// Copyright 2022 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

var logger = Logger(
  printer: PrettyPrinter(),
);

class StarButton extends StatefulWidget {
  const StarButton({super.key});

  @override
  State<StarButton> createState() => _StarButtonState();
}

class _StarButtonState extends State<StarButton> {
  bool state = false;
  late final ColorScheme _colorScheme = Theme.of(context).colorScheme;

  Icon get icon {
    final IconData iconData = state ? Icons.star : Icons.star_outline;

    return Icon(
      iconData,
      color: Colors.grey,
      size: 20,
    );
  }

  void _toggle() {
    setState(() {
      state = !state;
    });
  }

  double get turns => state ? 1 : 0;

  @override
  Widget build(BuildContext context) {
    return AnimatedRotation(
      turns: turns,
      curve: Curves.decelerate,
      duration: const Duration(milliseconds: 300),
      child: FloatingActionButton(
        heroTag: null,
        elevation: 0,
        shape: const CircleBorder(),
        backgroundColor: _colorScheme.surface,
        onPressed: () {
          _toggle();
          logger.d("Star Button $state");
        },
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: icon,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart' as logger;


var log = logger.Logger(
  printer: logger.PrettyPrinter(),
  level: logger.Level.info,
);

var logNoStack = logger.Logger(
  printer: logger.PrettyPrinter(methodCount: 0),
  level: logger.Level.info,
);

Widget devWidget(BuildContext context, String code, IconData iconData) {
  return Column(
    children: [
      IconButton(
          onPressed: () {
            context.push('/${code.toLowerCase()}');
          },
          icon: Icon(iconData)),
      const SizedBox(
        height: 10,
      ),
      Text(code),
    ],
  );
}



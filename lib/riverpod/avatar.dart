import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart' as logger;
import 'package:notifi/jwt_utils.dart';

import '../models/person.dart';

var log = logger.Logger(
  printer: logger.PrettyPrinter(),
  level: logger.Level.info,
);

var logNoStack = logger.Logger(
  printer: logger.PrettyPrinter(methodCount: 0),
  level: logger.Level.info,
);

class AvatarFetcher extends Notifier<Widget> {
  static const int defaultDiameter = 68;
  final String defaultUrl =
      "https://gravatar.com/avatar/${generateMd5('unknown@unknown.com')}?s=${defaultDiameter}";
  static const Color defaultBackgroundColour = Colors.red;

  @override
  Widget build() {
    return getAvatar((defaultDiameter<<1).toDouble(),defaultUrl,defaultBackgroundColour);
  }

  void display(
      {bool userReady = false,
      Person? person,
      int diameter = defaultDiameter,
      Color backgroundColour = defaultBackgroundColour}) async {
    String personUrl = defaultUrl;

    if ((person != null) && (userReady)) {
      personUrl = person.getAvatarUrl();
    }
    state = getAvatar((diameter << 1).toDouble(), personUrl, backgroundColour);
  }

  Widget getAvatar(
      final double radius, final String imageUrl, Color backgroundColour) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: backgroundColour,
      child: CircleAvatar(
        radius: radius - 2,
        backgroundImage: NetworkImage(imageUrl),
      ),
    );
  }
}

// Notifier provider holding the state
final avatarProvider =
    NotifierProvider<AvatarFetcher, Widget>(AvatarFetcher.new);

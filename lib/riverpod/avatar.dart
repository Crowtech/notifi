import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart' as logger;
import 'package:notifi/credentials.dart';
import 'package:notifi/jwt_utils.dart';
import 'package:notifi/riverpod/current_user.dart';

import '../models/person.dart';

var log = logger.Logger(
  printer: logger.PrettyPrinter(),
  level: logger.Level.info,
);

var logNoStack = logger.Logger(
  printer: logger.PrettyPrinter(methodCount: 0),
  level: logger.Level.info,
);

class UserAvatar extends ConsumerWidget {
  int diameter;
  Color backgroundColour;
  static const String defaultInitials = "?";

  UserAvatar({super.key, this.diameter = 68, this.backgroundColour = Colors.red});

  @override
   Widget build(BuildContext context, WidgetRef ref) {
    Person user = ref.watch(currentUserProvider);
     String personUrl = user.getAvatarUrl();
    String initials =  user.getInitials();
    String avatarUrl = "$defaultImageProxyUrl/${diameter}x/$personUrl";

  
    return getAvatar((diameter<<1).toDouble(),avatarUrl,backgroundColour,initials);
  }

  Widget getAvatar(
      final double radius, final String imageUrl, Color backgroundColour, String initials) {
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
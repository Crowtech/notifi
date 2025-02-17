import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart' as logger;
import 'package:notifi/credentials.dart';
import 'package:notifi/riverpod/current_user.dart';

import '../models/person.dart';
import '../state/nest_auth2.dart';

var log = logger.Logger(
  printer: logger.PrettyPrinter(),
  level: logger.Level.info,
);

var logNoStack = logger.Logger(
  printer: logger.PrettyPrinter(methodCount: 0),
  level: logger.Level.info,
);

String defaultUrl = "$defaultMinioEndpointUrl/$defaultRealm/adam51casual.png";
class NestAvatar extends ConsumerWidget {
  int diameter;
  Color backgroundColour;
  static const String defaultInitials = "?";

  NestAvatar({super.key, this.diameter = 68, this.backgroundColour = Colors.red});

  @override
   Widget build(BuildContext context, WidgetRef ref) {
    Person user = ref.read(nestAuthProvider.notifier).currentUser;
    String personUrl = defaultUrl;
    String initials = defaultInitials;
logNoStack.i("avatarUrl=${user.avatarUrl} diameter = $diameter initials = $initials");
   if (user.avatarUrl != null) {
     personUrl = user.getAvatarUrl();
    initials =  user.getInitials();
   }
    String avatarUrl = "$defaultImageProxyUrl/${diameter}x/$personUrl";
   
   
    return getAvatar((diameter>>1).toDouble(),avatarUrl,backgroundColour,initials);
  }

  Widget getAvatar(
      final double radius, final String imageUrl, Color backgroundColour, String initials) {
    String imgUrl = defaultUrl;

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
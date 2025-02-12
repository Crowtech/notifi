import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart' as logger;
import 'package:notifi/credentials.dart';
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

String defaultUrl = "$defaultMinioEndpointUrl/$defaultRealm/adam51casual.png";

class NestAvatar extends ConsumerWidget {
  int diameter;
  Color backgroundColour;
  static const String defaultInitials = "?";
  final Color? borderColor = Colors.red;
  final double? borderWidth = 2;

  NestAvatar(
      {super.key, this.diameter = 68, this.backgroundColour = Colors.yellow});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Person user = ref.watch(currentUserProvider);
    String personUrl = defaultUrl;
    String initials = defaultInitials;
    log.i(
        "avatarUrl=${user.avatarUrl} diameter = $diameter initials = $initials, backgroundColour is ${backgroundColour.toString()}");
    if (user.avatarUrl != null) {
      personUrl = user.getAvatarUrl();
      initials = user.getInitials();
    }
    String avatarUrl = "$defaultImageProxyUrl/${diameter}x/$personUrl";

    return getAvatar(
        (diameter >> 1).toDouble(), avatarUrl, backgroundColour, initials);
  }

  Widget getAvatar(final double radius, final String imageUrl,
      Color backgroundColour, String initials) {
    String imgUrl = defaultUrl;
logNoStack.i(
        "GET avatarInfo=${imageUrl} radius= $radius initials = $initials, backgroundColour is ${backgroundColour.toString()}");
   //return Container(
    //  decoration: _borderDecoration(),

      //child: 
     return CircleAvatar(
        radius: radius - borderWidth!,
        backgroundColor: backgroundColour,
         backgroundImage: NetworkImage(imageUrl) ,
       // child: imageUrl == null ? Icon(Icons.camera_alt, size: radius) : null,
      );
    //);

  
  }

  Decoration? _borderDecoration() {
    if (borderColor != null && borderWidth != null) {
      return BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: borderColor!,
          width: borderWidth!,
        ),
      );
    }
    return null;
  }
}

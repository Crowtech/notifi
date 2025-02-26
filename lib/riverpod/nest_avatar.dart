import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart' as logger;
import 'package:notifi/credentials.dart';
import 'package:notifi/riverpod/refresh_widget.dart';
import 'package:notifi/state/nest_auth2.dart';

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
  Person person;

  NestAvatar(
      {super.key,
      this.diameter = 68,
      this.backgroundColour = Colors.red,
      required this.person});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //final status = ref.watch(RefreshWidgetProvider(person.code));
    //logNoStack.i("NEST_AVATAR: BUILD! status is $status");
    Person currentUser = ref.read(nestAuthProvider.notifier).currentUser;
    //if (currentUser.email == person.email) {
      // update person with latest currentUser to ensure updates flow through
    //  person = currentUser;
    //}
    String initials = defaultInitials;
    logNoStack.i(
        "avatarUrl=${person.avatarUrl} diameter = $diameter initials = $initials ");
    String? avatarUrl;
    if (person.avatarUrl?.isEmpty ?? true) {
     
    } else {
       avatarUrl = "$defaultImageProxyUrl/${diameter}x/${person.getAvatarUrl()}";
    
    }
    initials = person.getInitials();
    return getAvatar(
        (diameter >> 1).toDouble(), avatarUrl, backgroundColour, initials);
  }

  Widget getAvatar(final double radius, final String? imageUrl,
      Color backgroundColour, String initials) {
    Widget displayWidget;
    if (!(imageUrl?.isEmpty ?? true)) {
      displayWidget = CircleAvatar(
        radius: radius - 2,
        backgroundImage: NetworkImage(imageUrl!),
      );
    } else {
      displayWidget = Text(initials);
    }

    return CircleAvatar(
      radius: radius,
      backgroundColor: backgroundColour,
      child: displayWidget,
    );
  }
}

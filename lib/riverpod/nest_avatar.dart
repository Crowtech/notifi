import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart' as logger;
import 'package:notifi/credentials.dart';

import '../models/person.dart';
import 'refresh_widget.dart';

var log = logger.Logger(
  printer: logger.PrettyPrinter(),
  level: logger.Level.info,
);

var logNoStack = logger.Logger(
  printer: logger.PrettyPrinter(methodCount: 0),
  level: logger.Level.info,
);

//String defaultUrl = "$defaultMinioEndpointUrl/$defaultRealm/adam51casual.png";

class NestAvatar extends ConsumerWidget {
  int diameter;
  Color backgroundColour;
  static const String defaultInitials = "?";
  Person person;
  String lastUUID = "";

  NestAvatar(
      {super.key,
      this.diameter = 68,
      this.backgroundColour = Colors.red,
      required this.person});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var latestUUID = ref.watch(RefreshWidgetProvider(person.code!));
    if (lastUUID != latestUUID) {

      lastUUID = latestUUID;
      rebuildAllChildren(context);
    }
    //logNoStack.i("NEST_AVATAR: BUILD! status is $status");
   // Person currentUser = ref.read(nestAuthProvider.notifier).currentUser;
    //if (currentUser.email == person.email) {
      // update person with latest currentUser to ensure updates flow through
    //  person = currentUser;
    //}
    String initials = defaultInitials;
    logNoStack.i(
        "NEST_AVATAR: avatarUrl=${person.avatarUrl} diameter = $diameter initials = $initials status =$status");
    String? avatarUrl;
    if (person.avatarUrl?.isEmpty ?? true) {
      avatarUrl = null;
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

  void rebuildAllChildren(BuildContext context) {
  void rebuild(Element el) {
    el.markNeedsBuild();
    el.visitChildren(rebuild);
  }
  (context as Element).visitChildren(rebuild);
}
}

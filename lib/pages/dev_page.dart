// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notifi/entities/user_role.dart';
import 'package:notifi/notifi.dart';
import 'package:notifi/state/permissions.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'package:go_router/go_router.dart';
import '../i18n/strings.g.dart' as nt; // Importing localization strings
import 'package:logger/logger.dart' as logger;

var log = logger.Logger(
  printer: logger.PrettyPrinter(),
  level: logger.Level.info,
);

var logNoStack = logger.Logger(
  printer: logger.PrettyPrinter(methodCount: 0),
  level: logger.Level.info,
);

/// Camera example home widget.
class DevPage extends ConsumerStatefulWidget {
  /// Default Constructor
  const DevPage({super.key});

  @override
  ConsumerState<DevPage> createState() {
    return _DevPageState();
  }
}

class _DevPageState extends ConsumerState<DevPage>
    with WidgetsBindingObserver, TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    logNoStack.i("DEV_PAGE: init");
  }

  @override
  void dispose() {
    logNoStack.i("DEV_PAGE: dispose");
    super.dispose();
  }

  // #docregion AppLifecycle
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.inactive) {
      logNoStack.i("DEV_PAGE: AppLifeCycleState inactive");
    } else if (state == AppLifecycleState.resumed) {
      logNoStack.i("DEV_PAGE: AppLifeCycleState resumed");
    }
  }

  @override
  Widget build(BuildContext context) {
     SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    logNoStack.i("DEV_PAGE: build");
    var responseAsync = ref.watch(permissionsProvider);
   if (responseAsync.hasValue) {
      logNoStack.i("DEV_PAGE: permissionsProvider has value");
      var role = responseAsync.value;
            logNoStack.i("DEV_PAGE: permissionsProvider value is $role");
      if (role != const UserRole.dev()) {
        context.goNamed("home");
      }

    } else {
      logNoStack.i("DEV_PAGE: permissionsProvider has NO value");
      context.goNamed("home");
    }


    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            dispose();
            context.pop(false);
          },
        ),
        title: Text(nt.t.camera_title),
      ),
      body: Column(
        children: const [
          Text("Dev Page"),
        ],
      ),
    );
  }
}

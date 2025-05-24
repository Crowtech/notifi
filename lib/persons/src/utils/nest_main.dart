
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:ui';

import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:logger/logger.dart' as logger;
import 'package:notifi/credentials.dart';
import 'package:notifi/jwt_utils.dart';
import 'package:notifi/models/appversion.dart';
import 'package:notifi/models/gps.dart';
import 'package:notifi/models/nestfilter.dart';
import 'package:notifi/models/person.dart';


var log = logger.Logger(
  printer: logger.PrettyPrinter(),
  level: logger.Level.info,
);

var logNoStack = logger.Logger(
  printer: logger.PrettyPrinter(methodCount: 0),
  level: logger.Level.info,
);


Future<void> NestMain() async 
{
  FlutterError.onError = (details) {
    FlutterError.presentError(details);
    //if (kReleaseMode) exit(1);
  };
}
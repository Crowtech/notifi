import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart' as logger;
import 'package:notifi/state/fcm_controller.dart';


var log = logger.Logger(
  printer: logger.PrettyPrinter(),
  level: logger.Level.info,
);

var logNoStack = logger.Logger(
  printer: logger.PrettyPrinter(methodCount: 0),
  level: logger.Level.info,
);


// ignore: must_be_immutable
class FirebaseFcm extends ConsumerWidget {

  FirebaseOptions? options;
  
  FirebaseFcm({super.key,required this.options});

  @override
   Widget build(BuildContext context, WidgetRef ref)  {
  return Consumer(
      builder: (context, ref, child) {
        final fcm = ref.watch(fcmProvider(options));
      
      
        // We can then render both activities.
        // Both requests will happen in parallel and correctly be cached.
        return Column(
          children: [
            Text(fcm.hasValue ? '${fcm.value!}':'' ),
          ],
        );
      },
    );
  }

  
}

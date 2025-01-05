// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:session_storage/session_storage.dart';

import '../themes.dart';

class SplashScreen extends StatefulWidget {
  String nextScreenRoute;
  SplashScreen({super.key,required this.nextScreenRoute});

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToLogin();
  }

  _navigateToLogin() async {
    await Future.delayed(const Duration(seconds: 2), () {});
    context.go(widget.nextScreenRoute);
  }

  @override
  Widget build(BuildContext context) {
    SessionStorage storage = SessionStorage();

    return Visibility(
      visible: storage["skipOnboarding"] != "true",
      child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        return Stack(
          fit: StackFit.expand,
          children: [
            // Background Image
            Container(
              decoration: BoxDecoration(color: white),
              child: Image.asset(
                'assets/images/background_splash.png', // Replace with your background image path
                fit: BoxFit.cover,
              ),
            ),

            // Centered Logo
            Center(
              child: SizedBox(
                height: 161,
                child: Image.asset(
                  'assets/images/logo.png',
                  //color: secondary, // Set the height as neededd
                ),
              ),
            ),
            // Visibility(
            //   visible: kIsWeb,
            //   child: buildTokenMonitor(),
            // ),
          ],
        );
      }),
    );
  }
}





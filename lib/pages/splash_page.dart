
import 'package:flutter/material.dart';

import '../widgets/loading_spinner.dart';

class SplashPage extends StatelessWidget {
  SplashPage(String this.splashText,{super.key});
  String splashText;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(splashText),
            SizedBox(height: 16),
            LoadingSpinner(),
          ],
        ),
      ),
    );
  }
}

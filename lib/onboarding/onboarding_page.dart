import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:notifi/constants/app_sizes.dart';
import 'package:notifi/credentials.dart';
import 'package:notifi/jwt_utils.dart';

class OnboardingPage extends StatelessWidget { 
  final Color color; 
  final String image; 
  final String title; 
  final String subtitle; 

 const OnboardingPage({super.key, required this.color,required this.image,required this.title, required this.subtitle});
 
  @override 
  Widget build(BuildContext context) { 
    const double verticalSpacing = 20; 
    const double horizontalSpacing = 20; 

double imageWidth = 400; // default
  
    // OnboardingPage 
    return Container( 
      padding: const EdgeInsets.only( 
        left: horizontalSpacing, 
        right: horizontalSpacing, 
      ), 
      color: color, // BackgroundColor 
      child: Column( 
        crossAxisAlignment: CrossAxisAlignment.center, 
        mainAxisAlignment: MainAxisAlignment.center, 
        children: [ 
           Row(
            mainAxisAlignment: MainAxisAlignment.center,
 
              children: [
                 SvgPicture.asset(
              'assets/images/onboarding-logo.svg',
              width: 100,
              height: 100,
              semanticsLabel: defaultRealm.capitalise(),
                 ),
                //  Text(defaultRealm.capitalise(),
                //  textScaleFactor: 6.0,),
              ]
            ),
             gapH16,
          // Image 
          Image.asset(image, width: imageWidth, height: imageWidth), 
          const SizedBox(height: verticalSpacing), 
          // Title 
          Center( 
            child: Text( 
              title, 
              textAlign: TextAlign.center, 
              style: const TextStyle( 
                color: Colors.black, 
                fontSize: 24, 
              ), 
            ), 
          ), 
          const SizedBox(height: verticalSpacing), 
          // Subtitle 
          Center( 
            child: Text( 
              subtitle, 
              textAlign: TextAlign.center, 
              style: const TextStyle( 
                color: Colors.black, 
                fontSize: 18, 
                fontWeight: FontWeight.normal, 
              ), 
            ), 
          ), 
        ], 
      ), 
    ); 
  } 
} 
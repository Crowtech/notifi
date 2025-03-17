
import 'package:flutter/material.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:notifi/models/person.dart';
import 'package:notifi/riverpod/nest_avatar.dart';


CurrentLocationLayer  currentUserLocation(BuildContext context, {Person? person, double size=33, Color colour=Colors.green}) {

  // Widget displayDot;
  // if (person == null) {

  //       displayDot =        Icon(
  //                             Icons.person,
  //                             color: Colors.white,
  //                           ), 
  //               onPressed: () {  },
  //              )
  //   );
  // }
  return  CurrentLocationLayer(
                indicators: const LocationMarkerIndicators(),
            style: LocationMarkerStyle(
              marker: DefaultLocationMarker(
                color: colour,
                child: IconButton(
              icon: 
              NestAvatar(
                person: person!,
                  diameter: size.round(),
                  backgroundColour: Theme.of(context).primaryColor),
              onPressed: null,
              tooltip: person.name,
            ),
                // Icon(
                //  Icons.person,
                //  color: Colors.white,
                // ), 
                // onPressed: () {  },
               // ),
              ),
              markerSize:  Size.square(size),
              accuracyCircleColor: Colors.green.withOpacity(0.1),
              headingSectorColor: Colors.green.withOpacity(0.8),
              headingSectorRadius: size,
              
            ),
            moveAnimationDuration: Duration.zero, // disable animation
          );
}

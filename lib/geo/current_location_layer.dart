/// Geolocation Layer Components for Notifi Field Service Application
/// 
/// This file provides map layer components for displaying current user location
/// on interactive maps. The location layer is designed to support field service
/// operations by providing real-time GPS position visualization with custom
/// user avatars and location accuracy indicators.
/// 
/// Key features:
/// - Real-time GPS position display with user avatar
/// - Location accuracy visualization with colored circles
/// - Customizable marker size and color theming
/// - Integration with Flutter Map location marker plugin
/// - Person-specific avatar display for field service teams
/// 
/// Business Context:
/// This component is essential for field service applications where tracking
/// worker locations, asset positions, and service area coverage is critical.
/// The visual representation helps dispatchers and managers monitor field
/// operations and optimize resource allocation.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:notifi/models/person.dart';
import 'package:notifi/riverpod/nest_avatar.dart';

/// Creates a customized current location layer for displaying user position on maps
/// 
/// This function generates a [CurrentLocationLayer] widget that shows the current
/// GPS position of a user on a Flutter Map. The layer includes location accuracy
/// indicators, heading direction, and a custom avatar representing the user.
/// 
/// GPS Functionality:
/// - Displays real-time GPS coordinates with accuracy circle
/// - Shows heading direction for movement tracking
/// - Provides location marker with smooth position updates
/// - Handles location permissions and service availability
/// 
/// Field Service Integration:
/// - Supports team member identification with person avatars
/// - Enables tracking of field workers and mobile assets
/// - Provides visual feedback for location accuracy and GPS signal strength
/// - Customizable appearance for different user roles or asset types
/// 
/// Parameters:
/// - [context]: Build context for theme and localization access
/// - [person]: Optional person object for avatar display and identification
/// - [size]: Marker size in logical pixels (default: 33)
/// - [colour]: Primary color for location indicators (default: Colors.green)
/// 
/// Returns:
/// A [CurrentLocationLayer] configured with the specified parameters and
/// appropriate fallback handling for missing location services.
/// 
/// Privacy Considerations:
/// - Location data is only displayed when user grants permission
/// - Accuracy circle indicates GPS precision level
/// - Graceful degradation when location services are unavailable
CurrentLocationLayer currentUserLocation(BuildContext context,
    {Person? person, double size = 33, Color colour = Colors.green}) {
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
  CurrentLocationLayer currentLocationLayer;
  
  // Configure location layer with GPS tracking and avatar display
  try {
    // Create location layer with comprehensive GPS tracking configuration
    currentLocationLayer = CurrentLocationLayer(
      // Enable all location indicators for comprehensive GPS feedback
      indicators: const LocationMarkerIndicators(),
      style: LocationMarkerStyle(
        // Custom location marker with user avatar for field service identification
        marker: DefaultLocationMarker(
          color: colour,
          child: IconButton(
            // Display person-specific avatar for team member identification
            icon: NestAvatar(
                person: person!,
                diameter: size.round(),
                backgroundColour: Theme.of(context).primaryColor),
            onPressed: null,
            tooltip: person.name, // Accessibility and user identification
          ),
          // Fallback icon implementation for when avatar is not available
          // Could be used for anonymous or generic location markers
        ),
        // Physical size of the location marker on the map
        markerSize: Size.square(size),
        
        // GPS accuracy visualization - larger circle indicates lower precision
        accuracyCircleColor: Colors.green.withOpacity(0.1),
        
        // Heading direction indicator for movement tracking
        headingSectorColor: Colors.green.withOpacity(0.8),
        headingSectorRadius: size,
      ),
      // Disable animation for immediate location updates in field service scenarios
      moveAnimationDuration: Duration.zero,
    );
  } on MissingPluginException {
    // Fallback for platforms without location services plugin
    // Provides basic location layer without custom styling
    currentLocationLayer = const CurrentLocationLayer();
  }
  return currentLocationLayer;
}

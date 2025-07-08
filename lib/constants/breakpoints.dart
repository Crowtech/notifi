/// Responsive design breakpoints for the Notifi application.
///
/// This file defines the screen width breakpoints used to create responsive
/// layouts that adapt to different device sizes and orientations. These
/// breakpoints follow Material Design guidelines and common industry standards
/// for mobile-first responsive design.
///
/// The breakpoint system enables the application to provide optimal user
/// experiences across different device categories:
/// - Mobile phones (< 600px width)
/// - Tablets (600px - 899px width)  
/// - Desktop/Web (≥ 900px width)
///
/// Usage Example:
/// ```dart
/// Widget build(BuildContext context) {
///   final screenWidth = MediaQuery.of(context).size.width;
///   
///   if (screenWidth >= Breakpoint.desktop) {
///     return DesktopLayout();
///   } else if (screenWidth >= Breakpoint.tablet) {
///     return TabletLayout();
///   } else {
///     return MobileLayout();
///   }
/// }
/// ```
///
/// Design Considerations:
/// - These breakpoints are based on logical pixels, not physical pixels
/// - Always test layouts at and around these breakpoint values
/// - Consider using LayoutBuilder for more complex responsive logic
/// - Ensure touch targets remain accessible across all breakpoints
///
/// Important: When modifying these values, test thoroughly across different
/// devices and screen sizes to ensure consistent user experience.
class Breakpoint {
  /// Desktop breakpoint (900px and above).
  ///
  /// This breakpoint defines the minimum width for desktop/web layouts.
  /// At this width and above, the application can safely assume:
  /// - Larger screen real estate available
  /// - Possible mouse/keyboard interaction
  /// - Multi-column layouts are feasible
  /// - More complex navigation patterns can be used
  /// - Hover states and tooltips are appropriate
  ///
  /// Common use cases:
  /// - Side navigation panels
  /// - Multi-column content layouts
  /// - Complex data tables
  /// - Toolbar with multiple actions
  /// - Modal dialogs with more content
  static const double desktop = 900;

  /// Tablet breakpoint (600px to 899px).
  ///
  /// This breakpoint defines the minimum width for tablet layouts.
  /// Between this value and the desktop breakpoint, the application
  /// should provide tablet-optimized experiences:
  /// - Medium screen real estate
  /// - Primarily touch interaction
  /// - Hybrid layouts (between mobile and desktop)
  /// - Comfortable reading widths
  /// - Optimized for both portrait and landscape orientations
  ///
  /// Common use cases:
  /// - Adaptive grid layouts
  /// - Collapsible navigation
  /// - Side-by-side content in landscape
  /// - Larger touch targets than mobile
  /// - Modified spacing for comfortable viewing
  ///
  /// Note: Screens below this breakpoint (< 600px) are considered
  /// mobile devices and should use mobile-first responsive layouts.
  static const double tablet = 600;
}

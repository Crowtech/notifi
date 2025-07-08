/// Responsive layout widgets that adapt to different screen sizes.
/// 
/// This file contains widgets that help create responsive layouts by
/// constraining content width and centering it appropriately based on
/// available space. These widgets are essential for creating layouts
/// that work well across different screen sizes and devices.
/// 
/// The widgets use the application's breakpoint system to determine
/// appropriate maximum widths and ensure content remains readable
/// and well-proportioned on all devices.

import 'package:flutter/material.dart';

import '../constants/breakpoints.dart';

/// A responsive widget that centers content with a maximum width constraint.
/// 
/// This widget provides a flexible layout solution that adapts to different
/// screen sizes. On larger screens, it constrains the content width and
/// centers it, while on smaller screens, it allows the content to use the
/// full available width.
/// 
/// This approach ensures optimal readability and visual balance across
/// all device sizes, from mobile phones to desktop computers.
/// 
/// Example usage:
/// ```dart
/// ResponsiveCenter(
///   maxContentWidth: 600,
///   padding: EdgeInsets.all(16),
///   child: MyContent(),
/// )
/// ```
class ResponsiveCenter extends StatelessWidget {
  /// Creates a [ResponsiveCenter] with the specified constraints and child.
  /// 
  /// The [maxContentWidth] determines the maximum width of the content.
  /// The [padding] is applied around the content.
  /// The [child] is the widget to be displayed with responsive constraints.
  const ResponsiveCenter({
    super.key,
    this.maxContentWidth = Breakpoint.desktop,
    this.padding = EdgeInsets.zero,
    required this.child,
  });
  
  /// The maximum width allowed for the content.
  /// 
  /// When the available width exceeds this value, the content will be
  /// centered and constrained to this maximum width. On smaller screens,
  /// the content will use the full available width.
  final double maxContentWidth;
  
  /// Padding applied around the content.
  /// 
  /// This padding is applied inside the width constraints, ensuring
  /// consistent spacing regardless of screen size.
  final EdgeInsetsGeometry padding;
  
  /// The child widget to display with responsive constraints.
  /// 
  /// This widget will be centered and width-constrained according to
  /// the responsive layout rules.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    // Use Center widget to provide unconstrained width (loose constraints)
    // This allows the content to be centered when the screen is wider
    // than the maximum content width
    return Center(
      // SizedBox provides tight width constraints up to the maximum width
      // On smaller screens, it will use the full available width
      // See: https://twitter.com/biz84/status/1445400059894542337
      child: SizedBox(
        width: maxContentWidth,
        child: Padding(
          padding: padding,
          child: child,
        ),
      ),
    );
  }
}

/// A sliver-based responsive widget that works within scrollable contexts.
/// 
/// This widget provides the same responsive centering behavior as
/// [ResponsiveCenter] but is designed to work within sliver-based
/// scrollable widgets like CustomScrollView.
/// 
/// It wraps a [ResponsiveCenter] within a [SliverToBoxAdapter], making
/// it compatible with sliver-based layouts while maintaining the same
/// responsive behavior and constraints.
/// 
/// Example usage:
/// ```dart
/// CustomScrollView(
///   slivers: [
///     ResponsiveSliverCenter(
///       maxContentWidth: 800,
///       child: MyContent(),
///     ),
///   ],
/// )
/// ```
class ResponsiveSliverCenter extends StatelessWidget {
  /// Creates a [ResponsiveSliverCenter] with the specified constraints and child.
  /// 
  /// The [maxContentWidth] determines the maximum width of the content.
  /// The [padding] is applied around the content.
  /// The [child] is the widget to be displayed with responsive constraints.
  const ResponsiveSliverCenter({
    super.key,
    this.maxContentWidth = Breakpoint.desktop,
    this.padding = EdgeInsets.zero,
    required this.child,
  });
  
  /// The maximum width allowed for the content.
  /// 
  /// When the available width exceeds this value, the content will be
  /// centered and constrained to this maximum width. On smaller screens,
  /// the content will use the full available width.
  final double maxContentWidth;
  
  /// Padding applied around the content.
  /// 
  /// This padding is applied inside the width constraints, ensuring
  /// consistent spacing regardless of screen size.
  final EdgeInsetsGeometry padding;
  
  /// The child widget to display with responsive constraints.
  /// 
  /// This widget will be centered and width-constrained according to
  /// the responsive layout rules.
  final Widget child;
  
  @override
  Widget build(BuildContext context) {
    // Wrap ResponsiveCenter in SliverToBoxAdapter to make it compatible
    // with sliver-based scrollable widgets
    return SliverToBoxAdapter(
      child: ResponsiveCenter(
        maxContentWidth: maxContentWidth,
        padding: padding,
        child: child,
      ),
    );
  }
}

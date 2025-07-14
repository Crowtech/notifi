/// Application sizing constants and spacing utilities for the Notifi app.
/// 
/// This file contains the centralized design system constants for consistent
/// spacing, padding, and layout throughout the application. These values are
/// based on an 8-point grid system (multiples of 4) commonly used in mobile
/// design for visual consistency and accessibility.
/// 
/// The constants are organized into three main categories:
/// 1. [Sizes] - Raw double values for padding, margin, and spacing
/// 2. Gap widths - Pre-built [SizedBox] widgets for horizontal spacing
/// 3. Gap heights - Pre-built [SizedBox] widgets for vertical spacing
/// 
/// Usage Example:
/// ```dart
/// Container(
///   padding: EdgeInsets.all(Sizes.p16),
///   child: Column(
///     children: [
///       Text('Title'),
///       gapH12, // Vertical space
///       Text('Content'),
///     ],
///   ),
/// )
/// ```
/// 
/// Design Guidelines:
/// - Use p4 and p8 for tight spacing (list items, small elements)
/// - Use p12 and p16 for standard spacing (general padding, margins)
/// - Use p20 and p24 for comfortable spacing (section separators)
/// - Use p32+ for large spacing (page-level separators, hero sections)
/// 
/// Important: When modifying these values, ensure they maintain the 4-point
/// grid system for consistent spacing across all platforms and screen sizes.
library;
import 'package:flutter/material.dart';

/// Core sizing constants following a 4-point grid system for consistent spacing.
/// 
/// This class provides standardized spacing values that ensure visual consistency
/// across the entire application. All values are multiples of 4 to align with
/// modern design systems and accessibility guidelines.
/// 
/// The naming convention uses 'p' prefix (padding/point) followed by the pixel value.
class Sizes {
  /// Extra small spacing (4px) - Used for very tight spacing between related elements
  /// Common uses: Icon-to-text spacing, small decorative elements, fine-tuned adjustments
  static const p4 = 4.0;
  
  /// Small spacing (8px) - Used for compact layouts and list item spacing  
  /// Common uses: List item internal padding, compact form field spacing, small gaps
  static const p8 = 8.0;
  
  /// Medium-small spacing (12px) - Used for comfortable yet compact spacing
  /// Common uses: Card internal padding, form field vertical spacing, moderate gaps
  static const p12 = 12.0;
  
  /// Standard spacing (16px) - The most commonly used spacing value
  /// Common uses: General padding, standard margins, default component spacing
  static const p16 = 16.0;
  
  /// Medium-large spacing (20px) - Used for increased visual separation
  /// Common uses: Section internal padding, comfortable form spacing, medium gaps
  static const p20 = 20.0;
  
  /// Large spacing (24px) - Used for significant visual separation
  /// Common uses: Page-level padding, section separators, large component margins
  static const p24 = 24.0;
  
  /// Extra large spacing (32px) - Used for major layout separation
  /// Common uses: Screen-level padding, major section separators, prominent spacing
  static const p32 = 32.0;
  
  /// Jumbo spacing (48px) - Used for substantial visual breaks
  /// Common uses: Hero section spacing, major page separators, prominent layouts
  static const p48 = 48.0;
  
  /// Maximum spacing (64px) - Used for maximum visual impact and separation
  /// Common uses: Full-page separators, hero sections, maximum emphasis spacing
  static const p64 = 64.0;
}

/// Pre-built horizontal spacing widgets for consistent layout spacing.
/// 
/// These [SizedBox] widgets provide standardized horizontal gaps that correspond
/// to the [Sizes] constants. They are particularly useful in [Row] widgets,
/// [Wrap] widgets, or any horizontal layout where consistent spacing is needed.
/// 
/// Benefits of using these constants:
/// - Ensures consistent horizontal spacing across the app
/// - Reduces code duplication and improves maintainability
/// - Makes layout adjustments easier (change once, update everywhere)
/// - Provides clear semantic meaning for spacing purposes

/// Extra small horizontal gap (4px) - For tight horizontal spacing
const gapW4 = SizedBox(width: Sizes.p4);

/// Small horizontal gap (8px) - For compact horizontal layouts
const gapW8 = SizedBox(width: Sizes.p8);

/// Medium-small horizontal gap (12px) - For comfortable compact spacing
const gapW12 = SizedBox(width: Sizes.p12);

/// Standard horizontal gap (16px) - Most common horizontal spacing
const gapW16 = SizedBox(width: Sizes.p16);

/// Medium-large horizontal gap (20px) - For increased separation
const gapW20 = SizedBox(width: Sizes.p20);

/// Large horizontal gap (24px) - For significant separation
const gapW24 = SizedBox(width: Sizes.p24);

/// Extra large horizontal gap (32px) - For major layout separation
const gapW32 = SizedBox(width: Sizes.p32);

/// Jumbo horizontal gap (48px) - For substantial visual breaks
const gapW48 = SizedBox(width: Sizes.p48);

/// Maximum horizontal gap (64px) - For maximum visual impact
const gapW64 = SizedBox(width: Sizes.p64);

/// Pre-built vertical spacing widgets for consistent layout spacing.
/// 
/// These [SizedBox] widgets provide standardized vertical gaps that correspond
/// to the [Sizes] constants. They are particularly useful in [Column] widgets,
/// [ListView] widgets, or any vertical layout where consistent spacing is needed.
/// 
/// Benefits of using these constants:
/// - Ensures consistent vertical spacing across the app
/// - Reduces code duplication and improves maintainability  
/// - Makes layout adjustments easier (change once, update everywhere)
/// - Provides clear semantic meaning for spacing purposes

/// Extra small vertical gap (4px) - For tight vertical spacing
const gapH4 = SizedBox(height: Sizes.p4);

/// Small vertical gap (8px) - For compact vertical layouts
const gapH8 = SizedBox(height: Sizes.p8);

/// Medium-small vertical gap (12px) - For comfortable compact spacing
const gapH12 = SizedBox(height: Sizes.p12);

/// Standard vertical gap (16px) - Most common vertical spacing
const gapH16 = SizedBox(height: Sizes.p16);

/// Medium-large vertical gap (20px) - For increased separation
const gapH20 = SizedBox(height: Sizes.p20);

/// Large vertical gap (24px) - For significant separation
const gapH24 = SizedBox(height: Sizes.p24);

/// Extra large vertical gap (32px) - For major layout separation
const gapH32 = SizedBox(height: Sizes.p32);

/// Jumbo vertical gap (48px) - For substantial visual breaks
const gapH48 = SizedBox(height: Sizes.p48);

/// Maximum vertical gap (64px) - For maximum visual impact
const gapH64 = SizedBox(height: Sizes.p64);

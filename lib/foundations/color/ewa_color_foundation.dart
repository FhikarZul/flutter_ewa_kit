import 'package:flutter/material.dart';

/// Color foundation for the EWA Kit that supports both light and dark modes
class EwaColorFoundation {
  EwaColorFoundation._();

  // Primary colors
  static const Color primaryLight = Color(0xFF0DAA4E);
  static const Color primaryDark = Color(0xFF4ADE80);

  // Secondary colors
  static const Color secondaryLight = Color(0xFF1E40AF);
  static const Color secondaryDark = Color(0xFF60A5FA);

  // Error colors
  static const Color errorLight = Color(0xFFDC2626);
  static const Color errorDark = Color(0xFFF87171);

  // Neutral colors
  static const Color neutral10 = Color(0xFFFAFAFA);
  static const Color neutral20 = Color(0xFFF5F5F5);
  static const Color neutral30 = Color(0xFFE5E5E5);
  static const Color neutral40 = Color(0xFFD4D4D4);
  static const Color neutral50 = Color(0xFFFAFAFA);
  static const Color neutral100 = Color(0xFFF5F5F5);
  static const Color neutral200 = Color(0xFFE5E5E5);
  static const Color neutral300 = Color(0xFFD4D4D4);
  static const Color neutral400 = Color(0xFFA3A3A3);
  static const Color neutral500 = Color(0xFF737373);
  static const Color neutral600 = Color(0xFF525252);
  static const Color neutral700 = Color(0xFF404040);
  static const Color neutral800 = Color(0xFF262626);
  static const Color neutral900 = Color(0xFF171717);

  // Text colors
  static const Color textLight = Color(0xFF171717);
  static const Color textDark = Color(0xFFFAFAFA);

  // Background colors
  static const Color backgroundLight = Color(0xFFFFFFFF);
  static const Color backgroundDark = Color(0xFF000000);

  // Utility method to get appropriate color based on brightness
  /// Resolves color based on current theme brightness
  ///
  /// Returns [darkColor] when theme is dark, [lightColor] otherwise.
  ///
  /// Example:
  /// ```dart
  /// final color = EwaColorFoundation.resolveColor(
  ///   context,
  ///   Colors.black, // light theme color
  ///   Colors.white, // dark theme color
  /// );
  /// ```
  static Color resolveColor(
    BuildContext context,
    Color lightColor,
    Color darkColor,
  ) {
    final brightness = Theme.of(context).brightness;
    return brightness == Brightness.dark ? darkColor : lightColor;
  }

  // Get primary color based on theme
  /// Gets the primary color from the app's ColorScheme or fallback to EWA Kit default
  static Color getPrimary(BuildContext context) {
    // Try to get from app's ColorScheme first
    try {
      return Theme.of(context).colorScheme.primary;
    } catch (_) {
      // Fallback to EWA Kit default colors
      return resolveColor(context, primaryLight, primaryDark);
    }
  }

  // Get secondary color based on theme
  /// Gets the secondary color from the app's ColorScheme or fallback to EWA Kit default
  static Color getSecondary(BuildContext context) {
    try {
      return Theme.of(context).colorScheme.secondary;
    } catch (_) {
      return resolveColor(context, secondaryLight, secondaryDark);
    }
  }

  // Get error color based on theme
  /// Gets the error color from the app's ColorScheme or fallback to EWA Kit default
  static Color getError(BuildContext context) {
    try {
      return Theme.of(context).colorScheme.error;
    } catch (_) {
      return resolveColor(context, errorLight, errorDark);
    }
  }

  // Get text color based on theme
  /// Gets the text color from the app's ColorScheme or fallback to EWA Kit default
  static Color getText(BuildContext context) {
    try {
      return Theme.of(context).colorScheme.onSurface;
    } catch (_) {
      return resolveColor(context, textLight, textDark);
    }
  }

  // Get background color based on theme
  /// Gets the background color from the app's ColorScheme or fallback to EWA Kit default
  static Color getBackground(BuildContext context) {
    try {
      return Theme.of(context).colorScheme.surface;
    } catch (_) {
      return resolveColor(context, backgroundLight, backgroundDark);
    }
  }
}

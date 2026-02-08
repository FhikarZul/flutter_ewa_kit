import 'package:ewa_kit/foundations/color/ewa_color_foundation.dart';
import 'package:flutter/material.dart';

/// Pre-configured theme data using EWA Kit color foundation.
///
/// Simplifies MaterialApp theme setup with EWA Kit design tokens.
///
/// Example:
/// ```dart
/// MaterialApp(
///   theme: EwaTheme.light(),
///   darkTheme: EwaTheme.dark(),
///   themeMode: ThemeMode.system,
///   home: HomePage(),
/// )
/// ```
class EwaTheme {
  EwaTheme._();

  /// Creates a light theme using EWA Kit colors
  static ThemeData light() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.light(
        primary: EwaColorFoundation.primaryLight,
        secondary: EwaColorFoundation.secondaryLight,
        error: EwaColorFoundation.errorLight,
        surface: EwaColorFoundation.backgroundLight,
        onPrimary: EwaColorFoundation.textDark,
        onSecondary: EwaColorFoundation.textDark,
        onError: EwaColorFoundation.textDark,
        onSurface: EwaColorFoundation.textLight,
      ),
    );
  }

  /// Creates a dark theme using EWA Kit colors
  static ThemeData dark() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.dark(
        primary: EwaColorFoundation.primaryDark,
        secondary: EwaColorFoundation.secondaryDark,
        error: EwaColorFoundation.errorDark,
        surface: EwaColorFoundation.backgroundDark,
        onPrimary: EwaColorFoundation.textLight,
        onSecondary: EwaColorFoundation.textLight,
        onError: EwaColorFoundation.textLight,
        onSurface: EwaColorFoundation.textDark,
      ),
    );
  }

  /// Creates a theme from a seed color (Material 3 style)
  static ThemeData fromSeed({
    required Color seedColor,
    Brightness brightness = Brightness.light,
  }) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: seedColor,
        brightness: brightness,
      ),
    );
  }
}

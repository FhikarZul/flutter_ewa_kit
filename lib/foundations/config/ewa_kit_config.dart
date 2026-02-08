import 'package:ewa_kit/foundations/config/ewa_kit_overrides.dart';
import 'package:flutter/material.dart';

/// Global configuration for EWA Kit components
///
/// This class allows customization of default values across all EWA Kit components.
/// Modify these values to match your design system.
///
/// Example:
/// ```dart
/// void main() {
///   EwaKitConfig.debounceDuration = Duration(milliseconds: 300);
///   EwaKitConfig.designSize = Size(414, 896); // iPhone 11 Pro Max
///   runApp(MyApp());
/// }
/// ```
class EwaKitConfig {
  EwaKitConfig._();

  /// Default debounce duration for buttons (default: 500ms)
  static Duration debounceDuration = const Duration(milliseconds: 500);

  /// Design size for responsive scaling (default: 375x812 - iPhone X)
  static Size designSize = const Size(375, 812);

  /// Enable debug mode for additional logging
  static bool debugMode = false;

  /// Default button border width
  static double borderWidth = 1.0;

  /// Default spinner size for loading states
  static double spinnerSize = 20.0;

  /// Default locale for date formatting (default: id_ID)
  static String defaultLocale = 'id_ID';

  /// Reset all configurations and service overrides to default values
  static void resetToDefaults() {
    debounceDuration = const Duration(milliseconds: 500);
    designSize = const Size(375, 812);
    debugMode = false;
    borderWidth = 1.0;
    spinnerSize = 20.0;
    defaultLocale = 'id_ID';
    EwaKitOverrides.reset();
  }
}

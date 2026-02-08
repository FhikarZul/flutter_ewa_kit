import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ewa_kit/foundations/theme/ewa_theme.dart';
import 'package:ewa_kit/foundations/color/ewa_color_foundation.dart';

void main() {
  group('EwaTheme', () {
    test('light() should return ThemeData with correct brightness', () {
      final theme = EwaTheme.light();
      expect(theme.brightness, Brightness.light);
      expect(theme.useMaterial3, true);
    });

    test('light() should use EWA Kit primary color', () {
      final theme = EwaTheme.light();
      expect(theme.colorScheme.primary, EwaColorFoundation.primaryLight);
      expect(theme.colorScheme.secondary, EwaColorFoundation.secondaryLight);
      expect(theme.colorScheme.error, EwaColorFoundation.errorLight);
    });

    test('dark() should return ThemeData with dark brightness', () {
      final theme = EwaTheme.dark();
      expect(theme.brightness, Brightness.dark);
      expect(theme.useMaterial3, true);
    });

    test('dark() should use EWA Kit colors', () {
      final theme = EwaTheme.dark();
      expect(theme.colorScheme.primary, EwaColorFoundation.primaryDark);
      expect(theme.colorScheme.secondary, EwaColorFoundation.secondaryDark);
    });

    test('fromSeed() should return ThemeData', () {
      final theme = EwaTheme.fromSeed(
        seedColor: Colors.blue,
        brightness: Brightness.light,
      );
      expect(theme, isA<ThemeData>());
      expect(theme.useMaterial3, true);
    });
  });
}

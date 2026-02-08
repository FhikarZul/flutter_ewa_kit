import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ewa_kit/foundations/config/ewa_kit_config.dart';

void main() {
  group('EwaKitConfig', () {
    tearDown(() {
      EwaKitConfig.resetToDefaults();
    });

    test('should have default values', () {
      expect(
        EwaKitConfig.debounceDuration,
        const Duration(milliseconds: 500),
      );
      expect(EwaKitConfig.designSize, const Size(375, 812));
      expect(EwaKitConfig.debugMode, false);
      expect(EwaKitConfig.borderWidth, 1.0);
      expect(EwaKitConfig.spinnerSize, 20.0);
      expect(EwaKitConfig.defaultLocale, 'id_ID');
    });

    test('should allow customization', () {
      EwaKitConfig.debounceDuration = const Duration(milliseconds: 300);
      EwaKitConfig.designSize = const Size(414, 896);
      EwaKitConfig.defaultLocale = 'en_US';

      expect(EwaKitConfig.debounceDuration, const Duration(milliseconds: 300));
      expect(EwaKitConfig.designSize, const Size(414, 896));
      expect(EwaKitConfig.defaultLocale, 'en_US');
    });

    test('resetToDefaults should restore values', () {
      EwaKitConfig.debounceDuration = const Duration(seconds: 1);
      EwaKitConfig.designSize = const Size(100, 100);
      EwaKitConfig.resetToDefaults();

      expect(
        EwaKitConfig.debounceDuration,
        const Duration(milliseconds: 500),
      );
      expect(EwaKitConfig.designSize, const Size(375, 812));
    });
  });
}

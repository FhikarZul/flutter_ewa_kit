import 'package:flutter_test/flutter_test.dart';
import 'package:ewa_kit/foundations/size/ewa_border_radius.dart';

void main() {
  group('EwaBorderRadius', () {
    test('should have all border radius values defined', () {
      expect(EwaBorderRadius.xs, isNotNull);
      expect(EwaBorderRadius.sm, isNotNull);
      expect(EwaBorderRadius.md, isNotNull);
      expect(EwaBorderRadius.lg, isNotNull);
      expect(EwaBorderRadius.xl, isNotNull);
    });

    test('should have correct border radius values', () {
      expect(EwaBorderRadius.xs, 6.0);
      expect(EwaBorderRadius.sm, 8.0);
      expect(EwaBorderRadius.md, 12.0);
      expect(EwaBorderRadius.lg, 16.0);
      expect(EwaBorderRadius.xl, 24.0);
    });
  });
}

import 'package:flutter_test/flutter_test.dart';
import 'package:ewa_kit/ewa_kit.dart';

void main() {
  group('PNButton', () {
    test('color foundation resolves colors correctly', () {
      // Test that our color foundation exists and has the expected structure
      expect(EwaColorFoundation.primaryLight, isNotNull);
      expect(EwaColorFoundation.primaryDark, isNotNull);
    });

    test('button enums exist', () {
      // Test that our button enums exist
      expect(EwaButtonVariant.primary, isNotNull);
      expect(EwaButtonType.filled, isNotNull);
    });
  });
}

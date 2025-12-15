import 'package:flutter_test/flutter_test.dart';

// Import all test files
import 'foundations/color_foundation_test.dart' as color_foundation_test;
import 'foundations/border_radius_test.dart' as border_radius_test;
import 'ui/button_test.dart' as button_test;
import 'ui/textfield_test.dart' as textfield_test;
import 'utils/datetime_converter_test.dart' as datetime_converter_test;
import 'utils/logger_test.dart' as logger_test;
import 'network/http_client_test.dart' as http_client_test;

void main() {
  group('EWA Kit Tests', () {
    // Run all foundation tests
    group('Foundations', () {
      color_foundation_test.main();
      border_radius_test.main();
    });

    // Run all UI component tests
    group('UI Components', () {
      button_test.main();
      textfield_test.main();
    });

    // Run all utility tests
    group('Utilities', () {
      datetime_converter_test.main();
      logger_test.main();
    });

    // Run all network tests
    group('Network', () {
      http_client_test.main();
    });
  });
}

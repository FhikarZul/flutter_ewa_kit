import 'package:flutter_test/flutter_test.dart';

// Import all test files
import 'foundations/color_foundation_test.dart' as color_foundation_test;
import 'foundations/border_radius_test.dart' as border_radius_test;
import 'ui/button_test.dart' as button_test;
import 'ui/textfield_test.dart' as textfield_test;
import 'ui/image_test.dart' as image_test;
import 'utils/datetime_converter_test.dart' as datetime_converter_test;
import 'utils/logger_test.dart' as logger_test;
import 'utils/permission_test.dart' as permission_test;
import 'utils/connectivity_test.dart' as connectivity_test;
import 'network/http_client_test.dart' as http_client_test;
import 'network/response_exception_test.dart' as response_exception_test;

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
      image_test.main();
    });

    // Run all utility tests
    group('Utilities', () {
      datetime_converter_test.main();
      logger_test.main();
      permission_test.main();
      connectivity_test.main();
    });

    // Run all network tests
    group('Network', () {
      http_client_test.main();
      response_exception_test.main();
    });
  });
}

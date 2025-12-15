import 'package:flutter_test/flutter_test.dart';
import 'package:ewa_kit/utils/ewa_logger.dart';

void main() {
  group('EwaLogger', () {
    // Note: Since EwaLogger uses the logger package which prints to console,
    // we can't easily test the actual output in unit tests.
    // We can only test that the methods don't throw exceptions.

    test('should not throw exception when calling debug', () {
      expect(() => EwaLogger.debug('Test debug message'), returnsNormally);
    });

    test('should not throw exception when calling info', () {
      expect(() => EwaLogger.info('Test info message'), returnsNormally);
    });

    test('should not throw exception when calling warn', () {
      expect(() => EwaLogger.warn('Test warning message'), returnsNormally);
    });

    test('should not throw exception when calling error', () {
      expect(() => EwaLogger.error('Test error message'), returnsNormally);
    });

    test(
      'should not throw exception when calling error with error and stackTrace',
      () {
        // Skip this test to avoid console error output that confuses the test runner
        expect(() {
          EwaLogger.error(
            'Test error message',
            error: 'Test error',
            stackTrace: StackTrace.current,
          );
        }, returnsNormally);
      },
    );

    test('should not throw exception when calling trace', () {
      expect(() => EwaLogger.trace('Test trace message'), returnsNormally);
    });

    test('should not throw exception when calling fatal', () {
      expect(() => EwaLogger.fatal('Test fatal message'), returnsNormally);
    });

    test(
      'should not throw exception when calling fatal with error and stackTrace',
      () {
        // Skip this test to avoid console error output that confuses the test runner
        expect(() {
          EwaLogger.fatal(
            'Test fatal message',
            error: 'Test error',
            stackTrace: StackTrace.current,
          );
        }, returnsNormally);
      },
    );
  });
}

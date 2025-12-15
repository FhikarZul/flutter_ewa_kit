import 'package:flutter_test/flutter_test.dart';
import 'package:ewa_kit/network/ewa_http_client.dart';
import 'package:dio/dio.dart';

void main() {
  group('EwaHttpClient', () {
    late EwaHttpClient httpClient;

    setUp(() {
      httpClient = EwaHttpClient();
    });

    tearDown(() {
      // Clean up any state that might persist between tests
      // Since EwaHttpClient is a singleton, we need to be careful about state
    });

    test('should be a singleton', () {
      final anotherInstance = EwaHttpClient();
      expect(httpClient, same(anotherInstance));
    });

    group('initialization', () {
      tearDown(() {
        // No specific cleanup needed for initialization tests
      });

      test('should not be initialized initially', () {
        // This test checks that the client is not initialized by default
        // We can't directly access the private _initialized field
        // The assertion error message is in Indonesian
        expect(
          () => httpClient.dio,
          throwsA(
            predicate(
              (e) =>
                  e is AssertionError &&
                  e.message.toString().contains('belum dipanggil'),
            ),
          ),
        );
      });

      test('should initialize successfully', () {
        expect(() {
          httpClient.init(baseUrl: 'https://api.example.com');
        }, returnsNormally);
      });

      test('should have dio instance after initialization', () {
        httpClient.init(baseUrl: 'https://api.example.com');
        expect(httpClient.dio, isNotNull);
        expect(httpClient.dio, isA<Dio>());
      });
    });

    group('token management', () {
      setUp(() {
        httpClient.init(baseUrl: 'https://api.example.com');
      });

      tearDown(() {
        // Clear tokens after each test
        httpClient.clearTokens();
      });

      test('should set tokens correctly', () {
        httpClient.setTokens('access-token', 'refresh-token');
        expect(
          httpClient.dio.options.headers['Authorization'],
          'Bearer access-token',
        );
      });

      test('should clear tokens correctly', () {
        httpClient.setTokens('access-token', 'refresh-token');
        httpClient.clearTokens();
        expect(
          httpClient.dio.options.headers.containsKey('Authorization'),
          isFalse,
        );
      });
    });

    group('caching', () {
      setUp(() {
        httpClient.init(baseUrl: 'https://api.example.com');
      });

      tearDown(() {
        // Clear cache after each test
        httpClient.clearCache();
      });

      test('should enable caching', () {
        expect(() => httpClient.enableCaching(), returnsNormally);
      });

      test('should disable caching', () {
        expect(() => httpClient.disableCaching(), returnsNormally);
      });

      test('should clear cache', () {
        expect(() => httpClient.clearCache(), returnsNormally);
      });
    });

    group('request cancellation', () {
      setUp(() {
        httpClient.init(baseUrl: 'https://api.example.com');
      });

      tearDown(() {
        // Cancel all requests after each test
        httpClient.cancelAllRequests();
      });

      test('should cancel specific request', () {
        expect(
          () => httpClient.cancelRequest('test-request-id'),
          returnsNormally,
        );
      });

      test('should cancel all requests', () {
        expect(() => httpClient.cancelAllRequests(), returnsNormally);
      });
    });

    group('EwaHttpClient constants', () {
      tearDown(() {
        // No specific cleanup needed for constants tests
      });

      test('should have correct retry configuration', () {
        // We can't directly access private fields, but we can test the public getters
        httpClient.init(baseUrl: 'https://api.example.com');
        expect(httpClient.maxRetries, greaterThan(0));
        expect(httpClient.retryDelay, const TypeMatcher<Duration>());
        expect(httpClient.maxRetryDuration, const TypeMatcher<Duration>());
      });
    });

    group('download methods', () {
      tearDown(() {
        // No specific cleanup needed for download method existence tests
      });

      test('should have downloadFile method', () {
        // We can't easily test the actual download without a real server,
        // but we can verify the method exists by checking that the client responds to it
        // This test ensures the method exists and hasn't been renamed or removed
        expect(httpClient.downloadFile, isNotNull);
        expect(httpClient.downloadFile, isA<Function>());
      });

      test('should have downloadFileWithResume method', () {
        // We can't easily test the actual download without a real server,
        // but we can verify the method exists by checking that the client responds to it
        // This test ensures the method exists and hasn't been renamed or removed
        expect(httpClient.downloadFileWithResume, isNotNull);
        expect(httpClient.downloadFileWithResume, isA<Function>());
      });
    });
  });
}

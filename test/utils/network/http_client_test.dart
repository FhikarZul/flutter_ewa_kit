import 'package:flutter_test/flutter_test.dart';
import 'package:ewa_kit/utils/network/ewa_http_client.dart';
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
        expect(
          () => httpClient.dio,
          throwsA(
            predicate(
              (e) =>
                  e is AssertionError &&
                  e.message.toString().contains('must be called'),
            ),
          ),
        );
      });

      test('should initialize successfully', () async {
        await expectLater(
          httpClient.init(baseUrl: 'https://api.example.com'),
          completes,
        );
      });

      test('should have dio instance after initialization', () async {
        await httpClient.init(baseUrl: 'https://api.example.com');
        expect(httpClient.dio, isNotNull);
        expect(httpClient.dio, isA<Dio>());
      });
    });

    group('token management', () {
      setUp(() async {
        await httpClient.init(baseUrl: 'https://api.example.com');
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
      setUp(() async {
        await httpClient.init(baseUrl: 'https://api.example.com');
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
      setUp(() async {
        await httpClient.init(baseUrl: 'https://api.example.com');
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

      test('should have correct default retry configuration', () async {
        await httpClient.init(baseUrl: 'https://api.example.com');
        expect(httpClient.maxRetries, 3);
        expect(httpClient.retryDelay, const Duration(seconds: 1));
        expect(httpClient.maxRetryDuration, const Duration(minutes: 2));
      });

      test('should accept custom retry configuration', () async {
        await httpClient.init(
          baseUrl: 'https://api.example.com',
          maxRetries: 5,
          retryDelay: const Duration(seconds: 2),
          maxRetryDuration: const Duration(minutes: 5),
        );
        expect(httpClient.maxRetries, 5);
        expect(httpClient.retryDelay, const Duration(seconds: 2));
        expect(httpClient.maxRetryDuration, const Duration(minutes: 5));
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

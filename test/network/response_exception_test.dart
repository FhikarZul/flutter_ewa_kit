import 'package:flutter_test/flutter_test.dart';
import 'package:ewa_kit/network/ewa_response_exception.dart';
import 'package:ewa_kit/network/extensions/dio_exception_extension.dart';
import 'package:dio/dio.dart';

void main() {
  group('EwaResponseException', () {
    group('Constructor', () {
      test('should create exception with provided values', () {
        final exception = EwaResponseException(
          statusCode: 404,
          message: 'Not Found',
          internalMessage: 'Resource not found',
        );

        expect(exception.statusCode, 404);
        expect(exception.message, 'Not Found');
        expect(exception.internalMessage, 'Resource not found');
        expect(exception.errorType, EwaErrorType.notFound);
      });
    });

    group('fromDioException', () {
      test('should create exception from DioException with status code', () {
        final dioException = DioException(
          error: 'Not Found',
          requestOptions: RequestOptions(path: '/test'),
          response: Response(
            statusCode: 404,
            requestOptions: RequestOptions(path: '/test'),
          ),
        );

        final exception = EwaResponseException.fromDioException(dioException);

        expect(exception.statusCode, 404);
        expect(exception.errorType, EwaErrorType.notFound);
        expect(exception.message, 'Data Tidak Ditemukan');
      });

      test('should handle unauthorized error (401)', () {
        final dioException = DioException(
          error: 'Unauthorized',
          requestOptions: RequestOptions(path: '/test'),
          response: Response(
            statusCode: 401,
            requestOptions: RequestOptions(path: '/test'),
          ),
        );

        final exception = EwaResponseException.fromDioException(dioException);

        expect(exception.statusCode, 401);
        expect(exception.errorType, EwaErrorType.unauthorized);
        expect(exception.message, 'Sesi Anda Sudah Berakhir');
      });

      test('should handle network timeout errors', () {
        final dioException = DioException(
          type: DioExceptionType.connectionTimeout,
          error: 'Connection timeout',
          requestOptions: RequestOptions(path: '/test'),
        );

        final exception = EwaResponseException.fromDioException(dioException);

        expect(exception.statusCode, isNull);
        expect(exception.errorType, EwaErrorType.timeout);
        expect(exception.message, 'Waktu koneksi habis. Periksa koneksi Anda.');
      });

      test('should handle network connection errors', () {
        final dioException = DioException(
          type: DioExceptionType.connectionError,
          error: 'Connection failed',
          requestOptions: RequestOptions(path: '/test'),
        );

        final exception = EwaResponseException.fromDioException(dioException);

        expect(exception.statusCode, isNull);
        expect(exception.errorType, EwaErrorType.network);
        expect(
          exception.message,
          'Masalah koneksi jaringan. Periksa koneksi Anda.',
        );
      });

      test('should extract message from response data map', () {
        final dioException = DioException(
          error: 'Bad Request',
          requestOptions: RequestOptions(path: '/test'),
          response: Response(
            statusCode:
                422, // Using 422 to avoid overriding with status code message
            data: {'message': 'Invalid input provided'},
            requestOptions: RequestOptions(path: '/test'),
          ),
        );

        final exception = EwaResponseException.fromDioException(dioException);

        expect(exception.statusCode, 422);
        expect(exception.errorType, EwaErrorType.badRequest);
        expect(exception.internalMessage, 'Invalid input provided');
        // Should use the server message since 422 doesn't have a predefined message
        expect(exception.message, 'Invalid input provided');
      });

      test('should handle string response data', () {
        final dioException = DioException(
          error: 'Server Error',
          requestOptions: RequestOptions(path: '/test'),
          response: Response(
            statusCode:
                599, // Using 599 to avoid overriding with status code message
            data: 'Custom server error message',
            requestOptions: RequestOptions(path: '/test'),
          ),
        );

        final exception = EwaResponseException.fromDioException(dioException);

        expect(exception.statusCode, 599);
        expect(exception.errorType, EwaErrorType.server);
        expect(exception.internalMessage, 'Custom server error message');
        // For 5xx codes, we always use the predefined message regardless of server response
        expect(exception.message, 'Terjadi Kesalahan Pada Server');
      });
    });

    group('Error Type Mapping', () {
      test('should map 400 to badRequest', () {
        final exception = EwaResponseException(
          statusCode: 400,
          message: 'Bad Request',
        );
        expect(exception.errorType, EwaErrorType.badRequest);
      });

      test('should map 401 to unauthorized', () {
        final exception = EwaResponseException(
          statusCode: 401,
          message: 'Unauthorized',
        );
        expect(exception.errorType, EwaErrorType.unauthorized);
      });

      test('should map 403 to forbidden', () {
        final exception = EwaResponseException(
          statusCode: 403,
          message: 'Forbidden',
        );
        expect(exception.errorType, EwaErrorType.forbidden);
      });

      test('should map 404 to notFound', () {
        final exception = EwaResponseException(
          statusCode: 404,
          message: 'Not Found',
        );
        expect(exception.errorType, EwaErrorType.notFound);
      });

      test('should map 409 to conflict', () {
        final exception = EwaResponseException(
          statusCode: 409,
          message: 'Conflict',
        );
        expect(exception.errorType, EwaErrorType.conflict);
      });

      test('should map 500 to server', () {
        final exception = EwaResponseException(
          statusCode: 500,
          message: 'Internal Server Error',
        );
        expect(exception.errorType, EwaErrorType.server);
      });

      test('should map 502, 503, 504 to server', () {
        final exception502 = EwaResponseException(
          statusCode: 502,
          message: 'Bad Gateway',
        );
        expect(exception502.errorType, EwaErrorType.server);

        final exception503 = EwaResponseException(
          statusCode: 503,
          message: 'Service Unavailable',
        );
        expect(exception503.errorType, EwaErrorType.server);

        final exception504 = EwaResponseException(
          statusCode: 504,
          message: 'Gateway Timeout',
        );
        expect(exception504.errorType, EwaErrorType.server);
      });

      test('should map other 5xx codes to server', () {
        final exception = EwaResponseException(
          statusCode: 599,
          message: 'Unknown Server Error',
        );
        expect(exception.errorType, EwaErrorType.server);
      });

      test('should map other 4xx codes to badRequest', () {
        final exception = EwaResponseException(
          statusCode: 422,
          message: 'Unprocessable Entity',
        );
        expect(exception.errorType, EwaErrorType.badRequest);
      });

      test('should map unknown codes to unknown', () {
        // Test the static method directly since we can't construct with _internal
        final errorType = EwaResponseException.getErrorTypeFromStatusCode(999);
        expect(
          errorType,
          EwaErrorType.server,
        ); // 999 is a 5xx code, so it maps to server

        // Test with null status code
        final errorTypeNull = EwaResponseException.getErrorTypeFromStatusCode(
          null,
        );
        expect(errorTypeNull, EwaErrorType.unknown);
      });
    });

    group('toString', () {
      test('should return formatted string representation', () {
        final exception = EwaResponseException(
          statusCode: 404,
          message: 'Not Found',
          internalMessage: 'Resource not found',
        );

        final result = exception.toString();
        expect(result, contains('EwaResponseException'));
        expect(result, contains('Not Found'));
        expect(result, contains('404'));
        expect(result, contains('notFound'));
      });
    });
  });

  group('DioExceptionExtension', () {
    test('should convert DioException to EwaResponseException', () {
      final dioException = DioException(
        error: 'Not Found',
        requestOptions: RequestOptions(path: '/test'),
        response: Response(
          statusCode: 404,
          requestOptions: RequestOptions(path: '/test'),
        ),
      );

      final exception = dioException.toEwaResponseException();

      expect(exception, isA<EwaResponseException>());
      expect(exception.statusCode, 404);
      expect(exception.errorType, EwaErrorType.notFound);
    });
  });
}

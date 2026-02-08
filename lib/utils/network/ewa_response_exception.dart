import 'package:ewa_kit/utils/ewa_logger.dart';
import 'package:dio/dio.dart';

/// Enum representing different types of API errors
enum EwaErrorType {
  unauthorized,
  badRequest,
  internal,
  server,
  conflict,
  forbidden,
  notFound,
  network,
  timeout,
  unknown,
}

/// Custom exception class for handling API responses with structured error information
class EwaResponseException implements Exception {
  /// User-friendly error message
  final String message;

  /// Internal error message for debugging
  final String internalMessage;

  /// Type of error for categorization
  final EwaErrorType errorType;

  /// HTTP status code if available
  final int? statusCode;

  /// Raw response data if available
  final dynamic responseData;

  EwaResponseException({
    required this.statusCode,
    required this.message,
    this.internalMessage = '',
    this.responseData,
  }) : errorType = getErrorTypeFromStatusCode(statusCode);

  /// Factory constructor for creating exceptions from DioException
  factory EwaResponseException.fromDioException(DioException dioException) {
    final statusCode = dioException.response?.statusCode;
    final data = dioException.response?.data;

    String message = 'Terjadi kesalahan tidak terduga';
    String internalMessage = dioException.message ?? 'Unknown error';
    EwaErrorType errorType = EwaErrorType.unknown;

    // Handle network and timeout errors
    if (dioException.type == DioExceptionType.connectionTimeout ||
        dioException.type == DioExceptionType.receiveTimeout ||
        dioException.type == DioExceptionType.sendTimeout) {
      message = 'Waktu koneksi habis. Periksa koneksi Anda.';
      errorType = EwaErrorType.timeout;
    } else if (dioException.type == DioExceptionType.connectionError ||
        dioException.type == DioExceptionType.badCertificate) {
      message = 'Masalah koneksi jaringan. Periksa koneksi Anda.';
      errorType = EwaErrorType.network;
    } else if (dioException.type == DioExceptionType.cancel) {
      message = 'Permintaan dibatalkan';
      errorType = EwaErrorType.unknown;
    } else if (statusCode != null) {
      // Handle HTTP status code errors
      errorType = getErrorTypeFromStatusCode(statusCode);

      // Set user-friendly messages based on status code
      switch (statusCode) {
        case 401:
          message = 'Sesi Anda Sudah Berakhir';
          break;
        case 400:
          message = 'Kesalahan Pada Permintaan';
          break;
        case 403:
          message = 'Akses Ditolak';
          break;
        case 404:
          message = 'Data Tidak Ditemukan';
          break;
        case 409:
          message = 'Konflik Terjadi';
          break;
        case 500:
          message = 'Terjadi Kesalahan Pada Server';
          break;
        default:
          if (statusCode >= 500) {
            message = 'Terjadi Kesalahan Pada Server';
          } else if (statusCode >= 400) {
            message = 'Kesalahan Pada Permintaan';
          }
      }
    }

    // Override with server-provided messages if available
    if (data is Map<String, dynamic>) {
      // Try common error message keys
      internalMessage =
          data['message'] ?? data['error'] ?? data['detail'] ?? data.toString();

      // If we have a specific structure, try to extract user-friendly message
      if (data['message'] is String && data['message'].length < 100) {
        // Only override if we don't have a specific status code message
        if (statusCode == null ||
            (statusCode != 401 &&
                statusCode != 400 &&
                statusCode != 403 &&
                statusCode != 404 &&
                statusCode != 409 &&
                statusCode != 500 &&
                statusCode < 500)) {
          message = data['message'];
        }
      }
    } else if (data is String && data.isNotEmpty) {
      internalMessage = data;
      // If it's a short string, use it as the user message too
      // Only override if we don't have a specific status code message
      if (data.length < 100 &&
          (statusCode == null ||
              (statusCode != 401 &&
                  statusCode != 400 &&
                  statusCode != 403 &&
                  statusCode != 404 &&
                  statusCode != 409 &&
                  statusCode != 500 &&
                  statusCode < 500))) {
        message = data;
      }
    }

    return EwaResponseException._internal(
      statusCode: statusCode,
      message: message,
      internalMessage: internalMessage,
      responseData: data,
      errorType: errorType,
    );
  }

  /// Private constructor to allow setting errorType directly
  EwaResponseException._internal({
    required this.statusCode,
    required this.message,
    required this.internalMessage,
    required this.errorType,
    this.responseData,
  });

  /// Maps HTTP status codes to error types
  static EwaErrorType getErrorTypeFromStatusCode(int? statusCode) {
    switch (statusCode) {
      case 400:
        return EwaErrorType.badRequest;
      case 401:
        return EwaErrorType.unauthorized;
      case 403:
        return EwaErrorType.forbidden;
      case 404:
        return EwaErrorType.notFound;
      case 409:
        return EwaErrorType.conflict;
      case 500:
        return EwaErrorType.server;
      case 502:
      case 503:
      case 504:
        return EwaErrorType.server;
      default:
        if (statusCode != null && statusCode >= 500) {
          return EwaErrorType.server;
        } else if (statusCode != null && statusCode >= 400) {
          return EwaErrorType.badRequest;
        }
        return EwaErrorType.unknown;
    }
  }

  /// Logs the error for debugging purposes
  void logError() {
    EwaLogger.error(
      'API Exception - Type: ${errorType.name}, StatusCode: $statusCode, '
      'Message: $internalMessage',
    );
  }

  @override
  String toString() {
    return 'EwaResponseException: $message (Status: $statusCode, Type: ${errorType.name})';
  }
}

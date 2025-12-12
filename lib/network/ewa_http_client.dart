import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:ewa_kit/utils/ewa_logger.dart';
import 'package:flutter/foundation.dart';

/// Custom HTTP client using Dio with advanced features
class EwaHttpClient {
  static final EwaHttpClient _instance = EwaHttpClient._internal();
  factory EwaHttpClient() => _instance;
  EwaHttpClient._internal();

  late Dio _dio;
  String? _accessToken;
  String? _refreshToken;
  final int _maxRetries = 3;
  final Duration _retryDelay = const Duration(seconds: 1);

  /// Callback for handling token refresh
  Future<bool> Function()? refreshTokenCallback;

  /// Callback for handling logout
  VoidCallback? onLogout;

  /// Initialize the HTTP client
  void init({
    String baseUrl = '',
    Map<String, dynamic>? defaultHeaders,
    Duration connectTimeout = const Duration(seconds: 30),
    Duration receiveTimeout = const Duration(seconds: 30),
  }) {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: connectTimeout,
        receiveTimeout: receiveTimeout,
        headers: defaultHeaders ?? {},
      ),
    );

    // Add interceptors
    _dio.interceptors.add(LoggingInterceptor());
    _dio.interceptors.add(TokenInterceptor(this));
    _dio.interceptors.add(RetryInterceptor(this));
  }

  /// Set authentication tokens
  void setTokens(String accessToken, String refreshToken) {
    _accessToken = accessToken;
    _refreshToken = refreshToken;
    _updateAuthHeader();
  }

  /// Clear authentication tokens
  void clearTokens() {
    _accessToken = null;
    _refreshToken = null;
    _updateAuthHeader();
  }

  /// Update authorization header
  void _updateAuthHeader() {
    if (_accessToken != null) {
      _dio.options.headers['Authorization'] = 'Bearer $_accessToken';
    } else {
      _dio.options.headers.remove('Authorization');
    }
  }

  /// GET request
  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    Options? options,
  }) async {
    return _dio.get<T>(
      path,
      queryParameters: queryParameters,
      options: _mergeOptions(options, headers),
    );
  }

  /// POST request
  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    Options? options,
  }) async {
    return _dio.post<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: _mergeOptions(options, headers),
    );
  }

  /// PUT request
  Future<Response<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    Options? options,
  }) async {
    return _dio.put<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: _mergeOptions(options, headers),
    );
  }

  /// DELETE request
  Future<Response<T>> delete<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    Options? options,
  }) async {
    return _dio.delete<T>(
      path,
      queryParameters: queryParameters,
      options: _mergeOptions(options, headers),
    );
  }

  /// Merge custom headers with options
  Options _mergeOptions(Options? options, Map<String, dynamic>? headers) {
    if (headers == null) return options ?? Options();

    final mergedHeaders = <String, dynamic>{};
    if (options?.headers != null) {
      mergedHeaders.addAll(options!.headers!);
    }
    mergedHeaders.addAll(headers);

    return (options ?? Options()).copyWith(headers: mergedHeaders);
  }

  /// Refresh tokens
  Future<bool> refreshTokens() async {
    if (refreshTokenCallback != null) {
      return refreshTokenCallback!();
    }
    return false;
  }

  /// Download a file from the given URL
  ///
  /// [url] - The URL to download the file from
  /// [savePath] - The local path where the file should be saved
  /// [onProgress] - Optional callback to track download progress
  /// [headers] - Optional headers to include in the request
  /// [options] - Optional Dio options
  ///
  /// Returns the downloaded file path on success
  Future<String> downloadFile(
    String url,
    String savePath, {
    ProgressCallback? onProgress,
    Map<String, dynamic>? headers,
    Options? options,
  }) async {
    EwaLogger.info('Starting file download from: $url');
    EwaLogger.debug('Saving to: $savePath');

    try {
      // Merge headers with options if provided
      Options? mergedOptions = options;
      if (headers != null) {
        final mergedHeaders = <String, dynamic>{};
        if (options?.headers != null) {
          mergedHeaders.addAll(options!.headers!);
        }
        mergedHeaders.addAll(headers);
        mergedOptions = (options ?? Options()).copyWith(headers: mergedHeaders);
      }

      // Perform the download
      final response = await _dio.download(
        url,
        savePath,
        onReceiveProgress: onProgress,
        options: mergedOptions,
        deleteOnError: true,
      );

      if (response.statusCode == 200) {
        EwaLogger.info('File downloaded successfully to: $savePath');
        return savePath;
      } else {
        throw DioException(
          error: 'Download failed with status: ${response.statusCode}',
          requestOptions: response.requestOptions,
          response: response,
        );
      }
    } catch (e) {
      EwaLogger.error('File download failed: $e');
      rethrow;
    }
  }

  /// Download a file with resume capability
  ///
  /// [url] - The URL to download the file from
  /// [savePath] - The local path where the file should be saved
  /// [onProgress] - Optional callback to track download progress
  /// [headers] - Optional headers to include in the request
  /// [options] - Optional Dio options
  ///
  /// Returns the downloaded file path on success
  Future<String> downloadFileWithResume(
    String url,
    String savePath, {
    ProgressCallback? onProgress,
    Map<String, dynamic>? headers,
    Options? options,
  }) async {
    EwaLogger.info('Starting resumable file download from: $url');
    EwaLogger.debug('Saving to: $savePath');

    try {
      // Check if partial file exists
      final file = File(savePath);
      int startByte = 0;

      if (await file.exists()) {
        startByte = await file.length();
        EwaLogger.debug('Resuming download from byte: $startByte');
      }

      // If file is already completely downloaded, return early
      // First check if we can get the remote file size
      try {
        final headResponse = await _dio.head(url);
        final contentLength = headResponse.headers.value('content-length');
        if (contentLength != null) {
          final remoteFileSize = int.parse(contentLength);
          if (startByte >= remoteFileSize) {
            EwaLogger.info('File already completely downloaded: $savePath');
            return savePath;
          }
        }
      } catch (e) {
        EwaLogger.warn('Could not get remote file size: $e');
      }

      // Add Range header for resume capability (only if we have partial data)
      Map<String, dynamic>? resumeHeaders = headers;
      if (startByte > 0) {
        resumeHeaders = <String, dynamic>{};
        if (headers != null) {
          resumeHeaders.addAll(headers);
        }
        resumeHeaders['Range'] = 'bytes=$startByte-';
        EwaLogger.debug('Using range header: bytes=$startByte-');
      }

      // Merge headers with options
      Options? mergedOptions = options;
      if (resumeHeaders != null && resumeHeaders.isNotEmpty) {
        final mergedHeaders = <String, dynamic>{};
        if (options?.headers != null) {
          mergedHeaders.addAll(options!.headers!);
        }
        mergedHeaders.addAll(resumeHeaders);
        mergedOptions = (options ?? Options()).copyWith(headers: mergedHeaders);
      }

      // Perform the download
      final response = await _dio.download(
        url,
        savePath,
        onReceiveProgress: (received, total) {
          // Adjust progress to account for already downloaded bytes
          if (onProgress != null) {
            onProgress(startByte + received, startByte + total);
          }
        },
        options: mergedOptions,
        deleteOnError: false, // Don't delete on error for resume capability
      );

      if (response.statusCode == 200 || response.statusCode == 206) {
        EwaLogger.info('File downloaded successfully to: $savePath');
        return savePath;
      } else {
        throw DioException(
          error: 'Download failed with status: ${response.statusCode}',
          requestOptions: response.requestOptions,
          response: response,
        );
      }
    } on DioException catch (e) {
      // Handle 416 Range Not Satisfiable - file might be already downloaded
      if (e.response?.statusCode == 416) {
        EwaLogger.warn(
          'Range not satisfiable (416), file may be already downloaded',
        );
        final file = File(savePath);
        if (await file.exists()) {
          EwaLogger.info(
            'File already exists and is likely complete: $savePath',
          );
          return savePath;
        }
      }
      EwaLogger.error('Resumable file download failed: $e');
      rethrow;
    } catch (e) {
      EwaLogger.error('Resumable file download failed: $e');
      rethrow;
    }
  }

  /// Getters
  Dio get dio => _dio;
  String? get accessToken => _accessToken;
  String? get refreshToken => _refreshToken;
}

/// Interceptor for logging requests and responses
class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    EwaLogger.info('=== HTTP REQUEST ===');
    EwaLogger.info('${options.method} ${options.uri}');

    if (options.headers.isNotEmpty) {
      EwaLogger.debug('Headers: ${options.headers}');
    }

    if (options.data != null) {
      EwaLogger.debug('Payload: ${options.data}');
    }

    if (options.queryParameters.isNotEmpty) {
      EwaLogger.debug('Query Params: ${options.queryParameters}');
    }

    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    EwaLogger.info('=== HTTP RESPONSE ===');
    EwaLogger.info('${response.statusCode} ${response.statusMessage}');
    EwaLogger.debug('Response: ${response.data}');

    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    EwaLogger.error('=== HTTP ERROR ===');
    EwaLogger.error('Error: ${err.message}');
    EwaLogger.error('Status: ${err.response?.statusCode}');
    EwaLogger.error('Data: ${err.response?.data}');

    super.onError(err, handler);
  }
}

/// Interceptor for handling authentication tokens
class TokenInterceptor extends Interceptor {
  final EwaHttpClient _client;

  TokenInterceptor(this._client);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Add timestamp to request for cache busting
    options.queryParameters['_t'] = DateTime.now().millisecondsSinceEpoch;
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // Handle 401 Unauthorized errors
    if (err.response?.statusCode == 401) {
      EwaLogger.warn('Token expired, attempting to refresh...');

      final refreshed = await _client.refreshTokens();
      if (refreshed) {
        // Retry the original request with new token
        try {
          final opts = err.requestOptions;
          final response = await _client.dio.request(
            opts.path,
            data: opts.data,
            queryParameters: opts.queryParameters,
            options: Options(method: opts.method, headers: opts.headers),
          );
          return handler.resolve(response);
        } catch (e) {
          EwaLogger.error('Failed to retry request after token refresh: $e');
        }
      } else {
        EwaLogger.error('Token refresh failed, logging out...');
        _client.onLogout?.call();
      }
    }

    super.onError(err, handler);
  }
}

/// Interceptor for handling retry logic
class RetryInterceptor extends Interceptor {
  final EwaHttpClient _client;

  RetryInterceptor(this._client);

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    // Check if we should retry the request
    if (_shouldRetry(err)) {
      final requestOptions = err.requestOptions;

      // Get retry count from extra data
      final retryCount = requestOptions.extra['_retry_count'] as int? ?? 0;

      if (retryCount < _client._maxRetries) {
        EwaLogger.warn(
          'Retrying request (${retryCount + 1}/${_client._maxRetries})...',
        );

        // Wait before retrying
        await Future.delayed(_client._retryDelay * (retryCount + 1));

        // Update retry count and retry the request
        requestOptions.extra['_retry_count'] = retryCount + 1;
        try {
          final response = await _client.dio.request(
            requestOptions.path,
            data: requestOptions.data,
            queryParameters: requestOptions.queryParameters,
            options: Options(
              method: requestOptions.method,
              headers: requestOptions.headers,
              responseType: requestOptions.responseType,
              contentType: requestOptions.contentType,
              validateStatus: requestOptions.validateStatus,
              receiveTimeout: requestOptions.receiveTimeout,
              sendTimeout: requestOptions.sendTimeout,
            ),
          );
          return handler.resolve(response);
        } catch (e) {
          // Continue with error handling
        }
      } else {
        EwaLogger.error('Max retries exceeded for request');
      }
    }

    super.onError(err, handler);
  }

  /// Determine if a request should be retried
  bool _shouldRetry(DioException err) {
    // Retry on network errors
    if (err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.sendTimeout ||
        err.type == DioExceptionType.receiveTimeout ||
        err.type == DioExceptionType.badCertificate ||
        err.type == DioExceptionType.connectionError) {
      return true;
    }

    // Retry on server errors (5xx)
    if (err.response?.statusCode != null &&
        err.response!.statusCode! >= 500 &&
        err.response!.statusCode! < 600) {
      return true;
    }

    return false;
  }
}

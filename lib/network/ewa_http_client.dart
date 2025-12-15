import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:ewa_kit/network/ewa_cache_manager.dart';
import 'package:ewa_kit/utils/ewa_logger.dart';
import 'package:flutter/foundation.dart';

import 'interceptor/logging_interceptor.dart';
import 'interceptor/retry_interceptor.dart';
import 'interceptor/token_interceptor.dart';

class EwaHttpClient {
  static final EwaHttpClient _instance = EwaHttpClient._internal();
  factory EwaHttpClient() => _instance;
  EwaHttpClient._internal();

  late Dio _dio;
  bool _initialized = false;

  final int _maxRetries = 10; // Increased for "infinite" retry requirement
  final Duration _retryDelay = const Duration(seconds: 1);
  final Duration _maxRetryDuration = const Duration(
    minutes: 5,
  ); // Extended for "infinite" retry

  bool _isCacheEnabled = false;
  final Map<String, CancelToken> _cancelTokens = {};

  Future<bool> Function()? refreshTokenCallback;
  VoidCallback? onLogout;

  // Getter methods to expose private fields to interceptors
  int get maxRetries => _maxRetries;
  Duration get retryDelay => _retryDelay;
  Duration get maxRetryDuration => _maxRetryDuration;

  void init({
    String baseUrl = '',
    Map<String, dynamic>? defaultHeaders,
    Duration connectTimeout = const Duration(seconds: 30),
    Duration receiveTimeout = const Duration(seconds: 30),
    bool enableCaching = false,
  }) async {
    _isCacheEnabled = enableCaching;

    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: connectTimeout,
        receiveTimeout: receiveTimeout,
        headers: defaultHeaders ?? {},
      ),
    );

    _dio.interceptors.addAll([
      LoggingInterceptor(),
      TokenInterceptor(this),
      RetryInterceptor(this),
    ]);

    if (_isCacheEnabled) {
      await EwaCacheManager().init();
      _dio.interceptors.add(
        DioCacheInterceptor(options: EwaCacheManager().cacheOptions),
      );
    }

    _initialized = true;
  }

  Dio get dio {
    assert(_initialized, 'EwaHttpClient.init() belum dipanggil');
    return _dio;
  }

  void setTokens(String accessToken, String refreshToken) {
    dio.options.headers['Authorization'] = 'Bearer $accessToken';
  }

  void clearTokens() {
    dio.options.headers.remove('Authorization');
  }

  String _generateRequestId() =>
      DateTime.now().millisecondsSinceEpoch.toString();

  void cancelRequest(String requestId) {
    _cancelTokens.remove(requestId)?.cancel();
  }

  void cancelAllRequests() {
    for (final token in _cancelTokens.values) {
      token.cancel();
    }
    _cancelTokens.clear();
  }

  Options _mergeOptions(Options? options, Map<String, dynamic>? headers) {
    if (headers == null) return options ?? Options();
    return (options ?? Options()).copyWith(
      headers: {...?options?.headers, ...headers},
    );
  }

  /// Make a GET request
  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    assert(_initialized, 'HTTP client must be initialized before use');

    Options? finalOptions = options;
    if (_isCacheEnabled) {
      finalOptions = EwaCacheManager().buildCacheOptions();
    }

    return await _dio.get<T>(
      path,
      queryParameters: queryParameters,
      options: finalOptions,
      cancelToken: cancelToken,
      onReceiveProgress: onReceiveProgress,
    );
  }

  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    Options? options,
    String? requestId,
  }) async {
    final token = CancelToken();
    final id = requestId ?? _generateRequestId();
    _cancelTokens[id] = token;

    try {
      return await dio.post<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: _mergeOptions(options, headers),
        cancelToken: token,
      );
    } finally {
      _cancelTokens.remove(id);
    }
  }

  Future<bool> refreshTokens() async {
    return refreshTokenCallback?.call() ?? false;
  }

  bool get isCachingEnabled => _isCacheEnabled;

  /// Enable caching for this HTTP client
  void enableCaching() {
    if (!_isCacheEnabled) {
      _isCacheEnabled = true;
      EwaCacheManager().init();
      _dio.interceptors.add(
        DioCacheInterceptor(options: EwaCacheManager().cacheOptions),
      );
    }
  }

  /// Disable caching for this HTTP client
  void disableCaching() {
    if (_isCacheEnabled) {
      _isCacheEnabled = false;
      _dio.interceptors.removeWhere(
        (interceptor) => interceptor is DioCacheInterceptor,
      );
    }
  }

  /// Clear all cached data
  Future<void> clearCache() async {
    if (_isCacheEnabled) {
      await EwaCacheManager().clearCache();
    }
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
    String? requestId,
  }) async {
    EwaLogger.info('Starting file download from: $url');
    EwaLogger.debug('Saving to: $savePath');

    final token = CancelToken();
    final id = requestId ?? _generateRequestId();
    _cancelTokens[id] = token;

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
        cancelToken: token,
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
    } finally {
      _cancelTokens.remove(id);
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
    String? requestId,
  }) async {
    EwaLogger.info('Starting resumable file download from: $url');
    EwaLogger.debug('Saving to: $savePath');

    final token = CancelToken();
    final id = requestId ?? _generateRequestId();
    _cancelTokens[id] = token;

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
        cancelToken: token,
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
      // Handle 416 Range Not Satisfiable - restart download from beginning
      if (e.response?.statusCode == 416) {
        EwaLogger.warn(
          'Range not satisfiable (416). Restarting download from beginning.',
        );

        // Delete the incomplete file
        final file = File(savePath);
        if (await file.exists()) {
          await file.delete();
          EwaLogger.debug('Deleted incomplete file: $savePath');
        }

        // Restart download from beginning (without range header)
        EwaLogger.info('Restarting download from beginning: $url');
        return await _dio
            .download(
              url,
              savePath,
              onReceiveProgress: onProgress,
              options: options,
              cancelToken: token,
              deleteOnError: true,
            )
            .then((response) {
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
            });
      }

      EwaLogger.error('Resumable file download failed: $e');
      rethrow;
    } catch (e) {
      EwaLogger.error('Resumable file download failed: $e');
      rethrow;
    } finally {
      _cancelTokens.remove(id);
    }
  }
}

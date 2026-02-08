import 'package:dio/dio.dart';
import 'package:ewa_kit/utils/ewa_logger.dart';

import 'package:ewa_kit/utils/network/ewa_http_client.dart';

class RetryInterceptor extends Interceptor {
  final EwaHttpClient _client;
  RetryInterceptor(this._client);

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (!_shouldRetry(err)) {
      return handler.next(err);
    }

    final opts = err.requestOptions;

    // Initialize or get retry tracking data
    int retryCount = 0;
    int startTime = DateTime.now().millisecondsSinceEpoch;

    if (opts.extra.containsKey('_retry_count')) {
      retryCount = opts.extra['_retry_count'] as int;
    }

    if (opts.extra.containsKey('_retry_start_time')) {
      startTime = opts.extra['_retry_start_time'] as int;
    } else {
      opts.extra['_retry_start_time'] = startTime;
    }

    // Check if we've exceeded max duration or max retries
    final timeElapsed = DateTime.now().millisecondsSinceEpoch - startTime;
    if (timeElapsed < _client.maxRetryDuration.inMilliseconds &&
        retryCount < _client.maxRetries) {
      EwaLogger.warn(
        'Retrying request (${retryCount + 1}/${_client.maxRetries})...',
      );

      // Exponential backoff with max delay of 30 seconds
      final delayMultiplier = retryCount < 5 ? retryCount + 1 : 5;
      final delay = _client.retryDelay * delayMultiplier;
      final maxDelay = const Duration(seconds: 30);
      final actualDelay = delay > maxDelay ? maxDelay : delay;

      // Wait before retrying
      await Future.delayed(actualDelay);

      // Update retry count for the next attempt
      opts.extra['_retry_count'] = retryCount + 1;

      try {
        final response = await _client.dio.request(
          opts.path,
          data: opts.data,
          queryParameters: opts.queryParameters,
          options: Options(
            method: opts.method,
            headers: opts.headers,
            responseType: opts.responseType,
            contentType: opts.contentType,
            validateStatus: opts.validateStatus,
            receiveTimeout: opts.receiveTimeout,
            sendTimeout: opts.sendTimeout,
            extra: opts.extra,
          ),
          cancelToken: opts.cancelToken,
        );

        return handler.resolve(response);
      } catch (e) {
        // Log the failed attempt
        EwaLogger.warn('Retry attempt ${retryCount + 1} failed: $e');

        // Create a new DioException to pass to onError for recursive retry
        if (e is DioException) {
          return onError(e, handler);
        } else {
          final newErr = DioException(
            error: e,
            requestOptions: opts,
            type: DioExceptionType.unknown,
          );
          return onError(newErr, handler);
        }
      }
    } else {
      if (timeElapsed >= _client.maxRetryDuration.inMilliseconds) {
        EwaLogger.error('Max retry duration exceeded for request');
      } else {
        EwaLogger.error('Max retries exceeded for request');
      }
      return handler.next(err);
    }
  }

  bool _shouldRetry(DioException err) {
    // Don't retry if it's a cancellation
    if (err.type == DioExceptionType.cancel) return false;

    // Retry on network errors (covers the "transient failures" requirement)
    if (err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.connectionError ||
        err.type == DioExceptionType.receiveTimeout ||
        err.type == DioExceptionType.sendTimeout ||
        err.type == DioExceptionType.badCertificate) {
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

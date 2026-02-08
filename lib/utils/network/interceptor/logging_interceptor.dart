import 'package:dio/dio.dart';
import 'package:ewa_kit/utils/ewa_logger.dart';

class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    EwaLogger.info('=== HTTP REQUEST ===');
    EwaLogger.info('${options.method} ${options.uri}');

    // Log the full URL being hit
    EwaLogger.info('Full URL: ${options.baseUrl}${options.path}');

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
    EwaLogger.info('URL: ${response.requestOptions.uri}');

    if (response.data is! List<int>) {
      EwaLogger.debug('Response: ${response.data}');
    }

    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    EwaLogger.error('=== HTTP ERROR ===');
    EwaLogger.error('URL: ${err.requestOptions.uri}');
    EwaLogger.error('Error: ${err.message}');
    EwaLogger.error('Status: ${err.response?.statusCode}');
    EwaLogger.error('Data: ${err.response?.data}');

    super.onError(err, handler);
  }
}

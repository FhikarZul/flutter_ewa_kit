import 'package:dio/dio.dart';
import '../ewa_http_client.dart';

class TokenInterceptor extends Interceptor {
  final EwaHttpClient _client;
  TokenInterceptor(this._client);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (!_client.isCachingEnabled) {
      options.queryParameters['_t'] = DateTime.now().millisecondsSinceEpoch;
    }
    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode == 401) {
      final refreshed = await _client.refreshTokens();
      if (!refreshed) {
        _client.onLogout?.call();
        return handler.next(err);
      }

      final opts = err.requestOptions;
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
    }

    handler.next(err);
  }
}

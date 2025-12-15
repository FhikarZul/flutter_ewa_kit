import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';

/// Cache manager for EWA Kit HTTP client
class EwaCacheManager {
  static final EwaCacheManager _instance = EwaCacheManager._internal();
  factory EwaCacheManager() => _instance;
  EwaCacheManager._internal();

  late CacheOptions _cacheOptions;

  /// Initialize the cache manager
  Future<void> init({
    Duration maxStale = const Duration(days: 7),
    bool hitCacheOnNetworkFailure = true,
    CachePolicy policy = CachePolicy.request,
  }) async {
    // Create memory cache store
    final store = MemCacheStore();

    // Configure cache options
    _cacheOptions = CacheOptions(
      // A default store is required for interceptor
      store: store,

      // Cache policy
      policy: policy,

      // Returns a cached response on network errors (e.g. offline usage)
      hitCacheOnNetworkFailure: hitCacheOnNetworkFailure,

      // Overrides any HTTP directive to delete entry past this duration
      maxStale: maxStale,

      // Key builder to retrieve requests
      keyBuilder: CacheOptions.defaultCacheKeyBuilder,

      // Allows to cache POST requests
      allowPostMethod: false,
    );
  }

  /// Get default cache options
  CacheOptions get cacheOptions => _cacheOptions;

  /// Clear all cached data
  Future<void> clearCache() async {
    if (_cacheOptions.store is MemCacheStore) {
      await (_cacheOptions.store as MemCacheStore).clean();
    }
  }

  /// Build cache options for a specific request
  Options buildCacheOptions({
    CachePolicy? policy,
    Duration? maxStale,
    bool? hitCacheOnNetworkFailure,
  }) {
    return _cacheOptions
        .copyWith(
          policy: policy ?? _cacheOptions.policy,
          maxStale: maxStale ?? _cacheOptions.maxStale,
          hitCacheOnNetworkFailure:
              hitCacheOnNetworkFailure ??
              _cacheOptions.hitCacheOnNetworkFailure,
        )
        .toOptions();
  }
}

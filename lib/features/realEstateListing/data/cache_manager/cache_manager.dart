abstract class CacheManager {
  bool isCacheValid(String key, String timestampKey, {Duration ttl});
  T? getCache<T>(String key, T Function(String) fromJson);
  void setCache(String key, dynamic data, String timestampKey,
      {bool serialize});
  String generateFilterCacheKey({
    required String prefix,
    String? cityId,
    String? offerType,
    String? subCategoryId,
  });
  void invalidateCache(String key, String timestampKey);
}

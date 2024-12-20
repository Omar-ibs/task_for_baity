import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_for_baity/features/realEstateListing/data/cache_manager/cache_manager.dart';

class CacheManagerImpl implements CacheManager {
  final SharedPreferences _prefs;

  CacheManagerImpl(this._prefs);

  /// Check if the cache exists and is valid
  @override
  bool isCacheValid(String key, String timestampKey,
      {Duration ttl = const Duration(minutes: 30)}) {
    if (!_prefs.containsKey(key) || !_prefs.containsKey(timestampKey)) {
      return false;
    }
    final timestampStr = _prefs.getString(timestampKey);
    final cachedAt = DateTime.tryParse(timestampStr ?? '');
    if (cachedAt == null) return false;
    return DateTime.now().isBefore(cachedAt.add(ttl));
  }

  @override
  T? getCache<T>(String key, T Function(String) fromJson) {
    final cachedData = _prefs.getString(key);
    if (cachedData == null) return null;
    try {
      return fromJson(cachedData);
    } catch (e) {
      return null;
    }
  }

  @override
  void setCache(String key, dynamic data, String timestampKey,
      {bool serialize = true}) {
    if (serialize) {
      _prefs.setString(key, jsonEncode(data));
    } else {
      _prefs.setString(key, data as String);
    }
    _prefs.setString(timestampKey, DateTime.now().toIso8601String());
  }

  @override
  String generateFilterCacheKey({
    required String prefix,
    String? cityId,
    String? offerType,
    String? subCategoryId,
  }) {
    final city = cityId ?? 'any';
    final offer = offerType ?? 'any';
    final subCategory = subCategoryId ?? 'any';
    return '$prefix${city}_${offer}_${subCategory}';
  }

  /// Invalidate a specific cache entry
  @override
  void invalidateCache(String key, String timestampKey) {
    _prefs.remove(key);
    _prefs.remove(timestampKey);
  }
}

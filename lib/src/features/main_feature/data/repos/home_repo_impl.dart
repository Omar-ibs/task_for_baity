import 'dart:convert';
import 'package:baity_task/src/core/error/failure.dart';
import 'package:baity_task/src/core/utils/api_service.dart';
import 'package:baity_task/src/features/main_feature/data/models/real_estate.dart';
import 'package:baity_task/src/features/main_feature/data/repos/home_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeRepoImpl implements HomeRepo {
  final ApiService apiService;
  const HomeRepoImpl(this.apiService);

  final String _fetchItemsCacheKey = 'cached_real_estate_items';
  final String _filterItemsCacheKeyPrefix = 'cached_real_estate_filtered_';
  final String _fetchItemsTimestampKey = 'cached_real_estate_items_timestamp';
  final String _filterItemsTimestampKeyPrefix =
      'cached_real_estate_filtered_timestamp_';
  final Duration ttl = const Duration(minutes: 30);

  @override
  Future<Either<Failure, List<RealEstate>>> fetchItems() async {
    try {
      //check if there any cached data
      final prefs = await SharedPreferences.getInstance();

      if (prefs.containsKey(_fetchItemsCacheKey) &&
          !_isCacheExpired(prefs.getString(_fetchItemsTimestampKey))) {
        // Retrieve and decode cached data
        final cachedData = prefs.getString(_fetchItemsCacheKey);
        final List decodedData = json.decode(cachedData!);
        final cachedItems =
            decodedData.map((e) => RealEstate.fromJson(e)).toList();
        print('Cached Data');
        return Right(cachedItems);
      }

      //if there is no cached data we will fetch from the API
      List<RealEstate> itemsList = [];
      var response = (await apiService.get('https://v3.ibaity.com/api/',
          'client/Realestate', null))["payload"] as List;
      itemsList = response.map((v) => RealEstate.fromJson(v)).toList();
      prefs.setString(_fetchItemsCacheKey,
          json.encode(itemsList.map((e) => e.toJson()).toList()));
      prefs.setString(
          _fetchItemsTimestampKey, DateTime.now().toIso8601String());
      print('Data are caching');
      return Right(itemsList);
    } on DioException catch (errorMessage) {
      return Left(ServerFailure.fromDioError(errorMessage));
    }
  }

  @override
  bool _isCacheExpired(String? timestampStr) {
    if (timestampStr == null) return true;
    final cachedAt = DateTime.parse(timestampStr);
    return DateTime.now().isAfter(cachedAt.add(ttl));
  }

  String _generateFilterCacheKey(RealEstate options) {
    final cityId = options.city?.id ?? 'any';
    final offerType = options.offerType ?? 'any';
    final subCategoryId = options.subCategory?.id ?? 'any';
    return '$_filterItemsCacheKeyPrefix${cityId}_${offerType}_$subCategoryId';
  }

  String _generateFilterTimestampKey(RealEstate options) {
    final cityId = options.city?.id ?? 'any';
    final offerType = options.offerType ?? 'any';
    final subCategoryId = options.subCategory?.id ?? 'any';
    return '$_filterItemsTimestampKeyPrefix${cityId}_${offerType}_$subCategoryId';
  }

  @override
  Future<Either<Failure, List<RealEstate>>> filterItems({
    String? category,
    String? subCategory,
    String? city,
    String? offerType,
  }) async {
    try {
      // Generate cache key based on filters
      final cacheKey =
          '$_fetchItemsCacheKey-${category ?? ''}-${subCategory ?? ''}-${city ?? ''}-${offerType ?? ''}';
      final prefs = await SharedPreferences.getInstance();

      // Check for cached data with filtering
      if (prefs.containsKey(cacheKey) &&
          !_isCacheExpired(prefs.getString(_fetchItemsTimestampKey))) {
        final cachedData = prefs.getString(cacheKey);
        final List decodedData = json.decode(cachedData!);
        final cachedItems =
            decodedData.map((e) => RealEstate.fromJson(e)).toList();
        print('Retrieved Cached Data');
        return Right(cachedItems);
      }

      // Prepare query parameters for API request
      Map<String, dynamic> queryParams = {
        'offerType': offerType,
        'category': category,
        'subCategory': subCategory,
        'city': city,
      }..removeWhere((key, value) => value == null);

      var response = (await apiService.get(
        'https://v3.ibaity.com/api/',
        'client/RealEstate?',
        queryParams,
      ))["payload"] as List;

      List<RealEstate> itemsList =
          response.map((v) => RealEstate.fromJson(v)).toList();

      // Cache the data with specific cache key
      prefs.setString(
          cacheKey, json.encode(itemsList.map((e) => e.toJson()).toList()));
      prefs.setString(
          _fetchItemsTimestampKey, DateTime.now().toIso8601String());

      print('Fetched and Cached New Data');
      return Right(itemsList);
    } on DioException catch (errorMessage) {
      return Left(ServerFailure.fromDioError(errorMessage));
    }
  }
}

import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:task_for_baity/core/api_service.dart';
import 'package:task_for_baity/core/error_handler.dart';
import 'package:task_for_baity/features/realEstateListing/data/cache_manager/cache_manager.dart';
import 'package:task_for_baity/features/realEstateListing/data/cache_manager/constants.dart';
import 'package:task_for_baity/features/realEstateListing/data/models/cities/cities.dart';
import 'package:task_for_baity/features/realEstateListing/data/models/realestate/real_estate.dart';
import 'package:task_for_baity/features/realEstateListing/data/repo/filter/filter_repo.dart';

import '../../models/category/category.dart';

class FilterRepoImpl implements FilterRepo {
  final ApiService _apiClient;
  final CacheManager _cacheManager;

  FilterRepoImpl(this._apiClient, this._cacheManager);

  @override
  Future<Either<Failure, List<Category>>> getCategories() async {
    const cacheKey = Constants.fetchItemsCacheKey;
    const timestampKey = Constants.fetchItemsTimestampKey;

    // Check cache validity
    if (_cacheManager.isCacheValid(cacheKey, timestampKey)) {
      final cachedData = _cacheManager.getCache<List<Category>>(
        cacheKey,
        (jsonString) => (jsonDecode(jsonString) as List)
            .map((e) => Category.fromJson(e))
            .toList(),
      );
      if (cachedData != null) return Right(cachedData);
    }

    try {
      List<Category> categories;
      final response = (await _apiClient.get(
          ApiEndpoint.category.url, null))["payload"] as List;
      categories = response.map((e) => Category.fromJson(e)).toList();

      _cacheManager.setCache(
        cacheKey,
        categories.map((e) => e.toJson()).toList(),
        timestampKey,
      );

      return Right(categories);
    } on DioException catch (errorMessage) {
      return Left(ServerFailure.fromDioError(errorMessage));
    }
  }

  @override
  Future<Either<Failure, List<Cities>>> getCities() async {
    const cacheKey = Constants.fetchItemsCacheKey;
    const timestampKey = Constants.fetchItemsTimestampKey;

    if (_cacheManager.isCacheValid(cacheKey, timestampKey)) {
      final cachedData = _cacheManager.getCache<List<Cities>>(
        cacheKey,
        (jsonString) => (jsonDecode(jsonString) as List)
            .map((e) => Cities.fromJson(e))
            .toList(),
      );
      if (cachedData != null) return Right(cachedData);
    }

    try {
      List<Cities> cities;
      final response =
          (await _apiClient.get(ApiEndpoint.city.url, null))["payload"] as List;
      cities = response.map((e) => Cities.fromJson(e)).toList();

      _cacheManager.setCache(
        cacheKey,
        cities.map((e) => e.toJson()).toList(),
        timestampKey,
      );

      return Right(cities);
    } on DioException catch (errorMessage) {
      return Left(ServerFailure.fromDioError(errorMessage));
    }
  }

  @override
  Future<Either<Failure, List<RealEstate>>> getFilteredResults({
    required String cityId,
    required String offerType,
    required String subCategoryId,
    required int pageSize,
    required int pageNumber,
  }) async {
    final cacheKey = _cacheManager.generateFilterCacheKey(
      prefix: Constants.filterItemsCacheKeyPrefix,
      cityId: cityId,
      offerType: offerType,
      subCategoryId: subCategoryId,
    );
    final timestampKey = '${cacheKey}_timestamp';

    if (_cacheManager.isCacheValid(cacheKey, timestampKey)) {
      final cachedData = _cacheManager.getCache<List<RealEstate>>(
        cacheKey,
        (jsonString) => (jsonDecode(jsonString) as List)
            .map((e) => RealEstate.fromJson(e))
            .toList(),
      );
      if (cachedData != null) return Right(cachedData);
    }

    try {
      List<RealEstate> realEstates;
      final response = (await _apiClient.get(
        ApiEndpoint.realEstate.url,
        {
          'cityId': cityId,
          'offerType': offerType,
          'subCategoryId': subCategoryId,
          'pageSize': pageSize,
          'pageNumber': pageNumber,
        },
      ))["payload"] as List;
      realEstates = response.map((e) => RealEstate.fromJson(e)).toList();

      _cacheManager.setCache(
        cacheKey,
        realEstates.map((e) => e.toJson()).toList(),
        timestampKey,
      );

      return Right(realEstates);
    } on DioException catch (errorMessage) {
      return Left(ServerFailure.fromDioError(errorMessage));
    }
  }
}

import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:task_for_baity/core/api_service.dart';
import 'package:task_for_baity/core/error_handler.dart';
import 'package:task_for_baity/features/realEstateListing/data/cache_manager/cache_manager.dart';
import 'package:task_for_baity/features/realEstateListing/data/cache_manager/constants.dart';
import 'package:task_for_baity/features/realEstateListing/data/models/category/category.dart';
import 'package:task_for_baity/features/realEstateListing/data/repo/category/category_repo.dart';

class CategoryRepoImpl implements CategoryRepo {
  final ApiService apiService;
  final CacheManager cacheManager;
  CategoryRepoImpl(this.apiService, this.cacheManager);

  @override
  Future<Either<Failure, List<Category>>> fetchCategories() async {
    try {
      if (cacheManager.isCacheValid(Constants.fetchCategoriesCacheKey,
          Constants.fetchCategoriesTimestampKey)) {
        final cachedData = cacheManager.getCache(
            Constants.fetchCategoriesCacheKey,
            (jsonString) => jsonDecode(jsonString));
        final List decodedData = json.decode(cachedData!);
        final cachedItems =
            decodedData.map((e) => Category.fromJson(e)).toList();
        return Right(cachedItems);
      }

      List<Category> categories;
      final response = (await apiService.get(
          ApiEndpoint.category.url, null))["payload"] as List;
      categories =
          response.map((category) => Category.fromJson(category)).toList();

      cacheManager.setCache(
        Constants.fetchCategoriesCacheKey,
        json.encode(categories.map((e) => e.toJson()).toList()),
        Constants.fetchItemsTimestampKey,
      );

      return Right(categories);
    } on DioException catch (errorMessage) {
      return Left(ServerFailure.fromDioError(errorMessage));
    }
  }
}

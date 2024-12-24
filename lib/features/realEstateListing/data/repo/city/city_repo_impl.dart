import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:task_for_baity/core/api_service.dart';
import 'package:task_for_baity/core/error_handler.dart';
import 'package:task_for_baity/features/realEstateListing/data/cache_manager/cache_manager.dart';
import 'package:task_for_baity/features/realEstateListing/data/cache_manager/constants.dart';
import 'package:task_for_baity/features/realEstateListing/data/models/cities/cities.dart';
import 'package:task_for_baity/features/realEstateListing/data/repo/city/city_repo.dart';

class CityRepoImpl implements CityRepo {
  final ApiService apiService;
  final CacheManager cacheManager;
  CityRepoImpl(this.apiService, this.cacheManager);

  @override
  Future<Either<Failure, List<Cities>>> fetchCities() async {
    try {
      if (cacheManager.isCacheValid(
          Constants.fetchCitiesCacheKey, Constants.fetchCitiesTimestampKey)) {
        final cachedData = cacheManager.getCache(Constants.fetchItemsCacheKey,
            (jsonString) => jsonDecode(jsonString));
        final List decodedData = json.decode(cachedData!);
        final cachedItems = decodedData.map((e) => Cities.fromJson(e)).toList();
        return Right(cachedItems);
      }

      List<Cities> cities;
      final response =
          (await apiService.get(ApiEndpoint.city.url, null))["payload"] as List;
      cities = response.map((city) => Cities.fromJson(city)).toList();

      cacheManager.setCache(
        Constants.fetchCitiesCacheKey,
        json.encode(cities.map((e) => e.toJson()).toList()),
        Constants.fetchItemsTimestampKey,
      );

      return Right(cities);
    } on DioException catch (errorMessage) {
      return Left(ServerFailure.fromDioError(errorMessage));
    }
  }
}

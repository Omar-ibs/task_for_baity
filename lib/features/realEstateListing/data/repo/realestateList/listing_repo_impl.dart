import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:task_for_baity/core/api_service.dart';
import 'package:task_for_baity/core/error_handler.dart';
import 'package:task_for_baity/features/realEstateListing/data/cache_manager/cache_manager.dart';
import 'package:task_for_baity/features/realEstateListing/data/cache_manager/constants.dart';
import 'package:task_for_baity/features/realEstateListing/data/models/realestate/real_estate.dart';
import 'package:task_for_baity/features/realEstateListing/data/repo/realestateList/listing_repo.dart';

class ListingRepoImpl implements ListingRepo {
  final ApiService apiService;
  final CacheManager cacheManager;

  ListingRepoImpl(this.apiService, this.cacheManager);

  @override
  Future<Either<Failure, List<RealEstate>>> fetchItems() async {
    try {
      if (cacheManager.isCacheValid(
          Constants.fetchItemsCacheKey, Constants.fetchItemsTimestampKey)) {
        final cachedData = cacheManager.getCache(Constants.fetchItemsCacheKey,
            (jsonString) => jsonDecode(jsonString));
        final List decodedData = json.decode(cachedData!);
        final cachedItems =
            decodedData.map((e) => RealEstate.fromJson(e)).toList();
        return Right(cachedItems);
      }

      List<RealEstate> itemsList = [];
      var response = (await apiService.get(
          ApiEndpoint.realEstate.url, null))["payload"] as List;
      itemsList = response.map((v) => RealEstate.fromJson(v)).toList();

      cacheManager.setCache(
        Constants.fetchItemsCacheKey,
        json.encode(itemsList.map((e) => e.toJson()).toList()),
        Constants.fetchItemsTimestampKey,
      );
      return Right(itemsList);
    } on DioException catch (errorMessage) {
      return Left(ServerFailure.fromDioError(errorMessage));
    }
  }
}

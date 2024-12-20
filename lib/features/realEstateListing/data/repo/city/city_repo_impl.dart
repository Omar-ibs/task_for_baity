import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:task_for_baity/core/api_service.dart';
import 'package:task_for_baity/core/error_handler.dart';
import 'package:task_for_baity/features/realEstateListing/data/models/cities/cities.dart';
import 'package:task_for_baity/features/realEstateListing/data/repo/city/city_repo.dart';

class CityRepoImpl implements CityRepo {
  final ApiService apiService;

  CityRepoImpl(this.apiService);

  @override
  Future<Either<Failure, List<Cities>>> fetchCities() async {
    try {
      List<Cities> cities;
      final response =
          (await apiService.get(ApiEndpoint.city.url, null))["payload"] as List;
      cities = response.map((city) => Cities.fromJson(city)).toList();
      return Right(cities);
    } on DioException catch (errorMessage) {
      return Left(ServerFailure.fromDioError(errorMessage));
    }
  }
}

import 'package:dartz/dartz.dart';
import 'package:task_for_baity/core/error_handler.dart';
import 'package:task_for_baity/features/realEstateListing/data/models/cities/cities.dart';

abstract class CityRepo {
  Future<Either<Failure, List<Cities>>> fetchCities();
}

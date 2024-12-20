import 'package:dartz/dartz.dart';
import 'package:task_for_baity/core/error_handler.dart';
import 'package:task_for_baity/features/realEstateListing/data/models/category/category.dart';
import 'package:task_for_baity/features/realEstateListing/data/models/cities/cities.dart';
import 'package:task_for_baity/features/realEstateListing/data/models/realestate/real_estate.dart';

abstract class FilterRepo {
  Future<Either<Failure, List<Category>>> getCategories();
  Future<Either<Failure, List<Cities>>> getCities();
  Future<Either<Failure, List<RealEstate>>> getFilteredResults({
    required String cityId,
    required String offerType,
    required String subCategoryId,
    required int pageSize,
    required int pageNumber,
  });
}

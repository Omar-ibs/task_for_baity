import 'package:dartz/dartz.dart';
import 'package:task_for_baity/core/error_handler.dart';
import 'package:task_for_baity/features/realEstateListing/data/models/category/category.dart';

abstract class CategoryRepo {
  Future<Either<Failure, List<Category>>> fetchCategories();
}

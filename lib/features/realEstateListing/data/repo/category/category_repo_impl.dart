import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:task_for_baity/core/api_service.dart';
import 'package:task_for_baity/core/error_handler.dart';
import 'package:task_for_baity/features/realEstateListing/data/models/category/category.dart';
import 'package:task_for_baity/features/realEstateListing/data/repo/category/category_repo.dart';

class CategoryRepoImpl implements CategoryRepo {
  final ApiService apiService;

  CategoryRepoImpl(this.apiService);

  @override
  Future<Either<Failure, List<Category>>> fetchCategories() async {
    try {
      List<Category> categories;
      final response = (await apiService.get(
          ApiEndpoint.category.url, null))["payload"] as List;
      categories =
          response.map((category) => Category.fromJson(category)).toList();
      return Right(categories);
    } on DioException catch (errorMessage) {
      return Left(ServerFailure.fromDioError(errorMessage));
    }
  }
}

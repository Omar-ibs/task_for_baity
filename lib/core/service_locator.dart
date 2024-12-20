import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:task_for_baity/core/api_service.dart';
import 'package:task_for_baity/features/realEstateListing/data/cache_manager/cache_manager.dart';
import 'package:task_for_baity/features/realEstateListing/data/cache_manager/cache_manager_impl.dart';
import 'package:task_for_baity/features/realEstateListing/data/repo/category/category_repo.dart';
import 'package:task_for_baity/features/realEstateListing/data/repo/category/category_repo_impl.dart';
import 'package:task_for_baity/features/realEstateListing/data/repo/city/city_repo.dart';
import 'package:task_for_baity/features/realEstateListing/data/repo/city/city_repo_impl.dart';
import 'package:task_for_baity/features/realEstateListing/data/repo/filter/filter_repo.dart';
import 'package:task_for_baity/features/realEstateListing/data/repo/filter/filter_repo_impl.dart';
import 'package:task_for_baity/features/realEstateListing/data/repo/realestateList/listing_repo.dart';
import 'package:task_for_baity/features/realEstateListing/data/repo/realestateList/listing_repo_impl.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

class ServiceLocator {
  Future<void> setup() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    getIt.registerSingleton<SharedPreferences>(sharedPreferences);
    getIt.registerLazySingleton<Dio>(() => Dio());
    getIt.registerLazySingleton<ApiService>(() => ApiService(getIt<Dio>()));
    getIt.registerLazySingleton<CacheManager>(
        () => CacheManagerImpl(sharedPreferences));
    getIt.registerLazySingleton<CityRepo>(
        () => CityRepoImpl(getIt<ApiService>()));
    getIt.registerLazySingleton<CategoryRepo>(
        () => CategoryRepoImpl(getIt<ApiService>()));
    getIt.registerLazySingleton<FilterRepo>(
        () => FilterRepoImpl(getIt<ApiService>(), getIt<CacheManager>()));
    getIt.registerLazySingleton<ListingRepo>(
        () => ListingRepoImpl(getIt<ApiService>(), getIt<CacheManager>()));
  }
}

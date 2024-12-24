import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_for_baity/core/service_locator.dart';
import 'package:task_for_baity/features/realEstateListing/data/models/category/category.dart';
import 'package:task_for_baity/features/realEstateListing/data/models/cities/cities.dart';
import 'package:task_for_baity/features/realEstateListing/data/repo/category/category_repo.dart';
import 'package:task_for_baity/features/realEstateListing/data/repo/city/city_repo.dart';
import 'package:task_for_baity/features/realEstateListing/data/repo/filter/filter_repo.dart';
import 'package:task_for_baity/features/realEstateListing/data/repo/realestateList/listing_repo.dart';
import 'package:task_for_baity/features/realEstateListing/view/real_estate_listing.dart';
import 'package:task_for_baity/features/realEstateListing/view_model/fetchAndFilter/item_list_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupServiceLocator();
  runApp(const TaskForBaity());
}

Future<void> setupServiceLocator() async {
  await ServiceLocator().setup();
  final categoryRepo = getIt.get<CategoryRepo>();
  final cityRepo = getIt.get<CityRepo>();

  final citiesResult = await cityRepo.fetchCities();
  citiesResult.fold(
    (failure) => print('Failed to fetch cities: ${failure.errMessage}'),
    (cities) => getIt.registerSingleton<List<Cities>>(cities),
  );

  final categoriesResult = await categoryRepo.fetchCategories();
  categoriesResult.fold(
    (failure) => print('Failed to fetch categories: ${failure.errMessage}'),
    (categories) => getIt.registerSingleton<List<Category>>(categories),
  );
}

class TaskForBaity extends StatelessWidget {
  const TaskForBaity({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ItemListCubit(getIt.get<ListingRepo>(), getIt.get<FilterRepo>()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: const Color(0xfff5f5fa),
          textTheme: Theme.of(context).textTheme.apply(fontFamily: 'Tajawal'),
        ),
        home: const ListingFeature(),
      ),
    );
  }
}

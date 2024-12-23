import 'package:baity_task/src/core/utils/service_locator.dart';
import 'package:baity_task/src/features/main_feature/data/models/real_estate.dart';
import 'package:baity_task/src/features/main_feature/data/repos/home_repo.dart';
import 'package:baity_task/src/features/main_feature/presentation/view/widgets/filter_screen.dart';
import 'package:baity_task/src/features/main_feature/presentation/view/widgets/items_list.dart';
import 'package:baity_task/src/features/main_feature/presentation/view_model/cubit/item_list_cubit_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainFeature extends StatefulWidget {
  const MainFeature({super.key});

  @override
  State<MainFeature> createState() => _MainFeatureState();
}

class _MainFeatureState extends State<MainFeature> {
  List<RealEstate> realEstateList = [];
  bool isLoading = false;
  HomeRepo homeRepo = getIt.get<HomeRepo>();
  // Fetch items based on filter options

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xff042f46),
          centerTitle: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(
                Icons.menu,
                color: Color(0xfff5f5fa),
              ),
              IconButton(
                onPressed: () async {
                  final filters = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const FilterPage()),
                  );
                  if (filters != null) {
                    // Call the filterItems method on the cubit
                    context.read<ItemListCubitCubit>().filterItems(
                          offerType: filters['offerType'],
                          category: filters['category'],
                          subCategory: filters['subCategory'],
                          city: filters['city'],
                        );
                  }
                },
                icon: const Icon(
                  Icons.filter_list_outlined,
                  color: Color(0xfff5f5fa),
                ),
              ),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: BlocProvider(
            create: (context) =>
                ItemListCubitCubit(getIt.get<HomeRepo>())..fetchItems(),
            child: const ItemList(),
          ),
        ));
  }
}

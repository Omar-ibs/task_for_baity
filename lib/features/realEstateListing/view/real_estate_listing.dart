import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_for_baity/core/service_locator.dart';
import 'package:task_for_baity/features/realEstateListing/data/repo/category/category_repo.dart';
import 'package:task_for_baity/features/realEstateListing/data/repo/city/city_repo.dart';
import 'package:task_for_baity/features/realEstateListing/view/widgets/filterScreenWidgets/filter_screen.dart';
import 'package:task_for_baity/features/realEstateListing/view/widgets/realestateScreenWidgets/items_list.dart';
import 'package:task_for_baity/features/realEstateListing/view_model/categoryAndSubcategory/categories_i_ds_fetching_cubit.dart';
import 'package:task_for_baity/features/realEstateListing/view_model/city/cities_fetching_cubit.dart';
import 'package:task_for_baity/features/realEstateListing/view_model/fetchAndFilter/item_list_cubit.dart';

class ListingFeature extends StatefulWidget {
  const ListingFeature({super.key});

  @override
  State<ListingFeature> createState() => _ListingFeatureState();
}

class _ListingFeatureState extends State<ListingFeature> {
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    context.read<ItemListCubit>().fetchItems();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() async {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 50.0 &&
        context.read<ItemListCubit>().state is ItemListSuccess) {
      final currentState =
          context.read<ItemListCubit>().state as ItemListSuccess;

      if (currentState.hasMore) {
        await context.read<ItemListCubit>().loadMoreItems(
              offerType: context.read<ItemListCubit>().currentOfferType,
              pageSize: 20,
              subCategoryId: context.read<ItemListCubit>().currentSubCategoryId,
              cityId: context.read<ItemListCubit>().currentCityId,
            );
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

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
                  MaterialPageRoute(
                    builder: (context) => MultiBlocProvider(
                      providers: [
                        BlocProvider(
                          create: (context) => CategoriesIDsFetchingCubit(
                            getIt.get<CategoryRepo>(),
                          ),
                        ),
                        BlocProvider(
                          create: (context) =>
                              CitiesFetchingCubit(getIt.get<CityRepo>()),
                        ),
                      ],
                      child: FilterScreen(
                        initialOfferType:
                            context.read<ItemListCubit>().currentOfferType,
                        initialCityId:
                            context.read<ItemListCubit>().currentCityId,
                        initialCategoryId:
                            context.read<ItemListCubit>().currentCategoryId,
                        initialSubCategoryId:
                            context.read<ItemListCubit>().currentSubCategoryId,
                        initialCityName:
                            context.read<ItemListCubit>().currentCityName,
                      ),
                    ),
                  ),
                );
                if (filters != null && mounted) {
                  context.read<ItemListCubit>().filterItems(
                        offerType: filters['offerType'],
                        categoryId: filters['categoryId'] ?? '',
                        subCategoryId: filters['subCategoryId'] ?? '',
                        cityId: filters['cityId'] ?? '',
                        cityName: filters['cityName'] ?? '',
                        pageSize: filters['pageSize'] ?? 20,
                        pageNumber: filters['pageNumber'] ?? 1,
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
          child: ItemList(scrollController: _scrollController)),
    );
  }
}

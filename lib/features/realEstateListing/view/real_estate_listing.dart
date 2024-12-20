import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_for_baity/features/realEstateListing/view/widgets/filterScreenWidgets/filter_screen.dart';
import 'package:task_for_baity/features/realEstateListing/view/widgets/realestateScreenWidgets/items_list.dart';
import 'package:task_for_baity/features/realEstateListing/view_model/fetchAndFilter/item_list_cubit.dart';

class ListingFeature extends StatefulWidget {
  const ListingFeature({super.key});

  @override
  State<ListingFeature> createState() => _ListingFeatureState();
}

class _ListingFeatureState extends State<ListingFeature> {
  @override
  void initState() {
    super.initState();
    context.read<ItemListCubit>().fetchItems();
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
                    builder: (context) => const FilterScreen(),
                  ),
                );
                if (filters != null && mounted) {
                  context.read<ItemListCubit>().filterItems(
                        offerType: filters['offerType'],
                        subCategoryId: filters['subCategoryId'] ?? '',
                        cityId: filters['cityId'] ?? '',
                        pageSize: filters['pageSize'] ?? 10,
                        pageNumber: filters['pageNumber'] ?? 1,
                      );
                }
                print('Filters retrieved: $filters');
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
        child: BlocBuilder<ItemListCubit, ItemListState>(
          builder: (context, state) {
            if (state is ItemListSuccess) {
              return ItemList(itemsList: state.itemsList);
            } else if (state is ItemListFailure) {
              return Center(
                child: Text(
                  state.message,
                  style: const TextStyle(color: Colors.red),
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}

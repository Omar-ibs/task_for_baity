import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_for_baity/features/realEstateListing/view/widgets/realestateScreenWidgets/item.dart';
import 'package:task_for_baity/features/realEstateListing/view_model/fetchAndFilter/item_list_cubit.dart';

class ItemList extends StatelessWidget {
  const ItemList({super.key, required this.scrollController});
  final ScrollController scrollController;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ItemListCubit, ItemListState>(
      builder: (context, state) {
        if (state is ItemListSuccess) {
          return GridView.builder(
            controller: scrollController,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: MediaQuery.sizeOf(context).width > 800
                    ? 1.1 / 1.2
                    : 1 / 1.1,
                crossAxisSpacing: 10,
                mainAxisSpacing: 5,
                crossAxisCount: MediaQuery.sizeOf(context).width > 800 ? 2 : 1),
            physics: const BouncingScrollPhysics(),
            itemCount: state.itemsList.length + (state.hasMore ? 1 : 0),
            itemBuilder: (context, index) {
              if (index == state.itemsList.length) {
                return const Center(
                    child: SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.0,
                        )));
              }
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Item(
                  realEstate: state.itemsList[index],
                ),
              );
            },
          );
        } else if (state is ItemListFailure) {
          return Center(child: Text(state.message));
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

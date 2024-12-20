import 'package:flutter/material.dart';
import 'package:task_for_baity/features/realEstateListing/data/models/realestate/real_estate.dart';
import 'package:task_for_baity/features/realEstateListing/view/widgets/realestateScreenWidgets/item.dart';

class ItemList extends StatelessWidget {
  const ItemList({super.key, required this.itemsList});
  final List<RealEstate> itemsList;
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio:
              MediaQuery.sizeOf(context).width > 800 ? 1.1 / 1.2 : 1 / 1.1,
          crossAxisSpacing: 10,
          mainAxisSpacing: 5,
          crossAxisCount: MediaQuery.sizeOf(context).width > 800 ? 2 : 1),
      physics: const BouncingScrollPhysics(),
      itemCount: itemsList.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Item(
            realEstate: itemsList[index],
          ),
        );
      },
    );
  }
}

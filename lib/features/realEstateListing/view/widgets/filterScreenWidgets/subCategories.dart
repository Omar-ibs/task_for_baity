import 'package:flutter/material.dart';
import 'package:task_for_baity/core/styles.dart';

class Subcategories extends StatefulWidget {
  const Subcategories(
      {super.key, required this.category, required this.onSubCategorySelected});
  final String category;
  final Function(String) onSubCategorySelected;
  @override
  State<Subcategories> createState() => _SubcategoriesState();
}

class _SubcategoriesState extends State<Subcategories> {
  int? selectedIndex;
  Map<String, List<String>> subCategories = {
    'Residential': ['Land', 'Flat', 'Villa', 'Building'],
    'Building Complex': ['Flat', 'Villa'],
    'Commercial': [
      'Flat',
      'Building',
      'Land',
      'Warehouse',
      'shop Store',
      'Villa'
    ],
    'Industrial': ['Land', 'Factory', 'Workshop'],
    'Agricultural': ['Land', 'Farm', 'Grove'],
  };
  List<String> get subCategoryList => subCategories[widget.category] ?? [];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: subCategoryList.length,
        itemBuilder: (context, index) {
          return TextButton(
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
            onPressed: () {
              if (selectedIndex == index) {
                setState(() {
                  selectedIndex = null;
                });
              } else {
                setState(() {
                  selectedIndex = index;
                });
                widget.onSubCategorySelected(subCategoryList[index]);
              }
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey[400]!),
                color: selectedIndex == index
                    ? const Color(0xff042f46)
                    : Colors.white,
              ),
              child: Center(
                  child: Text(
                subCategoryList[index],
                style: Styles.regularStyle14(context).copyWith(
                  color:
                      selectedIndex == index ? Colors.white : Colors.grey[500],
                ),
              )),
            ),
          );
        });
  }
}

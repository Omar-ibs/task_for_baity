import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:task_for_baity/features/realEstateListing/view/widgets/filterScreenWidgets/category_item.dart';
import 'package:task_for_baity/features/realEstateListing/view/widgets/filterScreenWidgets/subCategories.dart';

class CategoryListView extends StatefulWidget {
  final Function(String, String) onFilterApplied;
  const CategoryListView({super.key, required this.onFilterApplied});

  @override
  State<CategoryListView> createState() => _CategoryListViewState();
}

class _CategoryListViewState extends State<CategoryListView> {
  int? selectedIconIndex;
  String? selectedCategoryId, selectedSubCategoryId;
  @override
  Widget build(BuildContext context) {
    List<IconData> icons = [
      FontAwesomeIcons.house,
      FontAwesomeIcons.building,
      FontAwesomeIcons.city,
      FontAwesomeIcons.warehouse,
      FontAwesomeIcons.tractor,
    ];

    List<String> categories = [
      'Residential',
      'Building Complex',
      'Commercial',
      'Industrial',
      'Agricultural',
    ];
    return Column(
      children: [
        SizedBox(
          height: 120,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: icons.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0.0),
                  child: TextButton(
                    onPressed: () {
                      if (selectedIconIndex == index) {
                        setState(() {
                          selectedIconIndex = null;
                          selectedCategoryId = null;
                        });
                      } else {
                        setState(() {
                          selectedIconIndex = index;
                          selectedCategoryId = categories[index];
                          widget.onFilterApplied(
                            categories[index],
                            selectedSubCategoryId ?? '',
                          );
                        });
                      }
                    },
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
                    ),
                    child: CategoryItem(
                        selectedIconIndex: selectedIconIndex,
                        currentIndex: index,
                        icons: icons,
                        categories: categories),
                  ),
                );
              }),
        ),
        const SizedBox(
          height: 10,
        ),
        selectedIconIndex != null
            ? SizedBox(
                height: 60,
                child: Subcategories(
                  category: categories[selectedIconIndex!],
                  onSubCategorySelected: (subCategory) {
                    selectedSubCategoryId = subCategory;
                    if (selectedCategoryId != null &&
                        selectedSubCategoryId != null) {
                      widget.onFilterApplied(
                          selectedCategoryId!, selectedSubCategoryId!);
                    }
                    setState(() {});
                  },
                ),
              )
            : const SizedBox(
                height: 10,
              ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:task_for_baity/features/realEstateListing/data/models/category/category.dart';
import 'package:task_for_baity/features/realEstateListing/view/widgets/filterScreenWidgets/category_item.dart';
import 'package:task_for_baity/features/realEstateListing/view/widgets/filterScreenWidgets/subCategories.dart';

class CategoryListView extends StatefulWidget {
  final Function(String?, String?) onFilterApplied;
  final List<Category> categories;
  final String? initialSelectedCategoryId;
  final String? initialSelectedSubCategoryId;

  const CategoryListView({
    super.key,
    required this.onFilterApplied,
    required this.categories,
    this.initialSelectedCategoryId,
    this.initialSelectedSubCategoryId,
  });

  @override
  State<CategoryListView> createState() => _CategoryListViewState();
}

class _CategoryListViewState extends State<CategoryListView> {
  int? selectedIconIndex;
  String? selectedCategoryId, selectedSubCategoryId;

  @override
  void initState() {
    super.initState();
    initializeSelection();
  }

  @override
  void didUpdateWidget(CategoryListView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialSelectedCategoryId !=
            oldWidget.initialSelectedCategoryId ||
        widget.initialSelectedSubCategoryId !=
            oldWidget.initialSelectedSubCategoryId) {
      initializeSelection();
    }
  }

  void initializeSelection() {
    selectedCategoryId = widget.initialSelectedCategoryId;
    selectedSubCategoryId = widget.initialSelectedSubCategoryId;
    selectedIconIndex = widget.categories
        .indexWhere((category) => category.id == selectedCategoryId);
    if (selectedIconIndex == -1) {
      selectedIconIndex = null;
    }
  }

  void onCategorySelected(int index) {
    setState(() {
      if (selectedIconIndex == index) {
        resetSelection();
      } else {
        selectedIconIndex = index;
        selectedCategoryId = widget.categories[index].id;
        selectedSubCategoryId = null; // Reset subcategory selection
        widget.onFilterApplied(selectedCategoryId, selectedSubCategoryId);
      }
    });
  }

  void resetSelection() {
    selectedIconIndex = null;
    selectedCategoryId = null;
    selectedSubCategoryId = null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: widget.categories.length,
            itemBuilder: (context, index) {
              return TextButton(
                onPressed: () => onCategorySelected(index),
                style: TextButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                ),
                child: CategoryItem(
                  selectedIconIndex: selectedIconIndex,
                  currentIndex: index,
                  category: widget.categories[index],
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 10),
        if (selectedIconIndex != null)
          SizedBox(
            height: 60,
            child: Subcategories(
              initialSelectedSubCategoryId: selectedSubCategoryId,
              category: widget.categories[selectedIconIndex!],
              onSubCategorySelected: (subCategoryId) {
                setState(() {
                  selectedSubCategoryId = subCategoryId;
                });
                widget.onFilterApplied(
                    selectedCategoryId, selectedSubCategoryId);
              },
            ),
          ),
      ],
    );
  }
}

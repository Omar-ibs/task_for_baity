import 'package:flutter/material.dart';
import 'package:task_for_baity/features/realEstateListing/data/models/category/category.dart';

class Subcategories extends StatefulWidget {
  final Category category;
  final String? initialSelectedSubCategoryId;
  final Function(String subCategoryId) onSubCategorySelected;

  const Subcategories({
    Key? key,
    required this.category,
    this.initialSelectedSubCategoryId,
    required this.onSubCategorySelected,
  }) : super(key: key);

  @override
  _SubcategoriesState createState() => _SubcategoriesState();
}

class _SubcategoriesState extends State<Subcategories> {
  int? selectedIndex;

  @override
  void initState() {
    super.initState();
    initializeSelection();
  }

  void initializeSelection() {
    selectedIndex = widget.category.subCategories?.indexWhere(
      (subCategory) => subCategory.id == widget.initialSelectedSubCategoryId,
    );
  }

  void onSubCategorySelected(int index) {
    setState(() {
      if (selectedIndex == index) {
        selectedIndex = null;
      } else {
        selectedIndex = index;
        widget.onSubCategorySelected(widget.category.subCategories![index].id!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: widget.category.subCategories?.length ?? 0,
      itemBuilder: (context, index) {
        return TextButton(
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onPressed: () => onSubCategorySelected(index),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            height: 40,
            decoration: BoxDecoration(
              color: selectedIndex == index ? const Color(0xff042f46) : null,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey[500]!, width: 1),
            ),
            child: Center(
              child: Text(
                widget.category.subCategories![index].names!.enUs!,
                style: TextStyle(
                    fontSize: 14,
                    color: selectedIndex == index
                        ? Colors.white
                        : Colors.grey[500]),
              ),
            ),
          ),
        );
      },
    );
  }
}

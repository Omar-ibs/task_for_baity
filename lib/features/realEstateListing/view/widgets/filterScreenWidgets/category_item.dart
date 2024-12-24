import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:task_for_baity/core/styles.dart';
import 'package:task_for_baity/features/realEstateListing/data/models/category/category.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    super.key,
    required this.selectedIconIndex,
    required this.category,
    required this.currentIndex,
  });

  final int? selectedIconIndex;
  final int currentIndex;
  final Category category;

  @override
  Widget build(BuildContext context) {
    List<IconData> icons = [
      FontAwesomeIcons.house,
      FontAwesomeIcons.building,
      FontAwesomeIcons.city,
      FontAwesomeIcons.warehouse,
      FontAwesomeIcons.tractor,
    ];

    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color:
            selectedIconIndex == currentIndex ? const Color(0xff042f46) : null,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[500]!, width: 1),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: currentIndex == 3 && currentIndex == 0
                ? const EdgeInsets.only(right: 8.0)
                : const EdgeInsets.all(0.0),
            child: Icon(
              icons[currentIndex],
              size: 40,
              color: selectedIconIndex == currentIndex
                  ? Colors.white
                  : Colors.black,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            category.names!.enUs!,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Styles.regularStyle16(context).copyWith(
                fontWeight: FontWeight.bold,
                color: selectedIconIndex == currentIndex
                    ? Colors.white
                    : Colors.grey[400]),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:task_for_baity/core/styles.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    super.key,
    required this.selectedIconIndex,
    required this.icons,
    required this.categories,
    required this.currentIndex,
  });

  final int? selectedIconIndex;
  final int currentIndex;
  final List<IconData> icons;
  final List<String> categories;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: currentIndex == 3
          ? const EdgeInsets.all(12.0)
          : const EdgeInsets.all(8.0),
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
            categories[currentIndex],
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

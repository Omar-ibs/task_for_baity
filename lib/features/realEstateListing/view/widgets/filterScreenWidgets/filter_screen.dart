import 'package:flutter/material.dart';
import 'package:task_for_baity/core/styles.dart';
import 'package:task_for_baity/features/realEstateListing/view/widgets/filterScreenWidgets/category_list_view.dart';
import 'package:task_for_baity/features/realEstateListing/view/widgets/filterScreenWidgets/offered_by_buttons.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  String offerType = 'SELL';
  String? selectedCityId = 'G76HDC';
  String? selectedCategoryId;
  String? selectedSubCategoryId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff042f46),
        title: const Text(
          'Filter',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Offer for Sale / Rent Toggle
              const Text(
                'Offer Type',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              OfferedByButtons(
                onOfferTypeSelected: (selectedOfferType) {
                  offerType = selectedOfferType;
                },
              ),
              const SizedBox(height: 16),

              const Text(
                'Category and Subcategory',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              CategoryListView(
                onFilterApplied: (category, subCategory) {
                  selectedCategoryId = category;
                  selectedSubCategoryId = subCategory;
                  setState(() {});
                },
              ),
              const SizedBox(height: 16),

              // City Selection
              const Text(
                'City',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              DropdownButton<String>(
                value: selectedCityId,
                onChanged: (newValue) {
                  setState(() {
                    selectedCityId = newValue;
                  });
                },
                items: <String>[
                  'Baghdad',
                  'Erbil',
                  'Anbar  ',
                  'Sulaymaniyah',
                  'Karbala',
                  'Maysan',
                  'Dhi Qar',
                  'Kirkuk',
                  'Al Muthanna',
                  'Halabcha',
                  'Wasit',
                  'Al-Diwania',
                  'Al-Najaf',
                  'Diyala',
                  'Salah Al-Deen',
                  'Duhok'
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 120,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Reset Filters
            Expanded(
              child: TextButton(
                style: TextButton.styleFrom(
                  elevation: 5,
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.grey[500]!),
                      borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: () {
                  setState(() {
                    offerType = 'SELL';
                    selectedCityId = null;
                    selectedCategoryId = null;
                    selectedSubCategoryId = null;
                  });
                },
                child: Text(
                  'Reset',
                  style: Styles.semiBoldStyle20(context)
                      .copyWith(color: const Color(0xff042f46)),
                ),
              ),
            ),
            const SizedBox(
              width: 12,
            ),
            // Apply Filters and Return to Previous Screen
            Expanded(
              flex: 2,
              child: TextButton(
                style: TextButton.styleFrom(
                    elevation: 5,
                    backgroundColor: const Color(0xff042f46),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8))),
                onPressed: () {
                  final filters = {
                    'offerType': offerType,
                    'categoryId': selectedCategoryId ?? '',
                    'subCategoryId': selectedSubCategoryId ?? '',
                    'cityId': selectedCityId ?? '',
                  };
                  print('Filters selected: $filters');
                  Navigator.pop(context, filters);
                },
                child: Text(
                  'Results',
                  style: Styles.semiBoldStyle20(context)
                      .copyWith(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

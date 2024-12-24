import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:task_for_baity/core/service_locator.dart';
import 'package:task_for_baity/core/styles.dart';
import 'package:task_for_baity/features/realEstateListing/data/models/category/category.dart';
import 'package:task_for_baity/features/realEstateListing/data/models/cities/cities.dart';
import 'package:task_for_baity/features/realEstateListing/view/widgets/filterScreenWidgets/category_list_view.dart';
import 'package:task_for_baity/features/realEstateListing/view/widgets/filterScreenWidgets/cities_choose.dart';
import 'package:task_for_baity/features/realEstateListing/view/widgets/filterScreenWidgets/offered_by_buttons.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen(
      {super.key,
      required this.initialOfferType,
      this.initialCityId,
      this.initialCategoryId,
      this.initialSubCategoryId,
      required this.initialCityName});
  final String initialOfferType;
  final String? initialCityId;
  final String? initialCategoryId;
  final String? initialSubCategoryId;
  final String initialCityName;

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  late String offerType;
  String? selectedCityId;
  String? selectedCityName;
  String? selectedCategoryId;
  String? selectedSubCategoryId;
  List<Category> categories = [];
  List<Cities> cities = [];

  @override
  void initState() {
    super.initState();
    offerType = widget.initialOfferType;
    selectedCityId = widget.initialCityId;
    selectedCityName = widget.initialCityName;
    selectedCategoryId = widget.initialCategoryId;
    selectedSubCategoryId = widget.initialSubCategoryId;
    categories = getIt.get<List<Category>>();
    cities = getIt.get<List<Cities>>();
  }

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
              const Text(
                'Offer Type',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              OfferedByButtons(
                isPressed: offerType == 'SELL',
                onOfferTypeSelected: (selectedOfferType) {
                  offerType = selectedOfferType;
                },
                isPressed1: offerType == 'RENT',
              ),
              const SizedBox(height: 16),

              const Text(
                'Category and Subcategory',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              CategoryListView(
                initialSelectedSubCategoryId: selectedSubCategoryId,
                initialSelectedCategoryId: selectedCategoryId,
                categories: categories,
                onFilterApplied: (categoryId, subCategoryId) {
                  selectedCategoryId = categoryId;
                  selectedSubCategoryId = subCategoryId;
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
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CitiesChoose(
                        onFilterApplied: (labelName, labelId) {
                          selectedCityName = labelName;
                          selectedCityId = labelId;
                          setState(() {});
                        },
                        cities: cities,
                      ),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[500]!),
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                  child: Row(
                    spacing: 12,
                    children: [
                      Icon(
                        FontAwesomeIcons.circleXmark,
                        color: Colors.grey[500],
                      ),
                      Text(
                        selectedCityName!,
                        style: Styles.semiBoldStyle16(context)
                            .copyWith(color: Colors.grey[500]),
                      ),
                    ],
                  ),
                ),
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
                    selectedCityName = 'Baghdad';
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
                    'categoryId': selectedCategoryId,
                    'subCategoryId': selectedSubCategoryId,
                    'cityId': selectedCityId,
                    'cityName': selectedCityName,
                  };
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

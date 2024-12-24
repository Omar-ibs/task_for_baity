import 'package:flutter/material.dart';
import 'package:task_for_baity/core/styles.dart';
import 'package:task_for_baity/features/realEstateListing/data/models/cities/cities.dart';
import 'package:task_for_baity/features/realEstateListing/view/widgets/filterScreenWidgets/selecting_field.dart';

class CitiesChoose extends StatefulWidget {
  final List<Cities> cities;
  final Function(String, String) onFilterApplied;
  const CitiesChoose(
      {super.key, required this.cities, required this.onFilterApplied});

  @override
  State<CitiesChoose> createState() => _CitiesChooseState();
}

class _CitiesChooseState extends State<CitiesChoose> {
  String label = 'Baghdad';
  String labelId = 'G76HDC';
  int? selectedIndex;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Cities",
            style: Styles.mediumStyle20(context).copyWith(color: Colors.white),
          ),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          backgroundColor: const Color(0xff042f46),
        ),
        body: ListView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: widget.cities.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      label = widget.cities[index].names!.enUs!;
                      labelId = widget.cities[index].id!;
                      selectedIndex = index;
                    });
                  },
                  child: SelectingField(
                    isSelected: selectedIndex == index,
                    text: widget.cities[index].names!.enUs!,
                  ),
                ),
              );
            }),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.all(12),
          child: TextButton(
            style: TextButton.styleFrom(
              backgroundColor: const Color(0xff042f46),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              'Done',
              style:
                  Styles.mediumStyle20(context).copyWith(color: Colors.white),
            ),
            onPressed: () {
              widget.onFilterApplied(label, labelId);
              Navigator.pop(context);
            },
          ),
        ));
  }
}

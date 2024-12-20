import 'package:flutter/material.dart';
import 'package:task_for_baity/core/styles.dart';
import 'package:task_for_baity/features/realEstateListing/view/widgets/filterScreenWidgets/selecting_field.dart';

class CitiesChoose extends StatefulWidget {
  const CitiesChoose({super.key});

  @override
  State<CitiesChoose> createState() => _CitiesChooseState();
}

class _CitiesChooseState extends State<CitiesChoose> {
  List<String> cities = [
    'Baghdad',
    'Erbil',
    'Basra',
    'Nineveh',
    'Kirkuk',
    'Najaf',
    'Karbala',
    'Babel',
    'Sulaimaniya',
    'Duhok',
    'Dyala',
    'Salah Alddin',
    'Al - Anbar',
    'Wasit',
    'Diwanyah',
    'Misan',
    'ThiQar',
    'Al - Muthanna',
    'Halabja',
  ];
  String label = 'Baghdad';
  int? _selectedIndex;
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
            itemCount: cities.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      label = cities[index];
                      _selectedIndex = index;
                    });
                  },
                  child: SelectingField(
                    isSelected: _selectedIndex == index,
                    text: cities[index],
                  ),
                ),
              );
            }),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.all(12),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
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
              Navigator.pop(context, label);
            },
          ),
        ));
  }
}

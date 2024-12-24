import 'package:flutter/material.dart';
import 'package:task_for_baity/core/styles.dart';
import 'package:task_for_baity/features/realEstateListing/data/models/realestate/real_estate.dart';

class LocationNames extends StatelessWidget {
  const LocationNames({super.key, required this.realEstate});
  final RealEstate realEstate;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(
            Icons.location_on,
            size: 15,
            color: Colors.blue[800],
          ),
          const SizedBox(
            width: 5,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Text(
              '${realEstate.city!.name!} - ${realEstate.district!.name} - ${realEstate.subDistrict!.name}',
              overflow: TextOverflow.ellipsis,
              style: Styles.regularStyle12(context).copyWith(
                color: Colors.blue[800],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

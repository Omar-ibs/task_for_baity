import 'package:flutter/material.dart';
import 'package:task_for_baity/core/styles.dart';
import 'package:task_for_baity/features/realEstateListing/data/models/realestate/real_estate.dart';

class DetailsInIcons extends StatelessWidget {
  const DetailsInIcons({
    super.key,
    required this.realEstate,
  });
  final RealEstate realEstate;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (realEstate.area != null)
          realEstateFeature(
              '${realEstate.area} m2', Icons.crop_square, context, null),
        if (realEstate.noOfLivingRooms != null)
          realEstateFeature('${realEstate.noOfLivingRooms}',
              Icons.chair_outlined, context, 50),
        if (realEstate.noOfBedRooms != null)
          realEstateFeature(
              '${realEstate.noOfBedRooms}', Icons.bed_outlined, context, 50),
        if (realEstate.parkingCapacity != null)
          realEstateFeature('${realEstate.parkingCapacity}',
              Icons.directions_car_filled_outlined, context, 50),
        if (realEstate.noOfBathRooms != null)
          realEstateFeature('${realEstate.noOfBathRooms}',
              Icons.bathtub_outlined, context, 50),
      ],
    );
  }

  Widget realEstateFeature(
      String label, IconData icon, BuildContext context, double? width) {
    return Container(
      height: 28,
      width: width,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey[200],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 20,
          ),
          const SizedBox(
            width: 5,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Text(
              label,
              style: Styles.regularStyle14(context),
            ),
          ),
        ],
      ),
    );
  }
}

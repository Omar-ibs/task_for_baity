import 'package:flutter/material.dart';
import 'package:task_for_baity/features/realEstateListing/data/models/realestate/real_estate.dart';

class RealEstateFeaturesGrid extends StatelessWidget {
  const RealEstateFeaturesGrid({
    super.key,
    required this.realEstate,
  });
  final RealEstate realEstate;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        if (realEstate.noOfLivingRooms != null)
          _buildFeatureBox(
            icon: Icons.chair_outlined,
            label: '${realEstate.noOfLivingRooms} living',
          ),
        if (realEstate.noOfBedRooms != null)
          _buildFeatureBox(
            icon: Icons.bed_outlined,
            label: '${realEstate.noOfBedRooms} bed\nroom',
          ),
        if (realEstate.parkingCapacity != null)
          _buildFeatureBox(
            icon: Icons.directions_car_outlined,
            label: '${realEstate.parkingCapacity} Car',
          ),
        if (realEstate.noOfBathRooms != null)
          _buildFeatureBox(
            icon: Icons.bathtub_outlined,
            label: '${realEstate.noOfBathRooms} bath',
          ),
      ],
    );
  }

  /// Builds a single feature box with the icon and label
  Widget _buildFeatureBox({required IconData icon, required String label}) {
    return Container(
      width: 80, // Fixed width for uniform boxes
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: Colors.grey[100], // Background color
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 28,
            color: Colors.black, // Icon color
          ),
          const SizedBox(height: 8),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}

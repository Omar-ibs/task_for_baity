import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_for_baity/core/app_images.dart';
import 'package:task_for_baity/core/styles.dart';
import 'package:task_for_baity/features/realEstateListing/data/models/realestate/real_estate.dart';

class SecondPartOfDetailsPage extends StatelessWidget {
  const SecondPartOfDetailsPage({super.key, required this.realEstate});
  final RealEstate realEstate;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildDetailsRow(context, 'Offer type', realEstate.offerType!),
          buildDetailsRow(context, 'Pay Type', 'Cash'),
          buildDetailsRow(context, 'Price',
              '${NumberFormat.simpleCurrency(locale: 'en_IQ', decimalDigits: 0, name: '').format(realEstate.price)} IQD',
              isPrice: true),
          buildDetailsRow(context, 'Category and subcategory',
              '${realEstate.category!.name} - ${realEstate.subCategory!.name}'),
          buildDetailsRow(context, 'Ownership', '${realEstate.ownerType}'),
          buildDetailsRow(context, 'Ad number', '${realEstate.id}'),
          const Divider(),
          buildDetailsRow(context, 'Area', '${realEstate.area.toString()} m²'),
          buildDetailsRow(
              context, 'Building age', '${realEstate.age.toString()} year'),
          const Divider(),
          buildDetailsRow(context, 'Address',
              '${realEstate.city!.name} - ${realEstate.district!.name} - ${realEstate.subDistrict!.name}'),
          const SizedBox(height: 16),
          Container(
            height: 200,
            color: Colors.grey[300],
            child: const Center(child: Text('Map View Placeholder')),
          ),
          const SizedBox(height: 16),
          const Divider(),
          const SizedBox(height: 16),
          const Text(
            'Description',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'Modern house for sale in ${realEstate.district!.name} - ${realEstate.subDistrict!.name}, first class building',
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 8),
          const Divider(),
          const SizedBox(height: 16),
          const Text(
            'Offered by',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 8,
          ),
          GestureDetector(
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: CachedNetworkImage(
                    imageUrl: realEstate.ownerImageUrl ?? Assets.imagesAppBar,
                    fit: BoxFit.fill,
                    height: 100,
                    width: 100,
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      realEstate.ownerName!,
                      style: Styles.semiBoldStyle16(context)
                          .copyWith(color: Colors.black),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.call,
                          size: 18,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          '+9647865955716',
                          style: Styles.regularStyle16(context),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Icon(
                      Icons.email,
                      size: 18,
                    )
                  ],
                )
              ],
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            'Owner',
            style: Styles.regularStyle16(context).copyWith(color: Colors.black),
          ),
          const SizedBox(height: 16),
          const Divider(),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget buildDetailsRow(BuildContext context, String label, String value,
      {bool isPrice = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Flexible(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            Text(
              isPrice ? 'Call Publisher' : value,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: TextStyle(
                fontSize: 16,
                fontWeight: isPrice ? FontWeight.bold : FontWeight.normal,
                color: isPrice ? Colors.blue : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

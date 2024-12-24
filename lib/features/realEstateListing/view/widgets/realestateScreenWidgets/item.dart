import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:task_for_baity/core/styles.dart';
import 'package:task_for_baity/features/realEstateListing/data/models/realestate/real_estate.dart';
import 'package:task_for_baity/features/realEstateListing/view/widgets/realestateScreenWidgets/details_in_icons.dart';
import 'package:task_for_baity/features/realEstateListing/view/widgets/realestateScreenWidgets/details_page.dart';
import 'package:task_for_baity/features/realEstateListing/view/widgets/realestateScreenWidgets/item_info_line.dart';
import 'package:task_for_baity/features/realEstateListing/view/widgets/realestateScreenWidgets/location_names.dart';
import 'package:task_for_baity/features/realEstateListing/view/widgets/realestateScreenWidgets/price_and_date.dart';

class Item extends StatelessWidget {
  const Item({
    super.key,
    required this.realEstate,
  });

  final RealEstate realEstate;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Animate(
                        effects: const [
                          SlideEffect(
                              duration: Duration(milliseconds: 300),
                              begin: Offset(1, 0),
                              end: Offset(0, 0)),
                        ],
                        child: DetailsPage(
                          realEstate: realEstate,
                        ))));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey[800]!, width: 1),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.7),
                spreadRadius: 3,
                blurRadius: 3,
                offset: const Offset(0, 3),
              ),
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: CachedNetworkImage(
                  imageUrl: realEstate.image!,
                  width: double.maxFinite,
                  height: 200,
                  fit: BoxFit.cover,
                )),
            const SizedBox(
              height: 4,
            ),
            PriceAndDate(realEstate: realEstate),
            const SizedBox(
              height: 4,
            ),
            Text(
              realEstate.title!,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style:
                  Styles.semiBoldStyle16(context).copyWith(color: Colors.black),
            ),
            const SizedBox(
              height: 4,
            ),
            ItemInfoLine(realEstate: realEstate),
            const SizedBox(
              height: 4,
            ),
            DetailsInIcons(
              realEstate: realEstate,
            ),
            const SizedBox(
              height: 4,
            ),
            LocationNames(realEstate: realEstate),
          ],
        ),
      ),
    );
  }
}

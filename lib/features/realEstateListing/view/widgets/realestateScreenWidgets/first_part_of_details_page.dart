import 'package:flutter/material.dart';
import 'package:task_for_baity/core/styles.dart';
import 'package:task_for_baity/features/realEstateListing/data/models/realestate/real_estate.dart';
import 'package:task_for_baity/features/realEstateListing/view/widgets/realestateScreenWidgets/expanded_details_inIcons.dart';
import 'package:task_for_baity/features/realEstateListing/view/widgets/realestateScreenWidgets/format_date.dart';

class FirstPartOfDetails extends StatelessWidget {
  const FirstPartOfDetails({
    super.key,
    required this.realEstate,
  });
  final RealEstate realEstate;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          children: [
            Text(
              FormatDate.formatDate(realEstate.createdAt!),
            ),
            const Spacer(),
            Icon(
              Icons.camera_alt_outlined,
              color: Colors.grey[400],
              size: 20,
            ),
            const SizedBox(
              width: 3,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: Text(
                realEstate.imagesCount.toString(),
                style: Styles.semiBoldStyle16(context)
                    .copyWith(color: Colors.grey, fontWeight: FontWeight.w400),
              ),
            ),
            const SizedBox(
              width: 3,
            ),
            Icon(
              Icons.remove_red_eye_outlined,
              color: Colors.grey[400],
              size: 20,
            ),
            const SizedBox(
              width: 3,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: Text(
                realEstate.views.toString(),
                style: Styles.semiBoldStyle16(context)
                    .copyWith(color: Colors.grey, fontWeight: FontWeight.w400),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20.0,
        ),
        Text(
          realEstate.title!,
          style: Styles.mediumStyle20(context).copyWith(color: Colors.black),
        ),
        const SizedBox(
          height: 20.0,
        ),
        RealEstateFeaturesGrid(
          realEstate: realEstate,
        )
      ]),
    );
  }
}

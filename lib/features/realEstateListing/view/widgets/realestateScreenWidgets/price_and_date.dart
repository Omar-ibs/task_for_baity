import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_for_baity/core/styles.dart';
import 'package:task_for_baity/features/realEstateListing/data/models/realestate/real_estate.dart';
import 'package:task_for_baity/features/realEstateListing/view/widgets/realestateScreenWidgets/format_date.dart';

class PriceAndDate extends StatelessWidget {
  const PriceAndDate({super.key, required this.realEstate});
  final RealEstate realEstate;
  @override
  Widget build(BuildContext context) {
    final formatPrice =
        NumberFormat.currency(locale: 'en_IQ', decimalDigits: 0, name: '');
    String price = formatPrice.format(realEstate.price);
    return Row(
      children: [
        Text(
          price == '0' ? 'Call Publisher' : '$price IQD',
          style: Styles.mediumStyle16(context)
              .copyWith(color: Colors.blue[800], fontWeight: FontWeight.bold),
        ),
        const Spacer(),
        Text(
          FormatDate.formatDate(realEstate.createdAt!),
          style: Styles.regularStyle14(context),
        ),
      ],
    );
  }
}

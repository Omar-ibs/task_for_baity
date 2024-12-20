import 'offer_type.dart';
import 'owner_type.dart';

class Realestates {
  int? total;
  int? urgent;
  OfferType? offerType;
  OwnerType? ownerType;

  Realestates({this.total, this.urgent, this.offerType, this.ownerType});

  factory Realestates.fromJson(Map<String, dynamic> json) => Realestates(
        total: json['total'] as int?,
        urgent: json['urgent'] as int?,
        offerType: json['offerType'] == null
            ? null
            : OfferType.fromJson(json['offerType'] as Map<String, dynamic>),
        ownerType: json['ownerType'] == null
            ? null
            : OwnerType.fromJson(json['ownerType'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'total': total,
        'urgent': urgent,
        'offerType': offerType?.toJson(),
        'ownerType': ownerType?.toJson(),
      };
}

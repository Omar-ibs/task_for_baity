class OfferType {
  int? sell;
  int? rent;
  int? unknown;

  OfferType({this.sell, this.rent, this.unknown});

  factory OfferType.fromJson(Map<String, dynamic> json) => OfferType(
        sell: json['sell'] as int?,
        rent: json['rent'] as int?,
        unknown: json['unknown'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'sell': sell,
        'rent': rent,
        'unknown': unknown,
      };
}

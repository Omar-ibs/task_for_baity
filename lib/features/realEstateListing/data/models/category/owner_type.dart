class OwnerType {
  int? realestateAgency;
  int? constructionCompany;
  int? realestateDeveloper;
  int? realtor;
  int? customer;

  OwnerType({
    this.realestateAgency,
    this.constructionCompany,
    this.realestateDeveloper,
    this.realtor,
    this.customer,
  });

  factory OwnerType.fromJson(Map<String, dynamic> json) => OwnerType(
        realestateAgency: json['realestateAgency'] as int?,
        constructionCompany: json['constructionCompany'] as int?,
        realestateDeveloper: json['realestateDeveloper'] as int?,
        realtor: json['realtor'] as int?,
        customer: json['customer'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'realestateAgency': realestateAgency,
        'constructionCompany': constructionCompany,
        'realestateDeveloper': realestateDeveloper,
        'realtor': realtor,
        'customer': customer,
      };
}

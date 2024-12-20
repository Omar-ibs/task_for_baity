class RealestateGroup {
  int? realestateAgency;
  int? buildingComplex;
  int? constructionCompany;
  int? realestateDeveloper;
  int? realtor;

  RealestateGroup({
    this.realestateAgency,
    this.buildingComplex,
    this.constructionCompany,
    this.realestateDeveloper,
    this.realtor,
  });

  factory RealestateGroup.fromJson(Map<String, dynamic> json) {
    return RealestateGroup(
      realestateAgency: json['realestateAgency'] as int?,
      buildingComplex: json['buildingComplex'] as int?,
      constructionCompany: json['constructionCompany'] as int?,
      realestateDeveloper: json['realestateDeveloper'] as int?,
      realtor: json['realtor'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
        'realestateAgency': realestateAgency,
        'buildingComplex': buildingComplex,
        'constructionCompany': constructionCompany,
        'realestateDeveloper': realestateDeveloper,
        'realtor': realtor,
      };
}

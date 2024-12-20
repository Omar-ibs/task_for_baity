import 'realestate_group.dart';
import 'realestates.dart';

class Stats {
  int? districts;
  int? subDistricts;
  RealestateGroup? realestateGroup;
  Realestates? realestates;

  Stats({
    this.districts,
    this.subDistricts,
    this.realestateGroup,
    this.realestates,
  });

  factory Stats.fromJson(Map<String, dynamic> json) => Stats(
        districts: json['districts'] as int?,
        subDistricts: json['subDistricts'] as int?,
        realestateGroup: json['realestateGroup'] == null
            ? null
            : RealestateGroup.fromJson(
                json['realestateGroup'] as Map<String, dynamic>),
        realestates: json['realestates'] == null
            ? null
            : Realestates.fromJson(json['realestates'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'districts': districts,
        'subDistricts': subDistricts,
        'realestateGroup': realestateGroup?.toJson(),
        'realestates': realestates?.toJson(),
      };
}

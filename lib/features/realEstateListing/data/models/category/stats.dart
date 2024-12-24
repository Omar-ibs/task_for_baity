import 'realestates.dart';

class Stats {
  Realestates? realestates;

  Stats({this.realestates});

  factory Stats.fromJson(Map<String, dynamic> json) => Stats(
        realestates: json['realestates'] == null
            ? null
            : Realestates.fromJson(json['realestates'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'realestates': realestates?.toJson(),
      };
}

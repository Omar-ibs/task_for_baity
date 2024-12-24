import 'country.dart';
import 'names.dart';
import 'stats.dart';

class Cities {
  Names? names;
  Stats? stats;
  bool? isActive;
  bool? isDeleted;
  dynamic name;
  String? id;
  String? createdAt;
  String? updatedAt;
  double? lat;
  double? lng;
  int? zoom;
  Country? country;

  Cities({
    this.names,
    this.stats,
    this.isActive,
    this.isDeleted,
    this.name,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.lat,
    this.lng,
    this.zoom,
    this.country,
  });

  factory Cities.fromJson(Map<String, dynamic> json) => Cities(
        names: json['names'] == null
            ? null
            : Names.fromJson(json['names'] as Map<String, dynamic>),
        stats: json['stats'] == null
            ? null
            : Stats.fromJson(json['stats'] as Map<String, dynamic>),
        isActive: json['isActive'] as bool?,
        isDeleted: json['isDeleted'] as bool?,
        name: json['name'] as dynamic,
        id: json['id'] as String?,
        createdAt: json['createdAt'] as String?,
        updatedAt: json['updatedAt'] as String?,
        lat: (json['lat'] as num?)?.toDouble(),
        lng: (json['lng'] as num?)?.toDouble(),
        zoom: json['zoom'] as int?,
        country: json['country'] == null
            ? null
            : Country.fromJson(json['country'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'names': names?.toJson(),
        'stats': stats?.toJson(),
        'isActive': isActive,
        'isDeleted': isDeleted,
        'name': name,
        'id': id,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
        'lat': lat,
        'lng': lng,
        'zoom': zoom,
        'country': country?.toJson(),
      };
}

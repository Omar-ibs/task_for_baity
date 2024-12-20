import 'category.dart';
import 'names.dart';

class SubCategory {
  String? id;
  int? sortingIndex;
  bool? isActive;
  bool? isDeleted;
  String? image;
  Names? names;
  Category? category;
  dynamic stats;
  List<String>? realestateFeatures;
  List<String>? features;

  SubCategory({
    this.id,
    this.sortingIndex,
    this.isActive,
    this.isDeleted,
    this.image,
    this.names,
    this.category,
    this.stats,
    this.realestateFeatures,
    this.features,
  });

  factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
        id: json['id'] as String?,
        sortingIndex: json['sortingIndex'] as int?,
        isActive: json['isActive'] as bool?,
        isDeleted: json['isDeleted'] as bool?,
        image: json['image'] as String?,
        names: json['names'] == null
            ? null
            : Names.fromJson(json['names'] as Map<String, dynamic>),
        category: json['category'] == null
            ? null
            : Category.fromJson(json['category'] as Map<String, dynamic>),
        stats: json['stats'] as dynamic,
        realestateFeatures: json['realestateFeatures'] as List<String>?,
        features: json['features'] as List<String>?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'sortingIndex': sortingIndex,
        'isActive': isActive,
        'isDeleted': isDeleted,
        'image': image,
        'names': names?.toJson(),
        'category': category?.toJson(),
        'stats': stats,
        'realestateFeatures': realestateFeatures,
        'features': features,
      };
}

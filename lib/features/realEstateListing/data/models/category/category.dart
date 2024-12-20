import 'names.dart';
import 'stats.dart';
import 'sub_category.dart';

class Category {
  String? id;
  int? sortingIndex;
  bool? isActive;
  bool? isDeleted;
  String? image;
  List<dynamic>? types;
  Names? names;
  List<SubCategory>? subCategories;
  Stats? stats;

  Category({
    this.id,
    this.sortingIndex,
    this.isActive,
    this.isDeleted,
    this.image,
    this.types,
    this.names,
    this.subCategories,
    this.stats,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json['id'] as String?,
        sortingIndex: json['sortingIndex'] as int?,
        isActive: json['isActive'] as bool?,
        isDeleted: json['isDeleted'] as bool?,
        image: json['image'] as String?,
        types: json['types'] as List<dynamic>?,
        names: json['names'] == null
            ? null
            : Names.fromJson(json['names'] as Map<String, dynamic>),
        subCategories: (json['subCategories'] as List<dynamic>?)
            ?.map((e) => SubCategory.fromJson(e as Map<String, dynamic>))
            .toList(),
        stats: json['stats'] == null
            ? null
            : Stats.fromJson(json['stats'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'sortingIndex': sortingIndex,
        'isActive': isActive,
        'isDeleted': isDeleted,
        'image': image,
        'types': types,
        'names': names?.toJson(),
        'subCategories': subCategories?.map((e) => e.toJson()).toList(),
        'stats': stats?.toJson(),
      };
}

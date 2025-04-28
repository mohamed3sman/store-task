import 'package:fake_store/features/home/domain/entities/category_entity.dart';

class CategoryModel {
  final int id;
  final String name;
  final String? slug;
  final String image;
  final DateTime? creationAt;
  final DateTime? updatedAt;

  CategoryModel({
    required this.id,
    required this.name,
    this.slug,
    required this.image,
    this.creationAt,
    this.updatedAt,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
    id: json['id'] as int,
    name: json['name'] as String,
    slug: json['slug'] as String?,
    image: json['image'] as String,
    creationAt:
        json['creationAt'] == null
            ? null
            : DateTime.parse(json['creationAt'] as String),
    updatedAt:
        json['updatedAt'] == null
            ? null
            : DateTime.parse(json['updatedAt'] as String),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'slug': slug,
    'image': image,
    'creationAt': creationAt?.toIso8601String(),
    'updatedAt': updatedAt?.toIso8601String(),
  };

  // Convert model to entity
  CategoryEntity toEntity() => CategoryEntity(id: id, name: name, image: image);
}

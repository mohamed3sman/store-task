import 'package:hive/hive.dart';

part 'product_entity.g.dart';

@HiveType(typeId: 0)
class ProductEntity extends HiveObject {
  @HiveField(0)
  final int? id;

  @HiveField(1)
  final String? title;

  @HiveField(2)
  final int? price;

  @HiveField(3)
  final String? description;

  @HiveField(4)
  final String? category;

  @HiveField(5)
  final String? images;

  @HiveField(6)
  final String? brand;

  @HiveField(7)
  final String? model;

  @HiveField(8)
  final String? color;

  @HiveField(9)
  final num? discount;

  @HiveField(10)
  bool? isFavourite;

  ProductEntity({
    required this.isFavourite,
    required this.brand,
    required this.model,
    required this.color,
    required this.discount,
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.images,
  });
}

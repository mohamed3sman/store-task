// import 'package:fake_store/features/home/data/models/product.dart';

// class ProductEntity {
//   final int? id;
//   final String? title;
//   final int? price;
//   final String? description;
//   final ProductCategory? category;
//   final List<dynamic>? images;

//   ProductEntity({
//     required this.id,
//     required this.title,
//     required this.price,
//     required this.description,
//     required this.category,
//     required this.images,
//   });
// }

class ProductEntity {
  final int? id;
  final String? title;
  final int? price;
  final String? description;
  final String? category;
  final String? images;
  final String? brand;
  final String? model;
  final String? color;
  final num? discount;

  ProductEntity({
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

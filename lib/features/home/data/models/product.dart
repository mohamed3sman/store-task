// import 'package:fake_store/features/home/domain/entities/product_entity.dart';

// class Product extends ProductEntity {
//   int? modelId;
//   String? modelTitle;
//   String? slug;
//   int? modelPrice;
//   String? modelDescription;
//   ProductCategory? modelCategory;
//   List<dynamic>? modelImages;

//   Product({
//     this.modelId,
//     this.modelTitle,
//     this.slug,
//     this.modelPrice,
//     this.modelDescription,
//     this.modelCategory,
//     this.modelImages,
//   }) : super(
//          id: modelId,
//          category: modelCategory,
//          description: modelDescription,
//          images: modelImages,
//          price: modelPrice,
//          title: modelTitle,
//        );

//   factory Product.fromJson(Map<String, dynamic> json) => Product(
//     modelId: json['id'] as int?,
//     modelTitle: json['title'] as String?,
//     slug: json['slug'] as String?,
//     modelPrice: json['price'] as int?,
//     modelDescription: json['description'] as String?,
//     modelCategory:
//         json['category'] == null
//             ? null
//             : ProductCategory.fromJson(
//               json['category'] as Map<String, dynamic>,
//             ),
//     modelImages: json['images'] as List<dynamic>?,
//   );

//   Map<String, dynamic> toJson() => {
//     'id': id,
//     'title': title,
//     'slug': slug,
//     'price': price,
//     'description': description,
//     'category': category?.toJson(),
//     'images': images,
//   };

//   ProductEntity toEntity() => ProductEntity(
//     id: id,
//     category: category,
//     description: description,
//     images: images,
//     price: price,
//     title: title,
//   );
// }

// class ProductCategory {
//   int? id;
//   String? name;
//   String? image;
//   String? slug;

//   ProductCategory({this.id, this.name, this.image, this.slug});

//   factory ProductCategory.fromJson(Map<String, dynamic> json) =>
//       ProductCategory(
//         id: json['id'] as int?,
//         name: json['name'] as String?,
//         image: json['image'] as String?,
//         slug: json['slug'] as String?,
//       );

//   Map<String, dynamic> toJson() => {
//     'id': id,
//     'name': name,
//     'image': image,
//     'slug': slug,
//   };
// }

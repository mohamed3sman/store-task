import 'package:fake_store/features/home/domain/entities/product_entity.dart';

class ProductsModel extends ProductEntity {
  String? status;
  String? message;
  List<OneProduct>? products;

  ProductsModel({this.status, this.message, this.products})
    : super(
        brand: products?[0].brand,
        category: products?[0].category,
        color: products?[0].color,
        description: products?[0].description,
        discount: products?[0].discount,
        id: products?[0].id,
        images: products?[0].image,
        model: products?[0].model,
        price: products?[0].price,
        title: products?[0].title,
      );

  factory ProductsModel.fromJson(Map<String, dynamic> json) => ProductsModel(
    status: json['status'] as String?,
    message: json['message'] as String?,
    products:
        (json['products'] as List<dynamic>?)
            ?.map((e) => OneProduct.fromJson(e as Map<String, dynamic>))
            .toList(),
  );

  Map<String, dynamic> toJson() => {
    'status': status,
    'message': message,
    'products': products?.map((e) => e.toJson()).toList(),
  };
}

class OneProduct {
  int? id;
  String? title;
  String? image;
  int? price;
  String? description;
  String? brand;
  String? model;
  String? color;
  String? category;
  int? discount;
  bool? popular;
  bool? onSale;

  OneProduct({
    this.id,
    this.title,
    this.image,
    this.price,
    this.description,
    this.brand,
    this.model,
    this.color,
    this.category,
    this.discount,
    this.popular,
    this.onSale,
  });

  factory OneProduct.fromJson(Map<String, dynamic> json) => OneProduct(
    id: json['id'] as int?,
    title: json['title'] as String?,
    image: json['image'] as String?,
    price: json['price'] as int?,
    description: json['description'] as String?,
    brand: json['brand'] as String?,
    model: json['model'] as String?,
    color: json['color'] as String?,
    category: json['category'] as String?,
    discount: json['discount'] as int?,
    popular: json['popular'] as bool?,
    onSale: json['onSale'] as bool?,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'image': image,
    'price': price,
    'description': description,
    'brand': brand,
    'model': model,
    'color': color,
    'category': category,
    'discount': discount,
    'popular': popular,
    'onSale': onSale,
  };

  ProductEntity toEntity() => ProductEntity(
    brand: brand,
    color: color,
    discount: discount,
    model: model,
    id: id,
    category: category,
    description: description,
    images: image,
    price: price,
    title: title,
  );
}

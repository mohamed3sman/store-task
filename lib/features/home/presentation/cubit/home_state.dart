import 'package:fake_store/features/home/domain/entities/category_entity.dart';
import 'package:fake_store/features/home/domain/entities/product_entity.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class CategoryLoading extends HomeState {}

class CategorySuccess extends HomeState {
  final List<CategoryEntity> categoriesList;

  CategorySuccess(this.categoriesList);
}

class CategoryFailure extends HomeState {
  final String error;

  CategoryFailure(this.error);
}

class ProductsLoading extends HomeState {}

class ProductsMoreLoading extends HomeState {
  final List<ProductEntity> oldProducts;
  ProductsMoreLoading(this.oldProducts);
}

class ProductsSuccess extends HomeState {
  final List<ProductEntity> productsList;

  ProductsSuccess(this.productsList);
}

class ProductsFailure extends HomeState {
  final String error;

  ProductsFailure(this.error);
}

class CategoryToggle extends HomeState {}

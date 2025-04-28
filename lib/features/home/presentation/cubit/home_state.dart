import 'package:fake_store/features/home/domain/entities/category_entity.dart';

abstract class HomeState {}

class CategoryInitial extends HomeState {}

class CategoryLoading extends HomeState {}

class CategorySuccess extends HomeState {
  final List<CategoryEntity> categoriesList;

  CategorySuccess(this.categoriesList);
}

class CategoryFailure extends HomeState {
  final String error;

  CategoryFailure(this.error);
}

class CategoryToggle extends HomeState {}

import 'package:fake_store/core/network/shared.dart';
import 'package:fake_store/features/home/domain/entities/category_entity.dart';
import 'package:fake_store/features/home/domain/usecases/category_usecase.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final CategoryUsecase categoryUsecase;
  final SecureStorageService secureStorageService;
  final TextEditingController searchController = TextEditingController();
  int? currentCategoryId;
  List<CategoryEntity> categoriesList = [];

  HomeCubit({required this.categoryUsecase, required this.secureStorageService})
    : super(CategoryInitial()) {
    getAllCategories();
  }

  Future<void> getAllCategories() async {
    emit(CategoryLoading());

    final categories = await categoryUsecase.execute();

    categories.fold(
      (failure) {
        emit(CategoryFailure(failure.message));
      },
      (categories) {
        currentCategoryId = categories.first.id;
        categoriesList = categories;
        emit(CategorySuccess(categories));
      },
    );
  }

  toggleCurrentCategory(int? categoryId) {
    currentCategoryId = categoryId;
    emit(CategoryToggle());
  }
}

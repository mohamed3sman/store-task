import 'dart:async';

import 'package:fake_store/core/network/shared.dart';
import 'package:fake_store/features/home/domain/entities/category_entity.dart';
import 'package:fake_store/features/home/domain/entities/product_entity.dart';
import 'package:fake_store/features/home/domain/usecases/category_usecase.dart';
import 'package:fake_store/features/home/domain/usecases/product_usecase.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final CategoryUsecase categoryUsecase;
  final ProductUsecase productUsecase;
  final SecureStorageService secureStorageService;
  final TextEditingController searchController = TextEditingController();

  // Category related variables
  int? currentCategoryId;
  String? currentCategoryName;
  List<CategoryEntity> categoriesList = [];

  // Products related variables
  List<ProductEntity> productsList = [];
  List<ProductEntity> searchedProductsList = [];
  List<ProductEntity> previousFetchedList = [];
  int currentPage = 1;
  bool isLoading = false;
  bool hasReachedMax = false;
  bool isSearchingNow = false;
  late ScrollController scrollController;
  Timer? _debounce;
  double selectedMinPrice = 0;
  double selectedMaxPrice = 1000;

  final categoriesStringList = [
    "all",
    "tv",
    "audio",
    "laptop",
    "mobile",
    "gaming",
    "appliances",
  ];

  HomeCubit({
    required this.productUsecase,
    required this.categoryUsecase,
    required this.secureStorageService,
  }) : super(HomeInitial()) {
    scrollController = ScrollController();
    scrollController.addListener(_scrollListener);
    getAllCategories();
    getProducts();
    initCategoryName();
  }

  void _scrollListener() {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent - 200) {
      if (!isLoading && !hasReachedMax) {
        loadMoreProducts();
      }
    }
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

  Future<void> getProducts() async {
    if (isLoading) return;
    isLoading = true;
    currentPage = 1;
    productsList = [];
    previousFetchedList = [];
    hasReachedMax = false;
    if (searchController.text.isEmpty) isSearchingNow = false;

    emit(ProductsLoading());

    final products = await productUsecase.execute(
      isSearchingNow: isSearchingNow,
      page: currentPage,
      category: currentCategoryName != 'all' ? currentCategoryName : null,
    );

    products.fold(
      (failure) {
        emit(ProductsFailure(failure.message));
        isLoading = false;
      },
      (products) {
        previousFetchedList = List.from(products);
        productsList = products;
        currentPage++;
        emit(ProductsSuccess(productsList));
        isLoading = false;
      },
    );
  }

  Future<void> loadMoreProducts() async {
    if (isLoading || hasReachedMax) return;

    isLoading = true;

    // Emit loading state but keep current products visible
    emit(ProductsMoreLoading(List.from(productsList)));

    final products = await productUsecase.execute(
      page: currentPage,
      category: currentCategoryName != 'all' ? currentCategoryName : null,
      isSearchingNow: isSearchingNow,
    );

    products.fold(
      (failure) {
        emit(ProductsFailure(failure.message));
        isLoading = false;
      },
      (newProducts) {
        // Compare new products with previous fetched products to check if we've reached the end
        // If the lists are identical or the new list is empty, we've reached the end
        if (_areProductListsIdentical(previousFetchedList, newProducts) ||
            newProducts.isEmpty) {
          hasReachedMax = true;
          emit(ProductsSuccess(List.from(productsList)));
        } else {
          previousFetchedList = List.from(newProducts);
          productsList.addAll(newProducts);
          currentPage++;
          emit(ProductsSuccess(List.from(productsList)));
        }
        isLoading = false;
      },
    );
  }

  // Helper method to check if two product lists contain the same items
  bool _areProductListsIdentical(
    List<ProductEntity> list1,
    List<ProductEntity> list2,
  ) {
    if (list1.length != list2.length) return false;

    // Compare each product by its unique ID
    for (int i = 0; i < list1.length; i++) {
      // Assuming ProductEntity has an id field. Adjust based on your actual implementation
      if (list1[i].id != list2[i].id) {
        return false;
      }
    }

    return true;
  }

  initCategoryName() {
    currentCategoryName = categoriesStringList.first;
    emit(CategoryToggle());
  }

  toggleCurrentCategory(String? categoryName) {
    currentCategoryName = categoryName;
    resetAndRefreshProducts();
    emit(CategoryToggle());

    // Reset pagination and load new products when category changes
  }

  resetAndRefreshProducts() async {
    currentPage = 1;
    productsList = [];
    previousFetchedList = [];
    hasReachedMax = false;
    searchController.clear();
    await getProducts();
  }

  @override
  Future<void> close() {
    scrollController.removeListener(_scrollListener);
    scrollController.dispose();
    searchController.dispose();
    return super.close();
  }

  void onSearchProduct({String? query}) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 300), () async {
      if (currentCategoryName == 'all') {
        isSearchingNow = true;
        await getProducts();
      }
      searchedProductsList =
          productsList
              .where(
                (element) =>
                    element.title!.toLowerCase().contains(query!.toLowerCase()),
              )
              .toList();

      emit(ProductSearchStart());

      if (searchController.text.isEmpty) {
        if (currentCategoryName == 'all') {
          isSearchingNow = false;
          await getProducts();
        }
        emit(ProductSearchEnd());
      }
    });
  }

  void filterByPrice(double min, double max, BuildContext context) {
    isSearchingNow = true;
    selectedMinPrice = min;
    selectedMaxPrice = max;

    searchedProductsList =
        productsList.where((product) {
          final price = product.price ?? 0;
          return price >= min && price <= max;
        }).toList();
    Navigator.pop(context);
    emit(ProductSearchStart());
  }
}

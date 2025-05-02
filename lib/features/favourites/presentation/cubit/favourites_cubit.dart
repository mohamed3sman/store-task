import 'package:fake_store/core/network/product_service.dart';
import 'package:fake_store/features/favourites/presentation/cubit/favourites_state.dart';
import 'package:fake_store/features/home/domain/entities/product_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavouritesCubit extends Cubit<FavouritesState> {
  FavouritesCubit(this.productService) : super(FavouritesInitial()) {
    getFavourites();
  }

  final ProductService productService;
  List<ProductEntity> favouritesList = [];

  getFavourites() {
    favouritesList = productService.getAllProducts();
    emit(FavouritesChange());
  }

  addProductToFavourites(ProductEntity product) {
    product.isFavourite = true;
    productService.addProduct(product);
    emit(FavouritesChange());
  }

  removeProductFromFavourites(ProductEntity product) {
    product.isFavourite = false;
    productService.deleteProductById(product.id!);
    emit(FavouritesChange());
  }
}

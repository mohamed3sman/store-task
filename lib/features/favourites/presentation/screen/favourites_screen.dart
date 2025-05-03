import 'package:fake_store/core/di/di.dart';
import 'package:fake_store/core/network/product_service.dart';
import 'package:fake_store/core/shared/constants/app_colors.dart';
import 'package:fake_store/core/shared/constants/app_constants.dart';
import 'package:fake_store/core/shared/constants/app_styles.dart';
import 'package:fake_store/features/favourites/presentation/cubit/favourites_cubit.dart';
import 'package:fake_store/features/favourites/presentation/cubit/favourites_state.dart';
import 'package:fake_store/features/product_details/presentation/screen/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fake_store/features/home/domain/entities/product_entity.dart';

class FavoriteProductsScreen extends StatelessWidget {
  const FavoriteProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Box<ProductEntity> favoritesBox = Hive.box<ProductEntity>(
      AppConstants.products,
    );

    return BlocBuilder<FavouritesCubit, FavouritesState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Favorite Products', style: AppStyles.styleMedium20),
            centerTitle: true,
          ),
          body: ValueListenableBuilder(
            valueListenable: favoritesBox.listenable(),
            builder: (context, Box<ProductEntity> box, _) {
              final favorites = box.values.toList();
              final favouriteCubit = context.read<FavouritesCubit>();
              final ProductService productService = sl<ProductService>();

              if (favorites.isEmpty) {
                return Center(
                  child: Text(
                    'No favourite products yet..!',
                    style: AppStyles.styleMedium18.copyWith(
                      color: Colors.orangeAccent,
                    ),
                  ),
                );
              }
              return ListView.separated(
                padding: const EdgeInsets.all(12),
                itemCount: favorites.length,
                separatorBuilder: (_, __) => SizedBox(height: 10),
                itemBuilder: (context, index) {
                  final product = favorites[index];
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade300,
                          blurRadius: 6,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(10),
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Hero(
                          tag: product.id!,
                          child: CachedNetworkImage(
                            imageUrl: product.images ?? '',
                            width: 70,
                            height: 70,
                            fit: BoxFit.fitHeight,
                            placeholder:
                                (context, url) =>
                                    const CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                            errorWidget:
                                (context, url, error) =>
                                    const Icon(Icons.error),
                          ),
                        ),
                      ),
                      title: Text(
                        product.title ?? 'Unknown',
                        style: AppStyles.styleMedium16.copyWith(
                          color: AppColors.primaryColor,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Text(
                        product.description ?? '',
                        style: AppStyles.styleRegular14,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '\$${product.price ?? 0}',
                            style: AppStyles.styleMedium14.copyWith(
                              color: Colors.orangeAccent,
                            ),
                          ),
                          SizedBox(height: 5),
                          GestureDetector(
                            onTap:
                                () =>
                                    productService.isProductFavorite(
                                          product.id!,
                                        )
                                        ? favouriteCubit
                                            .removeProductFromFavourites(
                                              product,
                                            )
                                        : favouriteCubit.addProductToFavourites(
                                          product,
                                        ),
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                shape: BoxShape.circle,
                              ),
                              child: AnimatedSwitcher(
                                duration: Duration(milliseconds: 300),
                                transitionBuilder: (child, animation) {
                                  return ScaleTransition(
                                    scale: animation,
                                    child: child,
                                  );
                                },
                                child: Icon(
                                  productService.isProductFavorite(product.id!)
                                      ? Icons.favorite
                                      : Icons.favorite_border_rounded,
                                  size: 18,
                                  key: ValueKey(
                                    productService.isProductFavorite(
                                      product.id!,
                                    ),
                                  ),
                                  color: Colors.orangeAccent,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      onTap:
                          () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) =>
                                      ProductDetailsScreen(product: product),
                            ),
                          ),
                    ),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}

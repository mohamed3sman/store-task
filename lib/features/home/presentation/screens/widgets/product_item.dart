import 'package:cached_network_image/cached_network_image.dart';
import 'package:fake_store/core/di/di.dart';
import 'package:fake_store/core/network/product_service.dart';
import 'package:fake_store/core/shared/constants/app_colors.dart';
import 'package:fake_store/core/shared/constants/app_styles.dart';
import 'package:fake_store/features/favourites/presentation/cubit/favourites_cubit.dart';
import 'package:fake_store/features/favourites/presentation/cubit/favourites_state.dart';
import 'package:fake_store/features/home/domain/entities/product_entity.dart';
import 'package:fake_store/features/product_details/presentation/screen/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
    super.key,
    required this.product,
    required this.productsList,
  });

  final ProductEntity product;
  final List<ProductEntity> productsList;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ProductDetailsScreen(product: product),
          ),
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              SizedBox(
                height: 130,
                child: Hero(
                  tag: product.id!,
                  child: CachedNetworkImage(
                    imageUrl: product.images ?? '',
                    fit: BoxFit.scaleDown,
                    placeholder:
                        (context, url) => Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 40,
                            vertical: 47,
                          ),
                          child: const CircularProgressIndicator(
                            color: Colors.orangeAccent,
                            strokeWidth: 2.5,
                          ),
                        ),
                    errorWidget:
                        (context, url, error) => const Icon(Icons.error),
                  ),
                ),
              ),
              SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 7),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 30,
                      child: Text(
                        product.title ?? 'Unknown name',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppStyles.styleRegular14.copyWith(
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '\$${product.price ?? 0}',
                          style: AppStyles.styleRegular16.copyWith(
                            color: Colors.orangeAccent,
                          ),
                        ),
                        BlocBuilder<FavouritesCubit, FavouritesState>(
                          builder: (context, state) {
                            final favouriteCubit =
                                context.read<FavouritesCubit>();
                            final ProductService productService =
                                sl<ProductService>();

                            return GestureDetector(
                              onTap:
                                  () =>
                                      productService.isProductFavorite(
                                            product.id!,
                                          )
                                          ? favouriteCubit
                                              .removeProductFromFavourites(
                                                product,
                                              )
                                          : favouriteCubit
                                              .addProductToFavourites(product),
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
                                    productService.isProductFavorite(
                                          product.id!,
                                        )
                                        ? Icons.favorite
                                        : Icons.favorite_border_rounded,
                                    size: 15,
                                    key: ValueKey(
                                      productService.isProductFavorite(
                                        product.id!,
                                      ),
                                    ),
                                    color: Colors.orangeAccent,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5),
            ],
          ),
        ),
      ),
    );
  }
}

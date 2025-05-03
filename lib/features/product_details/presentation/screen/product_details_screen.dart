import 'package:cached_network_image/cached_network_image.dart';
import 'package:fake_store/core/di/di.dart';
import 'package:fake_store/core/network/product_service.dart';
import 'package:fake_store/core/shared/constants/app_colors.dart';
import 'package:fake_store/core/shared/constants/app_styles.dart';
import 'package:fake_store/core/shared/widgets/custom_button.dart';
import 'package:fake_store/features/favourites/presentation/cubit/favourites_cubit.dart';
import 'package:fake_store/features/favourites/presentation/cubit/favourites_state.dart';
import 'package:fake_store/features/home/presentation/cubit/home_cubit.dart';
import 'package:fake_store/features/product_details/presentation/cubit/product_details_cubit.dart';
import 'package:fake_store/features/product_details/presentation/cubit/product_details_state.dart';
import 'package:flutter/material.dart';
import 'package:fake_store/features/home/domain/entities/product_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:readmore/readmore.dart';

class ProductDetailsScreen extends StatelessWidget {
  final ProductEntity product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final ProductService productService = sl<ProductService>();
    final favouriteCubit = context.read<FavouritesCubit>();
    return BlocProvider(
      create: (context) => ProductDetailsCubit(),
      child: BlocBuilder<FavouritesCubit, FavouritesState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor:
                context.read<HomeCubit>().isDarkMode
                    ? Colors.black
                    : Colors.white,
            body: Stack(
              children: [
                ListView(
                  children: [
                    Stack(
                      children: [
                        Hero(
                          tag: product.id!,
                          child: CachedNetworkImage(
                            imageUrl: product.images ?? '',
                            height: MediaQuery.sizeOf(context).height * 0.45,
                            fit: BoxFit.fitWidth,
                            width: double.infinity,
                          ),
                        ),
                        Positioned(
                          top: 5,
                          left: 10,
                          child: IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: Icon(Icons.arrow_back),
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 15,
                        right: 15,
                        top: 5,
                        bottom: 60,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  product.title ?? "No Title",
                                  style: AppStyles.styleMedium18.copyWith(
                                    color:
                                        context.read<HomeCubit>().isDarkMode
                                            ? Colors.white
                                            : AppColors.primaryColor,
                                  ),
                                ),
                              ),
                              SizedBox(width: 20),
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
                                            : favouriteCubit
                                                .addProductToFavourites(
                                                  product,
                                                ),
                                child: Container(
                                  padding: const EdgeInsets.all(7),
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
                                      key: ValueKey(
                                        productService.isProductFavorite(
                                          product.id!,
                                        ),
                                      ),
                                      size: 20,
                                      color: Colors.orangeAccent,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text(
                            product.brand ?? '',
                            style: AppStyles.styleMedium16.copyWith(
                              color:
                                  context.read<HomeCubit>().isDarkMode
                                      ? Colors.white
                                      : AppColors.mediumColor,
                            ),
                          ),
                          const SizedBox(height: 20),
                          ReadMoreText(
                            '${product.description} ',
                            trimMode: TrimMode.Line,
                            trimLines: 3,
                            style: AppStyles.styleRegular14,
                            colorClickableText: Colors.pink,
                            trimCollapsedText: 'Read more',
                            trimExpandedText: 'Show less',
                            lessStyle: AppStyles.styleMedium14.copyWith(
                              color: Colors.red,
                            ),
                            moreStyle: AppStyles.styleMedium16.copyWith(
                              color:
                                  context.read<HomeCubit>().isDarkMode
                                      ? Colors.orangeAccent
                                      : AppColors.primaryColor,
                            ),
                          ),
                          // Text(
                          //   product.description ?? "No description",
                          //   style: TextStyle(fontSize: 16),
                          //   maxLines: 2,
                          //   overflow: TextOverflow.ellipsis,
                          // ),
                          const SizedBox(height: 50),
                        ],
                      ),
                    ),
                  ],
                ),

                Positioned.fill(
                  left: 15,
                  right: 15,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      color:
                          context.read<HomeCubit>().isDarkMode
                              ? Colors.transparent
                              : Colors.white,
                      padding: EdgeInsets.all(10),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Price:  ",
                                    style: AppStyles.styleRegular16.copyWith(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Text(
                                    "\$${product.price ?? 0}",
                                    style: AppStyles.styleMedium20.copyWith(
                                      color: AppColors.primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 7,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: BlocBuilder<
                                  ProductDetailsCubit,
                                  ProductDetailsState
                                >(
                                  builder: (context, state) {
                                    final cubit =
                                        context.read<ProductDetailsCubit>();
                                    return Row(
                                      children: [
                                        GestureDetector(
                                          onTap:
                                              () => cubit.changeCounter(
                                                operation: Operation.increment,
                                              ),
                                          child: Icon(
                                            Icons.add,
                                            color: Colors.grey,
                                            size: 18,
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Text(
                                          cubit.counter.toString(),
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        SizedBox(width: 10),
                                        GestureDetector(
                                          onTap:
                                              () => cubit.changeCounter(
                                                operation: Operation.decrement,
                                              ),
                                          child: Icon(
                                            Icons.remove,
                                            color: Colors.grey,
                                            size: 18,
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          CustomButton(text: 'Buy Now', onPressed: () {}),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fake_store/core/shared/constants/app_colors.dart';
import 'package:fake_store/core/shared/constants/app_styles.dart';
import 'package:fake_store/features/home/domain/entities/product_entity.dart';
import 'package:fake_store/features/home/presentation/cubit/home_cubit.dart';
import 'package:fake_store/features/home/presentation/cubit/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsGrid extends StatelessWidget {
  const ProductsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    // return BlocBuilder<HomeCubit, HomeState>(
    //   builder: (context, state) {
    //     final cubit = context.read<HomeCubit>();
    //     List<ProductEntity> productsList =
    //         cubit.productsList
    //             .where(
    //               (element) => element.category?.id == cubit.currentCategoryId,
    //             )
    //             .toList();
    //     return GridView.builder(
    //       shrinkWrap: true,
    //       physics: NeverScrollableScrollPhysics(),
    //       padding: EdgeInsets.only(left: 15, right: 15, bottom: 10),
    //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    //         crossAxisSpacing: 15,
    //         crossAxisCount: 2,
    //         mainAxisExtent: 235,
    //         mainAxisSpacing: 15,
    //       ),
    //       itemCount: productsList.length,
    //       itemBuilder: (context, index) {
    //         ProductEntity product = productsList[index];
    //         return ClipRRect(
    //           borderRadius: BorderRadius.circular(5),
    //           child: Container(
    //             decoration: BoxDecoration(
    //               color: Colors.white,
    //               borderRadius: BorderRadius.circular(12),
    //             ),
    //             child: Column(
    //               children: [
    //                 Expanded(
    //                   child: CachedNetworkImage(
    //                     imageUrl: product.images?[0],
    //                     fit: BoxFit.cover,
    //                     placeholder:
    //                         (context, url) => Padding(
    //                           padding: const EdgeInsets.symmetric(
    //                             horizontal: 40,
    //                             vertical: 60,
    //                           ),
    //                           child: const CircularProgressIndicator(
    //                             color: Colors.orangeAccent,
    //                             strokeWidth: 2,
    //                           ),
    //                         ),
    //                     errorWidget:
    //                         (context, url, error) => const Icon(Icons.error),
    //                   ),
    //                 ),
    //                 SizedBox(height: 10),
    //                 Padding(
    //                   padding: const EdgeInsets.symmetric(horizontal: 7),
    //                   child: Column(
    //                     crossAxisAlignment: CrossAxisAlignment.start,
    //                     children: [
    //                       SizedBox(
    //                         height: 30,
    //                         child: Text(
    //                           productsList[index].title ?? 'Unknown name',
    //                           maxLines: 2,
    //                           overflow: TextOverflow.ellipsis,
    //                           style: AppStyles.styleRegular14.copyWith(
    //                             color: AppColors.primaryColor,
    //                           ),
    //                         ),
    //                       ),
    //                       SizedBox(height: 10),
    //                       Row(
    //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                         children: [
    //                           Text(
    //                             '\$${productsList[index].price ?? 0}',
    //                             style: AppStyles.styleRegular16.copyWith(
    //                               color: AppColors.primaryColor,
    //                             ),
    //                           ),
    //                           Icon(Icons.favorite_border_rounded, size: 18),
    //                         ],
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //                 SizedBox(height: 5),
    //               ],
    //             ),
    //           ),
    //         );
    //       },
    //     );
    //   },
    // );
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final cubit = context.read<HomeCubit>();
        List<ProductEntity> productsList = cubit.productsList;
        // .where(
        //   (element) => element.category == cubit.currentCategoryName,
        // )
        // .toList();
        return GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.only(left: 15, right: 15, bottom: 10),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: 15,
            crossAxisCount: 2,
            mainAxisExtent: 235,
            mainAxisSpacing: 15,
          ),
          itemCount: productsList.length,
          itemBuilder: (context, index) {
            ProductEntity product = productsList[index];
            return ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 150,
                      child: CachedNetworkImage(
                        imageUrl: product.images ?? '',
                        fit: BoxFit.scaleDown,
                        placeholder:
                            (context, url) => Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 40,
                                vertical: 57,
                              ),
                              child: const CircularProgressIndicator(
                                color: Colors.orangeAccent,
                                strokeWidth: 2,
                              ),
                            ),
                        errorWidget:
                            (context, url, error) => const Icon(Icons.error),
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 7),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 30,
                            child: Text(
                              productsList[index].title ?? 'Unknown name',
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
                                '\$${productsList[index].price ?? 0}',
                                style: AppStyles.styleRegular16.copyWith(
                                  color: Colors.orangeAccent,
                                ),
                              ),
                              Icon(Icons.favorite_border_rounded, size: 18),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 5),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

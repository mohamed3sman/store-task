import 'package:fake_store/core/di/di.dart';
import 'package:fake_store/core/shared/constants/app_colors.dart';
import 'package:fake_store/core/shared/constants/app_styles.dart';
import 'package:fake_store/features/favourites/presentation/screen/favourites_screen.dart';
import 'package:fake_store/features/home/presentation/cubit/home_cubit.dart';
import 'package:fake_store/features/home/presentation/cubit/home_state.dart';
import 'package:fake_store/features/home/presentation/screens/widgets/categories_list.dart';
import 'package:fake_store/core/shared/widgets/custom_search_bar.dart';
import 'package:fake_store/features/home/presentation/screens/widgets/products_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) => sl<HomeCubit>(),
        child: BlocConsumer<HomeCubit, HomeState>(
          listener: (context, state) {},
          builder: (context, state) {
            final cubit = context.read<HomeCubit>();
            return RefreshIndicator(
              onRefresh: () => cubit.resetAndRefreshProducts(),
              displacement: 70,
              color: AppColors.mediumColor,
              child: ListView(
                controller:
                    state is ProductSearchStart ? null : cubit.scrollController,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: MediaQuery.viewInsetsOf(context).top + 20,
                      left: 15,
                      right: 15,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(Icons.menu, size: 25),
                            Row(
                              children: [
                                IconButton(
                                  icon: Icon(Icons.brightness_6),
                                  onPressed: cubit.toggleThemeMode,
                                ),
                                GestureDetector(
                                  onTap:
                                      () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder:
                                              (context) =>
                                                  FavoriteProductsScreen(),
                                        ),
                                      ),
                                  child: Container(
                                    padding: const EdgeInsets.all(7),
                                    decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.favorite,
                                      size: 18,
                                      color: Colors.orangeAccent,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 25),
                        Text(
                          'What item are you\nlooking for?',
                          style: AppStyles.styleMedium18.copyWith(
                            fontSize: getResponsiveFontSize(fontSize: 25),
                          ),
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                              child: CustomSearchBar(
                                controller: cubit.searchController,
                                onChanged:
                                    (value) =>
                                        cubit.onSearchProduct(query: value),
                                onCloseIconTap:
                                    () => cubit.resetAndRefreshProducts(),
                              ),
                            ),
                            // SizedBox(width: 10),
                            // GestureDetector(
                            //   // onTap: () {
                            //   //   showModalBottomSheet(
                            //   //     context: context,
                            //   //     shape: RoundedRectangleBorder(
                            //   //       borderRadius: BorderRadius.vertical(
                            //   //         top: Radius.circular(20),
                            //   //       ),
                            //   //     ),
                            //   //     builder:
                            //   //         (context) => const PriceFilterSlider(),
                            //   //   );
                            //   // },
                            //   child: Container(
                            //     padding: EdgeInsets.all(12),
                            //     decoration: BoxDecoration(
                            //       color: Colors.grey[200],
                            //       borderRadius: BorderRadius.circular(5),
                            //     ),
                            //     child: Image.asset(
                            //       AppImages.filter,
                            //       width: 25,
                            //       height: 25,
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                        SizedBox(height: 25),
                        Text('Categories', style: AppStyles.styleSemiBold24),
                        SizedBox(height: 15),
                      ],
                    ),
                  ),
                  CategoriesList(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Text('Products', style: AppStyles.styleSemiBold20),
                  ),
                  SizedBox(height: 10),
                  ProductsGrid(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

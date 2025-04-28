import 'package:fake_store/core/shared/constants/app_styles.dart';
import 'package:fake_store/features/home/presentation/cubit/home_cubit.dart';
import 'package:fake_store/features/home/presentation/cubit/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesList extends StatelessWidget {
  const CategoriesList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final cubit = context.read<HomeCubit>();
        return SizedBox(
          height: 50,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            physics: const BouncingScrollPhysics(),
            separatorBuilder: (context, index) => const SizedBox(width: 20),
            scrollDirection: Axis.horizontal,
            itemCount: cubit.categoriesStringList.length,
            itemBuilder: (context, index) {
              final category = cubit.categoriesStringList[index];
              // final isSelected = category.id == cubit.currentCategoryId;

              // return GestureDetector(
              //   onTap: () => cubit.toggleCurrentCategory(category.id),
              //   child: SizedBox(
              //     width: 80,
              //     child: Column(
              //       children: [
              //         AnimatedContainer(
              //           duration: const Duration(milliseconds: 300),
              //           curve: Curves.easeInOut,
              //           height: isSelected ? 60 : 55,
              //           width: isSelected ? 60 : 55,
              //           decoration: BoxDecoration(
              //             borderRadius: BorderRadius.circular(12),
              //             border: Border.all(
              //               color:
              //                   isSelected
              //                       ? Colors.orangeAccent
              //                       : Colors.transparent,
              //               width: 2,
              //             ),
              //             color:
              //                 isSelected
              //                     ? Colors.orangeAccent.withValues(alpha: 0.1)
              //                     : Colors.white,
              //             boxShadow:
              //                 isSelected
              //                     ? [
              //                       BoxShadow(
              //                         color: Colors.orangeAccent.withValues(
              //                           alpha: 0.1,
              //                         ),
              //                         blurRadius: 8,
              //                         spreadRadius: 2,
              //                       ),
              //                     ]
              //                     : [],
              //           ),
              //           child: ClipRRect(
              //             borderRadius: BorderRadius.circular(10),
              //             child: CachedNetworkImage(
              //               imageUrl: category.image,
              //               fit: BoxFit.cover,
              //               placeholder:
              //                   (context, url) => Padding(
              //                     padding: const EdgeInsets.all(17),
              //                     child: const CircularProgressIndicator(
              //                       color: Colors.orangeAccent,
              //                       strokeWidth: 2,
              //                     ),
              //                   ),
              //               errorWidget:
              //                   (context, url, error) =>
              //                       const Icon(Icons.error),
              //             ),
              //           ),
              //         ),
              //         const SizedBox(height: 10),
              //         Text(
              //           category.name,
              //           textAlign: TextAlign.center,
              //           maxLines: 1,
              //           overflow: TextOverflow.ellipsis,
              //           style: AppStyles.styleRegular14.copyWith(
              //             color:
              //                 isSelected
              //                     ? Colors.orangeAccent
              //                     : AppColors.primaryColor,
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // );

              return GestureDetector(
                onTap: () => cubit.toggleCurrentCategory(category),
                child: IntrinsicWidth(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        cubit.categoriesStringList[index],
                        style: AppStyles.styleMedium18.copyWith(
                          color:
                              cubit.currentCategoryName == category
                                  ? Colors.orangeAccent
                                  : Colors.black,
                        ),
                      ),
                      AnimatedContainer(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.orangeAccent,
                        ),
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        height: cubit.currentCategoryName == category ? 3 : 0,
                        width: double.infinity,
                        margin: EdgeInsets.only(top: 4),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

import 'package:fake_store/core/di/di.dart';
import 'package:fake_store/core/shared/constants/app_styles.dart';
import 'package:fake_store/features/home/presentation/cubit/home_cubit.dart';
import 'package:fake_store/features/home/presentation/cubit/home_state.dart';
import 'package:fake_store/features/home/presentation/screens/widgets/categories_list.dart';
import 'package:fake_store/features/home/presentation/screens/widgets/custom_search_bar.dart';
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
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 50, left: 15, right: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [Icon(Icons.menu, size: 25)]),
                      SizedBox(height: 25),
                      Text(
                        'What item are you\nlooking for?',
                        style: AppStyles.styleMedium18.copyWith(
                          fontSize: getResponsiveFontSize(fontSize: 25),
                        ),
                      ),
                      SizedBox(height: 20),
                      CustomSearchBar(
                        controller: cubit.searchController,
                        onChanged: (value) {},
                      ),
                      SizedBox(height: 25),
                      Text('Categories', style: AppStyles.styleSemiBold24),
                      SizedBox(height: 15),
                    ],
                  ),
                ),
                CategoriesList(),
              ],
            );
          },
        ),
      ),
    );
  }
}

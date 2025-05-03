import 'package:fake_store/core/shared/constants/app_styles.dart';
import 'package:fake_store/features/home/domain/entities/product_entity.dart';
import 'package:fake_store/features/home/presentation/cubit/home_cubit.dart';
import 'package:fake_store/features/home/presentation/cubit/home_state.dart';
import 'package:fake_store/features/home/presentation/screens/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsGrid extends StatelessWidget {
  const ProductsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final cubit = context.read<HomeCubit>();
        final bool isPaginating = state is ProductsMoreLoading;
        final bool isLoading =
            state is ProductsLoading || state is CategoryToggle;
        List<ProductEntity> productsList =
            state is ProductSearchStart
                ? cubit.searchedProductsList
                : cubit.productsList;
        return productsList.isNotEmpty && isLoading == false
            ? Column(
              children: [
                GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.only(left: 15, right: 15, bottom: 10),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 15,
                    crossAxisCount: 2,
                    mainAxisExtent: 220,
                    mainAxisSpacing: 15,
                  ),
                  itemCount: productsList.length,
                  itemBuilder: (context, index) {
                    ProductEntity product = productsList[index];
                    return ProductItem(
                      product: product,
                      productsList: productsList,
                    );
                  },
                ),
                if (isPaginating == true)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 22,
                      width: 22,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.4,
                        color: Colors.orangeAccent,
                      ),
                    ),
                  ),
              ],
            )
            : Center(
              child: Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.sizeOf(context).height * 0.2,
                ),
                child:
                    isLoading
                        ? CircularProgressIndicator(color: Colors.orangeAccent)
                        : Text(
                          'No products found',
                          style: AppStyles.styleMedium18.copyWith(
                            color: Colors.orangeAccent,
                          ),
                        ),
              ),
            );
      },
    );
  }
}

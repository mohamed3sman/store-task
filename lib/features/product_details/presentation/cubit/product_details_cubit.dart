import 'package:fake_store/features/product_details/presentation/cubit/product_details_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum Operation { increment, decrement }

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  ProductDetailsCubit() : super(ProductDetailsInitial());

  int counter = 1;

  void changeCounter({required Operation operation}) {
    switch (operation) {
      case Operation.increment:
        counter++;
      case Operation.decrement:
        if (counter > 1) {
          counter--;
        }
    }
    emit(CounterChange());
  }
}

import 'package:dartz/dartz.dart';
import 'package:fake_store/core/errors/failures.dart';
import 'package:fake_store/features/home/data/data_source/home_remote_data_source.dart';
import 'package:fake_store/features/home/domain/entities/product_entity.dart';
import 'package:fake_store/features/home/domain/repositories/product_repository.dart';

class ProductsRepositoryImpl implements ProductRepository {
  final HomeRemoteDataSource homeRemoteDataSource;

  ProductsRepositoryImpl(this.homeRemoteDataSource);
  @override
  Future<Either<Failure, List<ProductEntity>>> getProducts({
    required int? page,
    required String? category,
    required bool? isSearchingNow,
  }) async {
    try {
      var productsList = await homeRemoteDataSource.getAllProducts(
        page: page,
        category: category,
        isSearchingNow: isSearchingNow,
      );
      return right(productsList);
    } on Exception catch (e) {
      return left(Failure(e.toString()));
    }
  }
}

import 'package:dartz/dartz.dart';
import 'package:fake_store/core/errors/failures.dart';
import 'package:fake_store/features/home/domain/entities/product_entity.dart';
import 'package:fake_store/features/home/domain/repositories/product_repository.dart';

class ProductUsecase {
  final ProductRepository repository;

  ProductUsecase(this.repository);

  Future<Either<Failure, List<ProductEntity>>> execute({
    required int? page,
    required String? category,
    required bool? isSearchingNow,
  }) {
    return repository.getProducts(
      page: page,
      category: category,
      isSearchingNow: isSearchingNow,
    );
  }
}

import 'package:dartz/dartz.dart';
import 'package:fake_store/core/errors/failures.dart';
import 'package:fake_store/features/home/domain/entities/product_entity.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<ProductEntity>>> getProducts({
    required int? page,
    required String? category,
    required bool? isSearchingNow,
  });
}

import 'package:dartz/dartz.dart';
import 'package:fake_store/core/errors/failures.dart';

import '../entities/category_entity.dart';

abstract class CategoryRepository {
  Future<Either<Failure, List<CategoryEntity>>> getCategories();
}

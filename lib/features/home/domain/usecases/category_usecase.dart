import 'package:dartz/dartz.dart';
import 'package:fake_store/core/errors/failures.dart';

import '../entities/category_entity.dart';
import '../repositories/category_repository.dart';

class CategoryUsecase {
  final CategoryRepository repository;

  CategoryUsecase(this.repository);

  Future<Either<Failure, List<CategoryEntity>>> execute() {
    return repository.getCategories();
  }
}

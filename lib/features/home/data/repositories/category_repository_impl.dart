import 'package:dartz/dartz.dart';
import 'package:fake_store/core/errors/failures.dart';
import 'package:fake_store/features/home/data/data_source/home_remote_data_source.dart';
import 'package:fake_store/features/home/domain/entities/category_entity.dart';
import 'package:fake_store/features/home/domain/repositories/category_repository.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final HomeRemoteDataSource homeRemoteDataSource;

  CategoryRepositoryImpl(this.homeRemoteDataSource);
  @override
  Future<Either<Failure, List<CategoryEntity>>> getCategories() async {
    try {
      var categoryList = await homeRemoteDataSource.getAllCategories();
      return right(categoryList);
    } on Exception catch (e) {
      return left(Failure(e.toString()));
    }
  }
}

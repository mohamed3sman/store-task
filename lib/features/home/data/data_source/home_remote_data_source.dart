import 'package:fake_store/core/network/dio_helper.dart';
import 'package:fake_store/core/shared/constants/app_constants.dart';
import 'package:fake_store/features/home/data/models/categoy.dart';
import 'package:fake_store/features/home/data/models/products_model.dart';
import 'package:fake_store/features/home/domain/entities/category_entity.dart';
import 'package:fake_store/features/home/domain/entities/product_entity.dart';

abstract class HomeRemoteDataSource {
  Future<List<CategoryEntity>> getAllCategories();
  Future<List<ProductEntity>> getAllProducts({
    required int? page,
    required String? category,
  });
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  @override
  Future<List<CategoryEntity>> getAllCategories() async {
    try {
      final response = await DioHelper.getData(
        url: '${AppConstants.baseUrl}/categories/',
        // url: 'https://fakestoreapi.in/api/products',
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data as List<dynamic>;
        return data
            .map((json) => CategoryModel.fromJson(json).toEntity())
            .toList();
      } else {
        throw Exception('Failed to load categories');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  @override
  Future<List<ProductEntity>> getAllProducts({
    required int? page,
    required String? category,
  }) async {
    try {
      final response = await DioHelper.getData(
        // url: '${AppConstants.baseUrl}/products',
        url:
            category != null
                ? 'https://fakestoreapi.in/api/products/category?type=$category'
                : 'https://fakestoreapi.in/api/products?page=${page ?? 1}&limit=10',
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['products'] as List<dynamic>;
        return data
            .map((json) => OneProduct.fromJson(json).toEntity())
            .toList();
      } else {
        throw Exception('Failed to load categories');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}

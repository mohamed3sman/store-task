import 'package:fake_store/core/network/dio_helper.dart';
import 'package:fake_store/core/shared/constants/app_constants.dart';
import 'package:fake_store/features/home/data/models/categoy.dart';
import 'package:fake_store/features/home/domain/entities/category_entity.dart';

abstract class HomeRemoteDataSource {
  Future<List<CategoryEntity>> getAllCategories();
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  @override
  Future<List<CategoryEntity>> getAllCategories() async {
    try {
      final response = await DioHelper.getData(
        url: '${AppConstants.baseUrl}/categories/',
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
}

import 'package:fake_store/core/shared/constants/app_constants.dart';
import 'package:fake_store/features/home/domain/entities/product_entity.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class HomeLocalDataSource {
  List<ProductEntity> getAllProducts();
}

class HomeLocalDataSourceImpl implements HomeLocalDataSource {
  @override
  List<ProductEntity> getAllProducts() {
    var box = Hive.box<ProductEntity>(AppConstants.cachedProducts);
    return box.values.toList();
  }
}

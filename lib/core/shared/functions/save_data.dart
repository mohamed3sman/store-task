import 'package:fake_store/features/home/domain/entities/product_entity.dart';
import 'package:hive_flutter/hive_flutter.dart';

void saveData(List<ProductEntity> books, String boxName) {
  var box = Hive.box<ProductEntity>(boxName);
  box.addAll(books);
}

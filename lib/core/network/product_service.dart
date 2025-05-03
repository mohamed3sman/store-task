import 'package:fake_store/core/shared/constants/app_constants.dart';
import 'package:hive/hive.dart';
import 'package:fake_store/features/home/domain/entities/product_entity.dart';

class ProductService {
  static final ProductService _singleton = ProductService._internal();
  factory ProductService() => _singleton;
  ProductService._internal();

  final Box<ProductEntity> _productBox = Hive.box<ProductEntity>(
    AppConstants.favorites,
  );

  Future<void> addProduct(ProductEntity product) async {
    await _productBox.add(product);
  }

  List<ProductEntity> getAllProducts() {
    return _productBox.values.toList();
  }

  ProductEntity? getProduct(int index) {
    return _productBox.getAt(index);
  }

  Future<void> updateProduct(int index, ProductEntity product) async {
    await _productBox.putAt(index, product);
  }

  Future<void> deleteProductById(int id) async {
    final keyToDelete = _productBox.keys.firstWhere(
      (key) => _productBox.get(key)?.id == id,
      orElse: () => null,
    );

    if (keyToDelete != null) {
      await _productBox.delete(keyToDelete);
    }
  }

  bool isProductFavorite(int id) {
    return _productBox.values.any((product) => product.id == id);
  }
}

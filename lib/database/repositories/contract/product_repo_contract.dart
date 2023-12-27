import 'package:shopping_list_with_sqflite_db_december/models/product_model.dart';

abstract class ProductsRepoContract {
  Future<void> addProduct(Product product);
  Future<void> deleteProduct(int id);
  Future<List<Product>> getListProduct();
}

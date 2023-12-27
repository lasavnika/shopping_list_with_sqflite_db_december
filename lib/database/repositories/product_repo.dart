import 'package:shopping_list_with_sqflite_db_december/database/database.dart';
import 'package:shopping_list_with_sqflite_db_december/database/repositories/contract/product_repo_contract.dart';
import 'package:shopping_list_with_sqflite_db_december/models/product_model.dart';

class ProductRepo implements ProductsRepoContract {
  final DatabaseHelper dbHelper = DatabaseHelper.init();

  @override
  Future<void> addProduct(Product product) async {
    final db = dbHelper.database;
    await db.insert('products', product.toJson());
  }

  @override
  Future<void> deleteProduct(int productId) async {
    final db = dbHelper.database;
    await db.delete('products', where: 'id = ?', whereArgs: [productId]);
  }

  @override
  Future<List<Product>> getListProduct() async {
    final db = dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('products');
    return List.generate(maps.length, (i) => Product.fromJson(maps[i]));
  }
}

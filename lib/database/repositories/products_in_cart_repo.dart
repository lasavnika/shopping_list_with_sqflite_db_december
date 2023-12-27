import 'package:shopping_list_with_sqflite_db_december/database/database.dart';
import 'package:shopping_list_with_sqflite_db_december/database/repositories/contract/products_in_cart_repo_contrsct.dart';
import 'package:shopping_list_with_sqflite_db_december/models/productInCart_model.dart';
import 'package:shopping_list_with_sqflite_db_december/models/product_in_cart_dto.dart';
import 'package:shopping_list_with_sqflite_db_december/models/product_model.dart';

class ProductInCartRepo implements ProductInCartRepoContract {
  final DatabaseHelper dbHelper = DatabaseHelper.init();

  @override
  Future<void> addCartToHistory(int userId) async {
    final db = dbHelper.database;
    await db.update('productsInCart', {'isHistory': true},
        where: 'userId = ? and isHistory = ?', whereArgs: [userId, false]);
  }

  @override
  Future<void> addProductInCart(int productId, int userId) async {
    final db = dbHelper.database;
    final productInCart = ProductInCartDTO(
        userId: userId, productId: productId, isHistory: false);
    await db.insert('productsInCart', productInCart.toJson());
  }

  @override
  Future<void> deleteProductFromCart(int id) async {
    final db = dbHelper.database;
    await db.delete('productsInCart', where: 'id = ?', whereArgs: [id]);
  }

  @override
  Future<List<ProductInCartModel>> getProductInCart(
      int userId, bool isHistory) async {
    final db = dbHelper.database;
    final results = await db.rawQuery('''
    SELECT productsInCart.*, products.*
    FROM productsInCart
    LEFT JOIN products ON productsInCart.productId = products.productId
    WHERE userId = ? AND productsInCart.isHistory = ?
  ''', [userId, isHistory ? 1 : 0]);

    return results
        .map((result) => ProductInCartModel.fromJson(result))
        .toList();
  }
}

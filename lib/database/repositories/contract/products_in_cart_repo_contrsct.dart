import 'package:shopping_list_with_sqflite_db_december/models/productInCart_model.dart';
import 'package:shopping_list_with_sqflite_db_december/models/product_model.dart';

abstract class ProductInCartRepoContract {
  Future<void> addProductInCart(int productId, int userId);
  Future<void> deleteProductFromCart(int id);
  Future<void> addCartToHistory(int userId);
  Future<List<ProductInCartModel>> getProductInCart(int userId, bool isHistory);
}

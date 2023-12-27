import 'package:shopping_list_with_sqflite_db_december/mock_data/all_products_data.dart';
import 'package:shopping_list_with_sqflite_db_december/models/product_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static DatabaseHelper? dbHelper;
  late final Database db;

  DatabaseHelper._() {
    initDB();
  }

  factory DatabaseHelper.init() {
    if (dbHelper == null) {
      dbHelper = DatabaseHelper._();
    }
    return dbHelper!;
  }

  Database get database {
    return db;
  }

  final databaseName = 'shop.db';

  String users =
      "CREATE TABLE users(userId INTEGER PRIMARY KEY AUTOINCREMENT, userName TEXT UNIQUE, userPassword TEXT)";
  String products =
      "CREATE TABLE products(productId INTEGER PRIMARY KEY AUTOINCREMENT, productName TEXT, productImage TEXT, productPrice REAL)";
  String productsInCart =
      "CREATE TABLE productsInCart(id INTEGER PRIMARY KEY AUTOINCREMENT, productId INTEGER, userId INTEGER, isHistory INTEGER, FOREIGN KEY(productId) REFERENCES products(productId), FOREIGN KEY(userId) REFERENCES users(userId))";

  Future<void> initDB() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, databaseName);

    db = await openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute(users);
      await db.execute(products);
      await db.execute(productsInCart);
      List<Product> product = Mock.productsData;
      for (Product item in product) {
        await db.insert(products, item.toJson());
      }
    });
  }
}

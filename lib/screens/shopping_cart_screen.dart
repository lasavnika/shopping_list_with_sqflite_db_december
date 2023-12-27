import 'package:flutter/material.dart';
import 'package:shopping_list_with_sqflite_db_december/database/repositories/contract/products_in_cart_repo_contrsct.dart';
import 'package:shopping_list_with_sqflite_db_december/database/repositories/products_in_cart_repo.dart';
import 'package:shopping_list_with_sqflite_db_december/models/productInCart_model.dart';
import 'package:shopping_list_with_sqflite_db_december/models/product_model.dart';
import 'package:shopping_list_with_sqflite_db_december/screens/Auth/login_screen.dart';
import 'package:shopping_list_with_sqflite_db_december/screens/history_screen.dart';

class ShoppingCartScreen extends StatefulWidget {
  const ShoppingCartScreen({
    Key? key,
    required this.userId,
  }) : super(key: key);
  final int userId;

  @override
  State<ShoppingCartScreen> createState() => _ShoppingCartScreenState();
}

class _ShoppingCartScreenState extends State<ShoppingCartScreen> {
  double totalPrice = 0.0;
  final ProductInCartRepoContract productsInCart = ProductInCartRepo();
  List<ProductInCartModel> products = [];

  void _calculateTotalPrice() {
    totalPrice = 0.0;
    for (final product in products) {
      setState(() {
        totalPrice += product.productPrice;
      });
    }
  }

  Future<void> _loadData() async {
    products = await productsInCart.getProductInCart(widget.userId, false);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _loadData().then((_) {
      _calculateTotalPrice();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Shopping Cart',
          ),
          backgroundColor: const Color.fromARGB(255, 181, 63, 140),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    return Dismissible(
                      key: Key(products[index].productId.toString()),
                      direction: DismissDirection.endToStart,
                      onDismissed: (direction) async {
                        await productsInCart
                            .deleteProductFromCart(products[index].id ?? -1);
                        setState(() {
                          products.removeAt(index);
                          _calculateTotalPrice();
                        });
                      },
                      background: Container(
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        color: Colors.red,
                        child: const Icon(Icons.delete, color: Colors.white),
                      ),
                      child: ListTile(
                        title: Text(products[index].productName),
                        subtitle: Text(
                          '\$${products[index].productPrice.toStringAsFixed(2)}',
                        ),
                        leading: Image.asset(products[index].productImage),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total Price:',
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    '\$${totalPrice.toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 20),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      await productsInCart.addCartToHistory(widget.userId);
                      products = [];
                      _calculateTotalPrice();
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => PurchaseHistory(
                            userId: widget.userId,
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      primary: Colors.pink,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Buy Now',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      primary: Colors.pink,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Log out!',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              PurchaseHistory(userId: widget.userId),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      primary: Colors.pink,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'History',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

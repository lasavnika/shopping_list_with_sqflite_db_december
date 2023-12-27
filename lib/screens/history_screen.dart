import 'package:flutter/material.dart';
import 'package:shopping_list_with_sqflite_db_december/database/repositories/contract/products_in_cart_repo_contrsct.dart';
import 'package:shopping_list_with_sqflite_db_december/database/repositories/products_in_cart_repo.dart';
import 'package:shopping_list_with_sqflite_db_december/models/productInCart_model.dart';
import 'package:shopping_list_with_sqflite_db_december/models/product_model.dart';
import 'package:shopping_list_with_sqflite_db_december/screens/Auth/login_screen.dart';

class PurchaseHistory extends StatefulWidget {
  final int userId;
  const PurchaseHistory({
    Key? key,
    required this.userId,
  }) : super(key: key);

  @override
  State<PurchaseHistory> createState() => _PurchaseHistoryState();
}

class _PurchaseHistoryState extends State<PurchaseHistory> {
  final ProductInCartRepoContract productsInHistory = ProductInCartRepo();
  List<ProductInCartModel> products = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    products = await productsInHistory.getProductInCart(widget.userId, true);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 181, 63, 140),
          title: const Text('Purchase History'),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(products[index].productName),
                    subtitle: Text(products[index].productPrice.toString()),
                    leading: Image.asset(
                      products[index].productImage,
                      width: 60,
                      height: 60,
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 40.0),
              child: ElevatedButton(
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
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

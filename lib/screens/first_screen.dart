import 'package:flutter/material.dart';
import 'package:shopping_list_with_sqflite_db_december/database/repositories/contract/product_repo_contract.dart';
import 'package:shopping_list_with_sqflite_db_december/database/repositories/contract/products_in_cart_repo_contrsct.dart';
import 'package:shopping_list_with_sqflite_db_december/database/repositories/product_repo.dart';
import 'package:shopping_list_with_sqflite_db_december/database/repositories/products_in_cart_repo.dart';
import 'package:shopping_list_with_sqflite_db_december/models/product_model.dart';
import 'package:shopping_list_with_sqflite_db_december/screens/shopping_cart_screen.dart';
import 'package:shopping_list_with_sqflite_db_december/screens/widgets/card_widget.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({Key? key, required this.userId}) : super(key: key);
  final int userId;

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  List<Product> products = [];

  final ProductsRepoContract productRepo = ProductRepo();
  final ProductInCartRepoContract pruductsInCart = ProductInCartRepo();

  void addToCart(Product product) async {
    await pruductsInCart.addProductInCart(product.productId, widget.userId);
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    products = await productRepo.getListProduct();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    int totalProducts = products.length;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "MakeUp Shop",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                ),
              ),
              Text(
                'All Products: $totalProducts',
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
          backgroundColor: const Color.fromARGB(255, 181, 63, 140),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 15),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                const Padding(
                  padding: EdgeInsets.only(left: 25, top: 10),
                  child: Text(
                    "The best cosmetics \nfrom top brands!",
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ShoppingCartScreen(
                          userId: widget.userId,
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.shopping_cart),
                  color: Colors.pink,
                ),
              ]),
              const SizedBox(height: 10),
              Expanded(
                child: GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.7,
                  ),
                  itemCount: products.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ProductCard(
                        product: products[index],
                        userId: widget.userId,
                        addToCartCallback: addToCart,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
























// import 'package:flutter/material.dart';
// import 'package:shopping_list_with_sqflite_db_december/mock_data/all_products_data.dart';
// import 'package:shopping_list_with_sqflite_db_december/screens/shopping_cart_screen.dart';
// import 'package:shopping_list_with_sqflite_db_december/screens/widgets/card_widget.dart';

// class FirstScreen extends StatefulWidget {
//   const FirstScreen({Key? key, required this.userId}) : super(key: key);
//   final int userId;

//   @override
//   State<FirstScreen> createState() => _FirstScreenState();
// }

// class _FirstScreenState extends State<FirstScreen> {
//   @override
//   Widget build(BuildContext context) {
//     int totalProducts = Mock.productsData.length;
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           title: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               const Text(
//                 "MakeUp Shop",
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 20,
//                   fontWeight: FontWeight.normal,
//                 ),
//               ),
//               Text(
//                 'All Products: $totalProducts',
//                 style: const TextStyle(
//                   color: Colors.white,
//                   fontSize: 16,
//                 ),
//               ),
//             ],
//           ),
//           backgroundColor: const Color.fromARGB(255, 181, 63, 140),
//         ),
//         body: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 15),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               const SizedBox(height: 15),
//               Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
//                 const Padding(
//                   padding: EdgeInsets.only(left: 25, top: 10),
//                   child: Text(
//                     "The best cosmetics \nfrom top brands!",
//                     style: TextStyle(
//                       fontSize: 24,
//                     ),
//                   ),
//                 ),
//                 IconButton(
//                   onPressed: () {
//                     Navigator.of(context).push(
//                       MaterialPageRoute(
//                           builder: (context) => ShoppingCartScreen(
//                                 userId: widget.userId,
//                               )),
//                     );
//                   },
//                   icon: const Icon(Icons.shopping_cart),
//                   color: Colors.pink,
//                 ),
//               ]),
//               const SizedBox(height: 10),
//               Expanded(
//                 child: GridView.builder(
//                   shrinkWrap: true,
//                   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 2,
//                     childAspectRatio: 0.7,
//                   ),
//                   itemCount: Mock.productsData.length,
//                   itemBuilder: (BuildContext context, int index) {
//                     return Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: ProductCard(
//                         product: Mock.productsData[index],
//                         userId: widget.userId,
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

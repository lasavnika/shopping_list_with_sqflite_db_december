import 'package:flutter/material.dart';
import 'package:shopping_list_with_sqflite_db_december/models/product_model.dart';

class ProductCard extends StatefulWidget {
  final Product product;
  final int userId;
  final Function(Product) addToCartCallback;

  const ProductCard(
      {Key? key,
      required this.product,
      required this.userId,
      required this.addToCartCallback})
      : super(key: key);

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 3.0),
            child: Image.asset(
              widget.product.productImage,
              width: 140,
              height: 140,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            widget.product.productName,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          Text(
            '\$${widget.product.productPrice.toStringAsFixed(2)}',
            style: const TextStyle(color: Colors.grey),
          ),
          const SizedBox(
            height: 3,
          ),
          Expanded(
            child: IconButton(
              onPressed: () {
                widget.addToCartCallback(widget.product);
              },
              icon: const Icon(Icons.shopping_bag_outlined),
            ),
          ),
        ],
      ),
    );
  }
}

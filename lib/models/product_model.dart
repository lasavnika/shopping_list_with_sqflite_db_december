import 'dart:convert';

class Product {
  final int productId;
  final String productName;
  final String productImage;
  final double productPrice;

  Product({
    required this.productId,
    required this.productName,
    required this.productImage,
    required this.productPrice,
  });

  factory Product.fromRawJson(String str) => Product.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        productId: json["productId"],
        productName: json["productName"],
        productImage: json["productImage"],
        productPrice: json["productPrice"],
      );

  Map<String, dynamic> toJson() => {
        //"productId": productId,
        "productName": productName,
        "productImage": productImage,
        "productPrice": productPrice,
      };
}

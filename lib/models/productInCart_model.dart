class ProductInCartModel {
  final int? id;
  // int productId;
  // int userId;
  final int productId;
  final String productName;
  final String productImage;
  final double productPrice;
  final bool isHistory;

  ProductInCartModel({
    required this.productId,
    required this.productName,
    required this.productImage,
    required this.productPrice,
    this.id,
    required this.isHistory,
  });

  Map<String, dynamic> toJson() => {
        "id": id,
        "productId": productId,
        "isHistory": isHistory,
      };

  factory ProductInCartModel.fromJson(Map<String, dynamic> json) =>
      ProductInCartModel(
        id: json["id"],
        productId: json["productId"],
        productName: json["productName"],
        productImage: json["productImage"],
        productPrice: json["productPrice"],
        isHistory: json["isHistory"] == 1 ? true : false,
      );
}

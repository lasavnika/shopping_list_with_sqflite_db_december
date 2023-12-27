// ignore_for_file: public_member_api_docs, sort_constructors_first
class ProductInCartDTO {
  final int userId;
  final int productId;
  final bool isHistory;
  ProductInCartDTO({
    required this.userId,
    required this.productId,
    required this.isHistory,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'userId': userId,
      'productId': productId,
      'isHistory': isHistory,
    };
  }
}

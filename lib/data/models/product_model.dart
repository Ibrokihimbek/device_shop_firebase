class ProductModel {
  int count;
  int price;
  List<dynamic> productImages;
  String categoryId;
  String productId;
  String productName;
  String description;
  String createdAt;
  String currency;

  ProductModel({
    required this.count,
    required this.price,
    required this.productImages,
    required this.categoryId,
    required this.productId,
    required this.productName,
    required this.description,
    required this.createdAt,
    required this.currency,
  });

  factory ProductModel.fromJson(Map<String, dynamic> jsonData) {
    return ProductModel(
      count: jsonData['count'] as int? ?? 0,
      price: jsonData['price'] as int? ?? 0,
      productImages: (jsonData['productImages']  as List<dynamic>? ?? []),
      categoryId: jsonData['categoryId'] as String? ?? '',
      productId: jsonData['productId'] as String? ?? '',
      productName: jsonData['productName'] as String? ?? '',
      description: jsonData['description'] as String? ?? '',
      createdAt: jsonData['createdAt'] as String? ?? '',
      currency: jsonData['currency'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'count': count,
      'price': price,
      'productImages': productImages,
      'categoryId': categoryId,
      'productId': productId,
      'productName': productName,
      'description': description,
      'createdAt': createdAt,
      'currency': currency,
    };
  }

  @override
  String toString() {
    return '''
      count: $count,
      price: $price,
      productImages: $productImages,
      categoryId: $categoryId,
      productId: $productId,
      productName: $productName,
      description: $description,
      createdAt: $createdAt,
      currency: $currency
      ''';
  }
}

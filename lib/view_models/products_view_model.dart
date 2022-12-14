import 'dart:async';

import 'package:device_shop_firebase/data/models/product_model.dart';
import 'package:device_shop_firebase/data/repositories/product_repository.dart';
import 'package:flutter/material.dart';

class ProductViewModel extends ChangeNotifier {
  final ProductRepository productRepository;

  ProductViewModel({required this.productRepository}) {
    listenProducts("");
  }

  late StreamSubscription subscription;

  List<ProductModel> products = [];
  List<ProductModel> productsAdmin = [];

  listenProducts(String categoryId) async {
    subscription = productRepository
        .getProducts(categoryId: categoryId)
        .listen((allProducts) {
          if(categoryId.isEmpty) productsAdmin = allProducts;
      print("ALL PRODUCTS LENGTH:${allProducts.length}");
      products = allProducts;
      notifyListeners();
    });
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }
}

import 'package:device_shop_firebase/data/models/category.dart';
import 'package:device_shop_firebase/data/repositories/categories_repository.dart';
import 'package:flutter/cupertino.dart';

class CategoriesViewModel extends ChangeNotifier {
  final CategoryRepository categoryRepository;

  CategoriesViewModel({required this.categoryRepository}){
    listenCategories();
  }

//  List<CategoryModel> categories = [];

  Stream<List<CategoryModel>> listenCategories() =>
      categoryRepository.getCategories();
}

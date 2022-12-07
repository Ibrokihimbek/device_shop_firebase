import 'package:device_shop_firebase/data/models/category.dart';
import 'package:device_shop_firebase/view_models/categories_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpdateCategoryScreen extends StatefulWidget {
  const UpdateCategoryScreen({Key? key, required this.categoryModel})
      : super(key: key);

  final CategoryModel categoryModel;

  @override
  State<UpdateCategoryScreen> createState() => _UpdateCategoryScreenState();
}

class _UpdateCategoryScreenState extends State<UpdateCategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(" Update Category"),
      ),
      body: Column(
        children: [
          IconButton(
            onPressed: () {
              CategoryModel categoryModel = CategoryModel(
                categoryId: widget.categoryModel.categoryId,
                categoryName: "Muzlat",
                description: widget.categoryModel.description,
                imageUrl: widget.categoryModel.imageUrl,
                createdAt: widget.categoryModel.createdAt,
              );
              Provider.of<CategoriesViewModel>(context, listen: false)
                  .updateCategory(categoryModel);
            },
            icon: const Icon(Icons.edit),
          )
        ],
      ),
    );
  }
}

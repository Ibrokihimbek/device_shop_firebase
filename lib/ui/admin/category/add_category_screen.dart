import 'package:device_shop_firebase/data/models/category.dart';
import 'package:device_shop_firebase/view_models/categories_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddCategoryScreen extends StatefulWidget {
  const AddCategoryScreen({Key? key}) : super(key: key);

  @override
  State<AddCategoryScreen> createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends State<AddCategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(" Add Category"),
      ),
      body: Column(
        children: [
          IconButton(
            onPressed: () {
              CategoryModel categoryModel = CategoryModel(
                categoryId: "",
                categoryName: "Muzlatgichlar",
                description: "Yaxshi",
                imageUrl:
                    "https://freepngimg.com/thumb/refrigerator/5-2-refrigerator-png-picture-thumb.png",
                createdAt: DateTime.now().toString(),
              );

              Provider.of<CategoriesViewModel>(context, listen: false)
                  .addCategory(categoryModel);
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
    );
  }
}

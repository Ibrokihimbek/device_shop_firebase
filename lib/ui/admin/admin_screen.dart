import 'package:device_shop_firebase/ui/admin/category/all_categories_screen.dart';
import 'package:device_shop_firebase/ui/admin/products/all_products_screen.dart';
import 'package:flutter/material.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Admin Page"),
      ),
      body: Column(
        children: [
          ListTile(
            title: Text("Products"),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AllProductsScreen()));
            },
          ),
          ListTile(
            title: Text("Categories"),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AllCategoriesScreen()));
            },
          ),
        ],
      ),
    );
  }
}

import 'package:device_shop_firebase/data/models/user_model.dart';
import 'package:device_shop_firebase/ui/tab_box/card/card_page.dart';
import 'package:device_shop_firebase/ui/tab_box/hom_page/home_page.dart';
import 'package:device_shop_firebase/ui/tab_box/profile/profile_page.dart';
import 'package:device_shop_firebase/view_models/profile_view_model.dart';
import 'package:device_shop_firebase/view_models/tab_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class TabBox extends StatefulWidget {
  const TabBox({Key? key}) : super(key: key);

  @override
  State<TabBox> createState() => _TabBoxState();
}

class _TabBoxState extends State<TabBox> {
  List<Widget> screens = [];

  @override
  void initState() {
    screens.add(HomePage());
    screens.add(CardPage());
    screens.add(ProfilePage());
    _printFCMToken();
    super.initState();
  }

  _printFCMToken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    if (!mounted) return;
    UserModel? userModel =
        Provider.of<ProfileViewModel>(context, listen: false).userModel;
    if (userModel != null) {
      Provider.of<ProfileViewModel>(context, listen: false)
          .updateFCMToken(token ?? "", userModel.userId);
    }

    print("FCM TOKEN:$token");
  }

  @override
  Widget build(BuildContext context) {
    var index = context.watch<TabViewModel>().activePageIndex;
    print(DateTime.now().toString());
    return Scaffold(
      body: screens[index],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) => Provider.of<TabViewModel>(context, listen: false)
            .changePageIndex(value),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ""),
        ],
      ),
    );
  }
}

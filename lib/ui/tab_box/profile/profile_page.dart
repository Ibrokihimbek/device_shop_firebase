import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("Home"),),body: Column(
      children: [
        Text("${FirebaseAuth.instance.currentUser?.email.toString()}"),
        Text("${FirebaseAuth.instance.currentUser?.uid.toString()}"),
        Text("${FirebaseAuth.instance.currentUser?.displayName.toString()}"),
      ],
    ),);
  }
}

import 'dart:io';

import 'package:device_shop_firebase/data/services/file_uploader.dart';
import 'package:device_shop_firebase/ui/admin/admin_screen.dart';
import 'package:device_shop_firebase/utils/icon.dart';
import 'package:device_shop_firebase/view_models/categories_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ImagePicker _picker = ImagePicker();
  XFile? _image;
  String imageUrl = "";
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AdminScreen()));
              },
              icon: const Icon(Icons.settings))
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("${FirebaseAuth.instance.currentUser?.email.toString()}"),
          Text("${FirebaseAuth.instance.currentUser?.uid.toString()}"),
          Text("${FirebaseAuth.instance.currentUser?.displayName.toString()}"),
          isLoading?CircularProgressIndicator():SizedBox(),

          Container(
            decoration: BoxDecoration(shape: BoxShape.circle),
            width: 100,
            height: 100,
            child: imageUrl.isEmpty
                ? Image.asset(
                    MyIcons.imageSample,
                    fit: BoxFit.cover,
                  )
                : Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                  ),
          ),
          ElevatedButton(
            onPressed: () {
              _showPicker(context);
            },
            child: Text("Select Image"),
          )
        ],
      ),
    );
  }



  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: const Icon(Icons.photo_library),
                    title: const Text("Gallery"),
                    onTap: () {
                      _getFromGallery();
                      Navigator.of(context).pop();
                    }),
                ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title: const Text('Camera'),
                  onTap: () {
                    _getFromCamera();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });
  }

  _getFromGallery() async {
    XFile? pickedFile = await _picker.pickImage(
      maxWidth: 1000,
      maxHeight: 1000,
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      if (!mounted) return;
      setState(() {
        isLoading  = true;
      });
      imageUrl = await FileUploader.imageUploader(pickedFile);
      setState(() {
        isLoading  = false;
        _image = pickedFile;
      });
    }
  }

  _getFromCamera() async {
    XFile? pickedFile = await _picker.pickImage(
      maxWidth: 1920,
      maxHeight: 2000,
      source: ImageSource.camera,
    );
    if (pickedFile != null) {
      if (!mounted) return;
      imageUrl = await  FileUploader.imageUploader(pickedFile);
      setState(() {
        _image = pickedFile;
      });
    }
  }
}

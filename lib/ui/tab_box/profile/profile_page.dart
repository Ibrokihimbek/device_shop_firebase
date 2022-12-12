import 'dart:io';

import 'package:device_shop_firebase/data/services/file_uploader.dart';
import 'package:device_shop_firebase/ui/admin/admin_screen.dart';
import 'package:device_shop_firebase/utils/icon.dart';
import 'package:device_shop_firebase/view_models/categories_view_model.dart';
import 'package:device_shop_firebase/view_models/profile_view_model.dart';
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
      body: Consumer<ProfileViewModel>(
        builder: (context, profileViewModel, child) {
          return profileViewModel.user != null
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextButton(onPressed: (){
                      FirebaseAuth.instance.signOut();
                    }, child: Text("Log Out")),
                    Text(profileViewModel.user!.email.toString()),
                    Text(profileViewModel.user!.uid.toString()),
                    Text(profileViewModel.user!.displayName.toString()),
                    isLoading ? CircularProgressIndicator() : SizedBox(),
                    Container(
                      decoration: BoxDecoration(shape: BoxShape.circle),
                      width: 100,
                      height: 100,
                      child: profileViewModel.user!.photoURL == null
                          ? Image.asset(
                              MyIcons.imageSample,
                              fit: BoxFit.cover,
                            )
                          : Image.network(
                              profileViewModel.user!.photoURL!,
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
                )
              : Center(child: CircularProgressIndicator());
        },
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
        isLoading = true;
      });
      if (!mounted) return;
      imageUrl = await FileUploader.imageUploader(pickedFile);
      if (!mounted) return;
      Provider.of<ProfileViewModel>(context, listen: false)
          .updatePhoto(imageUrl);
      setState(() {
        isLoading = false;
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
      imageUrl = await FileUploader.imageUploader(pickedFile);
      if (!mounted) return;
      Provider.of<ProfileViewModel>(context, listen: false).updatePhoto(imageUrl);
      setState(() {
        _image = pickedFile;
      });
    }
  }
}

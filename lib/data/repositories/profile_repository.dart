import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_shop_firebase/data/models/user_model.dart';
import 'package:device_shop_firebase/utils/my_utils.dart';

class ProfileRepository {
  final FirebaseFirestore _firestore;

  ProfileRepository({required FirebaseFirestore firebaseFirestore})
      : _firestore = firebaseFirestore;

  Future<void> addUser({required UserModel userModel}) async {
    try {
      DocumentReference newUser =
          await _firestore.collection("users").add(userModel.toJson());
      await _firestore
          .collection("users")
          .doc(newUser.id)
          .update({"docId": newUser.id});
      MyUtils.getMyToast(message: "User muvaffaqiyatli qo'shildi!");
    } on FirebaseException catch (er) {
      MyUtils.getMyToast(message: er.message.toString());
    }
  }

  Future<void> updateUserFCMToken(
      {required String fcmToken, required String docId}) async {
    try {
      await _firestore.collection("users").doc(docId).update({
        "fcm_token": fcmToken,
      });
    } on FirebaseException catch (er) {
      MyUtils.getMyToast(message: er.message.toString());
    }
  }

  Future<UserModel?> getSingleUser({required String userId}) async {
    UserModel? userModel;
    _firestore
        .collection("users")
        .where("userId", isEqualTo: userId)
        .snapshots()
        .map(
          (event1) => event1.docs.map((doc) => UserModel.fromJson(doc.data())).toList(),
        )
        .listen((event) {
      userModel = event.first;
    });
    return userModel;
  }
}

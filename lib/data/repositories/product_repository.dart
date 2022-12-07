import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_shop_firebase/data/models/product_model.dart';
import 'package:device_shop_firebase/utils/my_utils.dart';

class ProductRepository {
  final FirebaseFirestore _firestore;

  ProductRepository({required FirebaseFirestore firebaseFirestore})
      : _firestore = firebaseFirestore;

  Future<void> addProduct({required ProductModel productModel}) async {
    try {
      DocumentReference newProduct =
          await _firestore.collection("products").add(productModel.toJson());
      await _firestore.collection("products").doc(newProduct.id).update({
        "productId": newProduct.id,
      });
      MyUtils.getMyToast(message: "Mahsulot muvaffaqiyatli qo'shildi!");
    } on FirebaseException catch (er) {
      MyUtils.getMyToast(message: er.message.toString());
    }
  }

  Future<void> deleteProduct({required String docId}) async {
    try {
      await _firestore.collection("products").doc(docId).delete();

      MyUtils.getMyToast(message: "Mahsulot muvaffaqiyatli o'chirildi!");
    } on FirebaseException catch (er) {
      MyUtils.getMyToast(message: er.message.toString());
    }
  }

  Future<void> updateProduct({required ProductModel productModel}) async {
    try {
      await _firestore
          .collection("products")
          .doc(productModel.productId)
          .update(productModel.toJson());

      MyUtils.getMyToast(message: "Mahsulot muvaffaqiyatli yangilandi!");
    } on FirebaseException catch (er) {
      MyUtils.getMyToast(message: er.message.toString());
    }
  }

  Stream<List<ProductModel>> getProducts() =>
      _firestore.collection("products").snapshots().map(
            (querySnapshot) => querySnapshot.docs
                .map((doc) => ProductModel.fromJson(doc.data()))
                .toList(),
          );
}

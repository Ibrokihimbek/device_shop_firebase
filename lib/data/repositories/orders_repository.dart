import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_shop_firebase/data/models/category.dart';
import 'package:device_shop_firebase/data/models/order_model.dart';
import 'package:device_shop_firebase/data/models/product_model.dart';
import 'package:device_shop_firebase/utils/my_utils.dart';

class OrdersRepository {
  final FirebaseFirestore _firestore;

  OrdersRepository({required FirebaseFirestore firebaseFirestore})
      : _firestore = firebaseFirestore;

  Future<void> addOrder({required OrderModel orderModel}) async {
    try {
      DocumentReference newOrder =
          await _firestore.collection("orders").add(orderModel.toJson());
      await _firestore.collection("orders").doc(newOrder.id).update({
        "orderId": newOrder.id,
      });

      MyUtils.getMyToast(message: "Buyurtma muvaffaqiyatli qo'shildi!");
    } on FirebaseException catch (er) {
      MyUtils.getMyToast(message: er.message.toString());
    }
  }

  Future<void> deleteOrderById({required String docId}) async {
    try {
      await _firestore.collection("orders").doc(docId).delete();
      MyUtils.getMyToast(message: "Order muvaffaqiyatli o'chirildi!");
    } on FirebaseException catch (er) {
      MyUtils.getMyToast(message: er.message.toString());
    }
  }

  Future<void> updateOrder({required OrderModel orderModel}) async {
    try {
      await _firestore
          .collection("orders")
          .doc(orderModel.orderId)
          .update(orderModel.toJson());

      MyUtils.getMyToast(message: "Buyurtma muvaffaqiyatli yangilandi!");
    } on FirebaseException catch (er) {
      MyUtils.getMyToast(message: er.message.toString());
    }
  }

  Stream<List<OrderModel>> getOrders() =>
      _firestore.collection("orders").snapshots().map(
            (event1) => event1.docs
                .map((doc) => OrderModel.fromJson(doc.data()))
                .toList(),
          );

  Stream<List<OrderModel>> getOrdersByUserId({required String userId}) =>
      _firestore
          .collection("orders")
          .where("userId", isEqualTo: userId)
          .snapshots()
          .map(
            (event1) => event1.docs
                .map((doc) => OrderModel.fromJson(doc.data()))
                .toList(),
          );

  Future<ProductModel> getSingleProductById({required String docId}) async {
    var data = await _firestore.collection("products").doc(docId).get();
    return ProductModel.fromJson(data.data() as Map<String, dynamic>);
  }
}

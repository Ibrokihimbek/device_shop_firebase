import 'package:device_shop_firebase/utils/my_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AuthRepository {
  final FirebaseAuth _auth;

  AuthRepository({required FirebaseAuth firebaseAuth}) : _auth = firebaseAuth;

  Future<void> signUp({
    required String password,
    required String email,
  }) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (error) {
      MyUtils.getMyToast(message: error.message.toString());
    }
  }

  Future<void> signIn({
    required String password,
    required String email,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (error) {
      MyUtils.getMyToast(message: error.message.toString());
    }
  }

  Stream<User?> authState() async* {
    yield* _auth.authStateChanges();
  }
}

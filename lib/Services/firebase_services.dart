import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseService {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseStorage _storage = FirebaseStorage.instance;
  FirebaseFirestore _db = FirebaseFirestore.instance;

  FirebaseService();

  Future<bool> loginUser(
      {required String email, required String password}) async {
    UserCredential _userCredential = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    if (_userCredential.user != null) {
      return true;
    } else {
      return false;
    }
  }
}

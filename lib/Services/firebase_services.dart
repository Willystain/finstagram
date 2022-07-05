import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;

class FirebaseService with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  String userCollection = 'users';
  Map? currentuser;

  Future<bool> loginUser(
      {required String email,
      required String password,
      required BuildContext context}) async {
    UserCredential _userCredential = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    try {
      if (_userCredential.user != null) {
        currentuser = await getUserData(uid: _userCredential.user!.uid);
        Navigator.pushNamed(context, 'homepage');
        notifyListeners();
        return true;
      }
    } catch (e) {
      notifyListeners();
      print(e);
    }
    return false;
  }

  Future<bool> registerUser(
      {required String email,
      required String password,
      required String name,
      required File image}) async {
    try {
      UserCredential _userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      String _userId = _userCredential.user!.uid;
      String _fileName = Timestamp.now().millisecondsSinceEpoch.toString() +
          p.extension(image.path);
      UploadTask _task =
          _storage.ref('images/$_userId/$_fileName').putFile(image);
      return _task.then((_snapshot) async {
        String _downloadUrl = await _snapshot.ref.getDownloadURL();
        await _db.collection(userCollection).doc(_userId).set({
          'name': name,
          'email': email,
          'image': _downloadUrl,
        });
        print('chamou');
        notifyListeners();

        return true;
      });
    } catch (e) {
      print(e);

      return false;
    }
  }

  Future<Map> getUserData({required String uid}) async {
    DocumentSnapshot _doc = await _db.collection(userCollection).doc(uid).get();
    return _doc.data() as Map;
  }

  void createPost(
      {required String postText,
      required String userName,
      required String profilePic}) async {
    await _db.collection('posts').add({
      'userId': _auth.currentUser!.uid,
      'postText': postText,
      'userName': userName,
      'pofPic': profilePic,
    });
  }

  Stream<QuerySnapshot> getLatestPost() {
    return _db.collection('posts').snapshots();
  }
}

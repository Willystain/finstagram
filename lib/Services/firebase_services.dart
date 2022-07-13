import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finstagram/Services/postNotifier.dart';
import 'package:finstagram/models/personmodel.dart' as model;
import 'package:finstagram/models/post.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;

class FirebaseService with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  final CollectionReference brewCollection =
      FirebaseFirestore.instance.collection('posts');

  String userCollection = 'users';

  Map? currentuser;

  Future<model.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;
    DocumentSnapshot documentSnapshot =
        await _db.collection('users').doc(currentUser.uid).get();
    return model.User.fromSnap(documentSnapshot);
  }

  Future<bool> loginUser(
      {required String email,
      required String password,
      required BuildContext context}) async {
    UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    try {
      if (userCredential.user != null) {
        currentuser = await getUserData(uid: userCredential.user!.uid);
        Navigator.pushNamed(context, 'homepage');
        notifyListeners();
        return true;
      }
    } catch (e) {
      notifyListeners();
    }
    return false;
  }

  Future<bool> registerUser(
      {required String email,
      required String password,
      required String name,
      required File image}) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      String userId = userCredential.user!.uid;
      String fileName = Timestamp.now().millisecondsSinceEpoch.toString() +
          p.extension(image.path);
      UploadTask task = _storage.ref('images/$userId/$fileName').putFile(image);
      return task.then((snapshot) async {
        String downloadUrl = await snapshot.ref.getDownloadURL();

        model.User newuser = await model.User(
          email: email,
          name: name,
          photoUrl: downloadUrl,
          uid: userCredential.user!.uid,
        );

        await _db.collection('users').doc(userId).set(newuser.toJson());

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
      required String profilePic,
      required String postFile,
      required String postId}) async {
    await _db.collection('posts').add({
      'userId': _auth.currentUser!.uid,
      'postText': postText,
      'userName': userName,
      'pofPic': profilePic,
      'postFile': postFile,
      'postId': postId,
    });
  }

  Stream<QuerySnapshot>? get posts {
    return brewCollection.snapshots();
  }

  Stream<QuerySnapshot> getLatestPost() {
    return _db.collection('posts').snapshots();
  }

  Stream<Post> getPostStream() async* {
    DocumentReference<Map<String, dynamic>> newPostStream =
        _db.collection('posts').doc();
    print(newPostStream);
    print('aaa');
  }

  Future<void> deletePost(String postId) async {
    _db
        .collection('posts')
        .doc(postId)
        .delete()
        .then((value) => (print('deleted')))
        .catchError((error) => print(error));

    notifyListeners();
  }
}

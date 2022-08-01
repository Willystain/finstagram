import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:finstagram/models/personmodel.dart' as model;
import 'package:finstagram/models/post.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;

class FirebaseService with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore db = FirebaseFirestore.instance;

  final CollectionReference brewCollection =
      FirebaseFirestore.instance.collection('posts');
  String userCollection = 'users';
  Map? currentuser;
  Future<model.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;
    DocumentSnapshot documentSnapshot =
        await db.collection('users').doc(currentUser.uid).get();
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
        await db.collection('users').doc(userId).set(newuser.toJson());
        notifyListeners();
        return true;
      });
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<Map> getUserData({required String uid}) async {
    DocumentSnapshot _doc = await db.collection(userCollection).doc(uid).get();
    return _doc.data() as Map;
  }

  Future<void> createPost3(
      {map = Map<String, dynamic>, postId = String}) async {
    final path = 'posts/$postId';
    final docRef = db.doc(path);
    await docRef.set(map);
  }

  Future<List<Post>> postStream() async {
    var ref = db.collection('posts');
    var snapshot = await ref.get();
    var snap = snapshot;
    var posts = snap.docs.map((e) => Post.fromSnap(e));
    return posts.toList();
  }

  // Future<List<Post>> fillteredList(bool filter) async {
  //   var ref = db.collection('posts');
  //   var snapshot = await ref.get();
  //   var data = snapshot.docs
  //       .where((element) => element['check'] == filter)
  //       .map((e) => e.data());
  //   var posts = data.map((d) => Post.fromMap(d));
  //   return posts.toList();
  // }

  Stream<QuerySnapshot> getLatestPost() {
    return db.collection('posts').snapshots();
  }

  Future<void> deletePost(String postId) async {
    db
        .collection('posts')
        .doc(postId)
        .delete()
        .then((value) => (print('deleted')))
        .catchError((error) => print("erro"));
    notifyListeners();
  }

  updatePost(String postId) {
    db.collection('posts').doc(postId).update({'postText': "trocou"});

    notifyListeners();
  }

  comentar({postId: String, comentario: String}) {
    db.collection('posts').doc(postId).set(postId);

    notifyListeners();
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  String postId = '';
  String postText = '';
  String username = '';
  bool check = false;
  DocumentReference docRef;

  Post(
      {required this.postId,
      required this.postText,
      required this.username,
      required this.docRef,
      this.check = false});

//RECEBE O SNAPSHOT E RETORNA ELE EM UM OBJETO DO TIPO POST
  static Post fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Post(
        postId: snap.id,
        postText: snapshot["postText"],
        username: snapshot["userName"],
        docRef: snap.reference);
  }

  factory Post.fromDocument(DocumentSnapshot snap) {
    return Post(
        postId: snap['postId'],
        postText: snap["postText"],
        username: snap["userName"],
        docRef: snap['docRef']);
  }

  save() {
    if (docRef == null) {
    } else {
      docRef.update({postText: 'postText'});
    }
  }

  // Post.fromMap(Map<String, dynamic> data) {
  //   postText = data['postText'];
  //   postId = data['postId'];
  //   check = data['check'];
  //   docRef = data['doc'];
  // }
}

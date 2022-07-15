import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  String postId = '';
  String postText = '';
  String username = '';

  Post({required this.postId, required this.postText, required this.username});

  Post.fromMap(Map<String, dynamic> data) {
    postId = data['postId'];
    postText = data['postText'];
  }
//RECEBE O SNAPSHOT E RETORNA ELE EM UM OBJETO DO TIPO POST
  static Post fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Post(
      postId: snapshot["postID"],
      postText: snapshot["postText"],
      username: snapshot["userName"],
    );
  }

  Map<String, dynamic> toJson() => {
        'postId': postId,
        'postText': postText,
        'username': username,
      };
}

import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  String postId = '';
  String postText = '';
  String username = '';

  Post();

  Post.fromMap(Map<String, dynamic> data) {
    postId = data['postId'];
    postText = data['postText'];
  }

  Map<String, dynamic> toMap() {
    return {
      'postId': postId,
      'postText': postText,
    };
  }
}

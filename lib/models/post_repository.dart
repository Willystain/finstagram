// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:finstagram/models/post.dart';
import 'package:finstagram/models/post_reporsitory_interface.dart';

class PostRepository implements IPostRepository {
  final FirebaseFirestore firestore;

  PostRepository(
    this.firestore,
  );

  @override
  Stream<List<Post>> getPosts() {
    return firestore.collection("posts").snapshots().map((query) {
      return query.docs.map((e) {
        return Post.fromDocument(e);
      }).toList();
    });
  }
}

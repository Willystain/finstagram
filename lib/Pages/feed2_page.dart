import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finstagram/Services/firebase_services.dart';
import 'package:finstagram/models/post.dart';
import 'package:flutter/material.dart';

class PostScreen2 extends StatefulWidget {
  @override
  State<PostScreen2> createState() => _PostScreen2State();
}

class _PostScreen2State extends State<PostScreen2> {
  @override
  void initState() {
    var data = FirebaseService().postStream();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Post>>(
      future: FirebaseService().postStream(),
      builder: (
        context,
        snapshot,
      ) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text(snapshot.error.toString()),
          );
        } else if (snapshot.hasData) {
          var posts = snapshot.data!;

          return ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, int index) {
                Post currentPost = posts[index];
                return ListTile(
                  leading: Text(currentPost.postText.toString()),
                  trailing: IconButton(
                    onPressed: () {
                      FirebaseService().deletePost(currentPost.postId);
                      setState(() {});
                    },
                    icon: Icon(Icons.delete),
                  ),
                );
              });
        } else {
          return const Text('No topics found in Firestore. Check database');
        }
      },
    );
  }
}

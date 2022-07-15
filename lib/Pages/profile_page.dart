import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finstagram/Services/firebase_services.dart';
import 'package:flutter/material.dart';

import '../models/post.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: RefreshIndicator(
            onRefresh: () async {
              setState(() {});
            },
            child: getPosts()));
  }

  Widget getPosts() {
    CollectionReference postRef =
        FirebaseFirestore.instance.collection('posts');
    return FutureBuilder<QuerySnapshot?>(
      future: postRef.get(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, i) {
              Post novoPost = Post(
                postId: snapshot.data!.docs[i]['postId'],
                postText: snapshot.data!.docs[i]['postText'],
                username: snapshot.data!.docs[i]['userName'],
              );

              return Column(
                children: [
                  ListTile(
                    leading: Text(novoPost.username),
                  )
                ],
              );
            },
          );
        }
        if (snapshot.hasError) {
          Text('erro');
        } else {
          return CircularProgressIndicator();
        }
        return Container();
      },
    );
  }
}

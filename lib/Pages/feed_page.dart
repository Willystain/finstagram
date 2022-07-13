import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finstagram/Services/firebase_services.dart';
import 'package:finstagram/Services/postNotifier.dart';
import 'package:finstagram/Widgets/deletePost.dart';
import 'package:finstagram/Widgets/postsCount.dart';
import 'package:finstagram/models/post.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({Key? key}) : super(key: key);

  @override
  State<FeedPage> createState() => _FeedPageState();
}

List count = [];

class _FeedPageState extends State<FeedPage> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<QuerySnapshot?>.value(
      value: FirebaseService().posts,
      initialData: null,
      child: Column(
        children: [
          const Card(
            child: PostCount(),
          ),
          Expanded(
            child: Container(
              child: _postListView(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _postListView(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseService().getLatestPost(),
        builder:
            (BuildContext context, AsyncSnapshot<QuerySnapshot> _snapshot) {
          if (_snapshot.hasData) {
            List _post = _snapshot.data!.docs.map((e) => e.data()).toList();

            return ListView.builder(
              itemCount: _post.length,
              itemBuilder: (BuildContext context, int index) {
                Map post = _post[index];

                var postId = _snapshot.data!.docs[index].id;

                return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Card(
                        child: Column(
                          children: [
                            ListTile(
                              leading: CircleAvatar(
                                backgroundImage:
                                    NetworkImage(_post[index]['pofPic']),
                              ),
                              title: Text(_post[index]['userName'],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 18)),
                              subtitle: Text(
                                _post[index]['postText'],
                              ),
                            ),
                            Row(
                              children: [
                                Container(
                                  height: 150,
                                  width: 150,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          _post[index]['postFile']),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    print(postId);
                                    FirebaseService().deletePost(postId);
                                  },
                                  icon: const Icon(Icons.delete),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ]);
              },
            );
          } else {
            return CircularProgressIndicator();
          }
        });
  }
}

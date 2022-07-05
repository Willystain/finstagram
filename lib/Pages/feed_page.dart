import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finstagram/Services/firebase_services.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({Key? key}) : super(key: key);

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  @override
  Widget build(BuildContext context) {
    var firebaseProvider = Provider.of<FirebaseService>(context);

    return Container(
      child: _postListView(context),
    );
  }

  Widget _postListView(BuildContext context) {
    final firebaseProvider = Provider.of<FirebaseService>(context);
    return StreamBuilder<QuerySnapshot>(
        stream: firebaseProvider.getLatestPost(),
        builder:
            (BuildContext context, AsyncSnapshot<QuerySnapshot> _snapshot) {
          if (_snapshot.hasData) {
            List _post = _snapshot.data!.docs.map((e) => e.data()).toList();
            return ListView.builder(
              itemCount: _post.length,
              itemBuilder: (BuildContext context, int index) {
                Map post = _post[index];
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(_post[index]['pofPic']),
                    ),
                    title: Text(_post[index]['userName'],
                        style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 18)),
                    subtitle: Text(
                      _post[index]['postText'],
                    ),
                  ),
                );
              },
            );
          } else {
            return CircularProgressIndicator();
          }
        });
  }
}

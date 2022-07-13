import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PostCount extends StatefulWidget {
  const PostCount({Key? key}) : super(key: key);

  @override
  State<PostCount> createState() => _PostCountState();
}

class _PostCountState extends State<PostCount> {
  @override
  Widget build(BuildContext context) {
    final posts = Provider.of<QuerySnapshot<Object?>?>(context);
    return posts != null
        ? Container(
            child: Text(posts.docs.length.toString()),
          )
        : CircularProgressIndicator();
  }
}

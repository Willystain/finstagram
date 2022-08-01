import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finstagram/Pages/feed2_filtered.dart';
import 'package:finstagram/Pages/feed2_page.dart';
import 'package:finstagram/Pages/postDetail.dart';
import 'package:finstagram/Services/firebase_services.dart';
import 'package:finstagram/Widgets/postsCount.dart';
import 'package:finstagram/models/post.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({Key? key}) : super(key: key);

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  var checks;
  @override
  Widget build(BuildContext context) {
    return (Column(
      children: [
        Checkbox(
            value: false,
            onChanged: (value) {
              checks = value;
            }),
        Expanded(
          child: Container(
            child: _postListView(context),
          ),
        ),
      ],
    ));
  }

  Widget _postListView(BuildContext context) {
    return PostFilter(check: checks);
  }
}

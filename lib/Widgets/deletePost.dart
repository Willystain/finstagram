import 'package:finstagram/Services/firebase_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../Services/postNotifier.dart';

class DeletePost extends StatefulWidget {
  const DeletePost({Key? key}) : super(key: key);

  @override
  State<DeletePost> createState() => _DeletePostState();
}

class _DeletePostState extends State<DeletePost> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {},
      icon: const Icon(Icons.delete),
    );
  }
}

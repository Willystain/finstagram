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
    final firebaseProvider = Provider.of<FirebaseService>(context);
    return Container(
      child: Text(firebaseProvider.currentuser!.entries.first.value),
    );
  }
}

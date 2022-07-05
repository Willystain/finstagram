import 'dart:io';

import 'package:finstagram/Services/firebase_services.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class NewPostPage extends StatefulWidget {
  const NewPostPage({Key? key}) : super(key: key);

  @override
  State<NewPostPage> createState() => _NewPostPageState();
}

String? _name;

final _formKey = GlobalKey<FormState>();

class _NewPostPageState extends State<NewPostPage> {
  @override
  Widget build(BuildContext context) {
    var firebaseProvider = Provider.of<FirebaseService>(context);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Create Post',
                  style: TextStyle(fontSize: 50, fontWeight: FontWeight.w500),
                ),
                _registerForm(context: context),
              ],
            ),
          ),
        ),
      ),
    );
  }

//WIDGETS -----------------------------------------------------

  Widget _registerForm({required BuildContext context}) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _postDescription(),
            const SizedBox(
              height: 20,
            ),
            _botao(context: context)
          ],
        ),
      ),
    );
  }

  Widget _postDescription() {
    return TextFormField(
        decoration: const InputDecoration(hintText: "Nome"),
        onSaved: (_value) {
          setState(() {
            _name = _value;
          });
        },
        validator: (_value) => _value!.length > 0 ? null : "enter a name");
  }

  Widget _botao({required BuildContext context}) {
    var firebaseProvider = Provider.of<FirebaseService>(context);
    return Row(
      children: [
        Expanded(
          child: MaterialButton(
            height: 45,
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                firebaseProvider.createPost(
                    postText: _name!,
                    userName: firebaseProvider.currentuser!['name'],
                    profilePic: firebaseProvider.currentuser!['image']);
                Navigator.pop(context);
              }
            },
            child: Text('Post'),
            color: Colors.amber,
          ),
        ),
      ],
    );
  }
}

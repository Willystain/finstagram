import 'dart:io';
import 'package:finstagram/Pages/feed2_page.dart';
import 'package:uuid/uuid.dart';
import 'package:uuid/uuid_util.dart';
import 'package:finstagram/Services/firebase_services.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import '../models/personmodel.dart';

class NewPostPage extends StatefulWidget {
  const NewPostPage({Key? key}) : super(key: key);

  @override
  State<NewPostPage> createState() => _NewPostPageState();
}

String? _name;
User? _user;

final _formKey = GlobalKey<FormState>();

class _NewPostPageState extends State<NewPostPage> {
  @override
  Widget build(BuildContext context) {
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
                // _postImage(),
                _registerForm(context: context),
              ],
            ),
          ),
        ),
      ),
    );
  }

//WIDGETS -----------------------------------------------------

  // Widget _postImage() {
  //   var _imageProvider = _image != null
  //       ? FileImage(_image!)
  //       : Image.network('https://i.pravatar.cc/300').image;
  //   return GestureDetector(
  //     onTap: _getPicture,
  //     child: AspectRatio(
  //       aspectRatio: 487 / 451,
  //       child: Container(
  //         decoration: BoxDecoration(
  //           image: DecorationImage(
  //             fit: BoxFit.cover,
  //             image: NetworkImage('https://i.pravatar.cc/300'),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  // Future _getPicture() async {
  //   FilePicker.platform.pickFiles(type: FileType.image).then((result) {
  //     setState(() {

  //     });
  //   });
  // }

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
              _user = await firebaseProvider.getUserDetails();

              if (_formKey.currentState!.validate()) {
                var v4 = Uuid().v4();
                _formKey.currentState!.save();

                FirebaseService().createPost3(map: {
                  "postText": _name!,
                  "userName": _user!.name,
                  "postId": v4,
                  "userId": _user!.uid,
                  "check": false,
                }, postId: v4);

                setState(() {
                  PostScreen2();
                });
                Navigator.pop(context);
                Navigator.pushNamed(context, 'homepage');
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

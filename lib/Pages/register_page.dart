import 'dart:io';

import 'package:finstagram/Services/firebase_services.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

File? _image;

String? _name, _email, _password;

final _formKey = GlobalKey<FormState>();

class _RegisterPageState extends State<RegisterPage> {
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
                  'Sing Up!',
                  style: TextStyle(fontSize: 50, fontWeight: FontWeight.w500),
                ),
                _profileImage(),
                _registerForm(context: context),
              ],
            ),
          ),
        ),
      ),
    );
  }

//WIDGETS -----------------------------------------------------

  Widget _profileImage() {
    var _imageProvider = _image != null
        ? FileImage(_image!)
        : Image.network('https://i.pravatar.cc/300').image;
    return GestureDetector(
      onTap: _getPicture,
      child: CircleAvatar(
        radius: 80,
        backgroundImage: _imageProvider as ImageProvider,
        backgroundColor: Colors.brown.shade800,
      ),
    );
  }

  Future _getPicture() async {
    FilePicker.platform.pickFiles(type: FileType.image).then((result) {
      setState(() {
        _image = File(result!.files.first.path!);
      });
    });
  }

  Widget _registerForm({required BuildContext context}) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _nameField(),
            const SizedBox(
              height: 20,
            ),
            _emailField(),
            const SizedBox(
              height: 20,
            ),
            _passwordField(),
            const SizedBox(
              height: 40,
            ),
            _botao(context: context)
          ],
        ),
      ),
    );
  }

  Widget _nameField() {
    return TextFormField(
        decoration: const InputDecoration(hintText: "Nome"),
        onSaved: (_value) {
          setState(() {
            _name = _value;
          });
        },
        validator: (_value) => _value!.length > 0 ? null : "enter a name");
  }

  Widget _emailField() {
    return TextFormField(
        decoration: const InputDecoration(hintText: "Email..."),
        onSaved: (_value) {
          setState(() {
            _email = _value;
          });
        },
        validator: (_value) =>
            _value!.length > 0 ? null : "enter a valid e-mail");
  }

  Widget _passwordField() {
    return TextFormField(
        obscureText: true,
        decoration: const InputDecoration(hintText: "Passowrd..."),
        onSaved: (_value) {
          setState(() {
            _password = _value;
          });
        },
        validator: (_value) =>
            _value!.length > 6 ? null : "password must be greater then 6");
  }

  Widget _botao({required BuildContext context}) {
    var firebaseProvider = Provider.of<FirebaseService>(context);
    return Row(
      children: [
        Expanded(
          child: MaterialButton(
            height: 45,
            onPressed: () async {
              if (_formKey.currentState!.validate() && _image != null) {
                _formKey.currentState!.save();
                firebaseProvider.registerUser(
                    email: _email!,
                    password: _password!,
                    name: _name!,
                    image: _image!);
              }
            },
            child: Text('SING UP'),
            color: Colors.amber,
          ),
        ),
      ],
    );
  }
}

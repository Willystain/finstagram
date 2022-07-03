import 'package:finstagram/Services/firebase_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

final _formKey = GlobalKey<FormState>();
String? emailValue;
String? passwordValue;

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Finstagram',
                  style: TextStyle(fontSize: 50),
                ),
                const SizedBox(
                  height: 30,
                ),
                _form(),
                _loginButton(),
                const SizedBox(
                  height: 20,
                ),
                _registerLink(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //WIDGETS --------------------------------------------------------------------------------

  @override
  Widget _form() {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          _emailField(),
          const SizedBox(
            height: 20,
          ),
          _passwordField(),
          // Add TextFormFields and ElevatedButton here.
        ],
      ),
    );
  }

  Widget _emailField() {
    return TextFormField(
      decoration: const InputDecoration(hintText: "Email..."),
      onSaved: (_value) {
        setState(() {
          emailValue = _value;
        });
      },
      validator: (_value) {
        bool result = _value!.contains(RegExp(
            r"^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$"));
        return result ? null : 'email incorreto';
      },
    );
  }

  Widget _passwordField() {
    return TextFormField(
      obscureText: true,
      decoration: const InputDecoration(hintText: "Passowrd..."),
      onSaved: (_value) {
        setState(() {
          passwordValue = _value;
        });
      },
      validator: (_value) =>
          _value!.length > 6 ? null : 'password must be greater than 6',
    );
  }

  Widget _loginButton() {
    return MaterialButton(
      onPressed: loginFunction,
      child: Text('Login'),
    );
  }

  Widget _registerLink() {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, 'register'),
      child: const Text(
        'Sing up right here!',
        style: TextStyle(
            fontSize: 15, color: Colors.blue, fontWeight: FontWeight.w400),
      ),
    );
  }

  void loginFunction() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      FirebaseService().loginUser(email: emailValue!, password: passwordValue!);
      Navigator.pushNamed(context, 'homepage');
    } else {
      print('formulario invalido');
    }
  }
}

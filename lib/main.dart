import 'package:finstagram/Pages/home_page.dart';
import 'package:finstagram/Pages/login_page.dart';
import 'package:finstagram/Pages/register_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Finstagram',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: 'login',
      routes: {
        'register': (context) => const RegisterPage(),
        'login': (context) => const LoginPage(),
        'homepage': (context) => const HomePage(),
      },
      home: const Scaffold(),
    );
  }
}

import 'package:finstagram/Pages/home_page.dart';
import 'package:finstagram/Pages/login_page.dart';
import 'package:finstagram/Pages/register_page.dart';
import 'package:flutter/material.dart';

void main() {
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
      initialRoute: 'homepage',
      routes: {
        'register': (context) => const RegisterPage(),
        'login': (context) => const LoginPage(),
        'homepage': (context) => const HomePage(),
      },
      home: const Scaffold(),
    );
  }
}

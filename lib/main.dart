import 'package:finstagram/Pages/home_page.dart';
import 'package:finstagram/Pages/login_page.dart';
import 'package:finstagram/Pages/newPost_page.dart';
import 'package:finstagram/Pages/postDetail.dart';
import 'package:finstagram/Pages/register_page.dart';
import 'package:finstagram/Services/firebase_services.dart';

import 'package:finstagram/models/post.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

void main() async {
  Provider.debugCheckInvalidValueType = null;
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MultiProvider(
      providers: [
        Provider<FirebaseService>(
          create: (context) => FirebaseService(),
        ),
      ],
      child: const MyApp(),
    ),
  );
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
        'register': (context) => RegisterPage(),
        'login': (context) => LoginPage(),
        'homepage': (context) => HomePage(),
        'newPostpage': (context) => NewPostPage(),
      },
      home: const Scaffold(),
    );
  }
}

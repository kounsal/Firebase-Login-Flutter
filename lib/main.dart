import 'package:firebase_core/firebase_core.dart';

import './pages/homepage.dart';
import './pages/loginpage.dart';
import 'package:flutter/material.dart';

Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Myapp());
}

class Myapp extends StatefulWidget {
  @override
  State<Myapp> createState() => _MyappState();
}

class _MyappState extends State<Myapp> {
  bool _isLogin = false;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.from(
        colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.green, backgroundColor: Colors.white),
      ),
      home: _isLogin ? const Homepage() : const LoginPage(),
    );
  }
}

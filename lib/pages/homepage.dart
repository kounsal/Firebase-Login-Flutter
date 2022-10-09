import 'package:fire_login/pages/loginpage.dart';

import '../services/auth_service.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  AuthService authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("homepage"),
      ),
      body: Center(
        child: MaterialButton(
          onPressed: () {
            authService.signout();
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const LoginPage()),
                (route) => false);
          },
          child: const Text("Logout"),
          color: Colors.green,
        ),
      ),
    );
  }
}

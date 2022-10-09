import 'package:fire_login/services/auth_service.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import './registerpage.dart';
import './homepage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  String password = "";
  bool _isloading = false;
  String email = "";
  AuthService authService = AuthService();
  final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _isloading
            ? const CircularProgressIndicator(
                color: Colors.amber,
              )
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Form(
                    key: formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Login Now",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 20),
                        emailfield(),
                        const SizedBox(height: 20),
                        passfield(),
                        const SizedBox(height: 20),
                        loginButton(),
                        const SizedBox(height: 2),
                        Text.rich(
                          TextSpan(text: "Don't have an account?", children: [
                            TextSpan(
                                text: "Register here",
                                style: const TextStyle(
                                  color: Colors.black,
                                  decoration: TextDecoration.underline,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const RegisterPage(),
                                      ),
                                    );
                                  })
                          ]),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }

  Widget passfield() {
    return TextFormField(
      decoration: const InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: Colors.green),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: Colors.red),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: Colors.green),
        ),
        labelText: "Password",
        hintText: "Password",
      ),
      obscureText: true,
      onChanged: (value) {
        password = value;
      },
      validator: (value) {
        if (value!.length < 6) {
          return "Password must be atleast 6 characters";
        } else {
          return null;
        }
      },
    );
  }

  Widget emailfield() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: "Email",
        hintText: "abc@xyz.com",
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: Colors.green),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: Colors.red),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: Colors.green),
        ),
      ),
      onChanged: (value) {
        email = value;
      },
      validator: (value) {
        if (!value!.contains("@")) {
          return "Password must be atleast 6 characters";
        } else {
          return null;
        }
      },
    );
  }

  Widget loginButton() {
    return MaterialButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      onPressed: () {
        login();
      },
      child: const Text("Login"),
      minWidth: 100,
      color: Colors.green,
    );
  }

  login() async {
    if (formkey.currentState!.validate()) {
      setState(() {
        _isloading = true;
      });
      await authService
          .loginUserwithEmaiandPassword(email, password)
          .then((value) async {
        if (value == true) {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => Homepage()),
              (route) => false);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              value,
              style: TextStyle(fontSize: 15),
            ),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 2),
            action: SnackBarAction(
              label: "ok",
              onPressed: () {},
              textColor: Colors.white,
            ),
          ));
          setState(() {
            _isloading = false;
          });
        }
      });
    }
  }
}

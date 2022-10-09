import 'package:fire_login/pages/loginpage.dart';
import 'package:fire_login/services/auth_service.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import './homepage.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String password = "";
  bool _isloading = false;
  String email = "";
  String fullname = "";

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
                          "Register Now",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 20),
                        namefield(),
                        const SizedBox(height: 20),
                        emailfield(),
                        const SizedBox(height: 20),
                        passfield(),
                        const SizedBox(height: 20),
                        loginButton(),
                        Text.rich(
                          TextSpan(text: "Have an account? ", children: [
                            TextSpan(
                                text: "Login Here",
                                style: const TextStyle(
                                  color: Colors.black,
                                  decoration: TextDecoration.underline,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const LoginPage(),
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

  Widget namefield() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: "Name",
        hintText: "Full Name",
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
        fullname = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          return "Enter Valid Name";
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
        register();
      },
      child: const Text("Register"),
      minWidth: 100,
      color: Colors.green,
    );
  }

  register() async {
    if (formkey.currentState!.validate()) {
      setState(() {
        _isloading = true;
      });
      await authService
          .registerWithUserEmailAndPassword(fullname, email, password)
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

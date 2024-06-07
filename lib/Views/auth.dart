import 'package:flutter/material.dart';
import 'package:flutterproject/Components/button.dart';
import 'package:flutterproject/Views/login.dart';
import 'package:flutterproject/Views/signup.dart';
// import 'package:flutterproject/Components/colors.dart';

class Auth extends StatelessWidget {
  const Auth({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Authentication",
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                const Text(
                  "Authentication to access your vital",
                  style: TextStyle(color: Colors.black),
                ),
                const SizedBox(height: 16),
                Expanded(
                    child: Image.asset("assets/logo.jpg",
                        height: 200, width: 200)),
                const SizedBox(height: 32),
                Button(
                  label: "LOGIN",
                  press: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()));
                  },
                ),
                Button(
                    label: "SIGNUP",
                    press: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignupScreen()));
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: Auth(),
  ));
}

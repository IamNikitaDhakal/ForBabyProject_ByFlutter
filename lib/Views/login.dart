// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutterproject/Components/button.dart';
import 'package:flutterproject/Components/colors.dart';
import 'package:flutterproject/Components/textfield.dart';
import 'package:flutterproject/SQLite/database_helper.dart';
import 'package:flutterproject/Views/homepage.dart';
import 'package:flutterproject/Views/signup.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController userName = TextEditingController();
  final TextEditingController password = TextEditingController();
  bool isChecked = false;
  bool isLoginFailed = false;

  final db = DatabaseHelper();

  void login() async {
    var result = await db.authenticate(Users(
      fullname: '', // Provide an empty string or null for fullname
      email: userName.text,
      usrPassword: password.text,
    ));
    if (result) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } else {
      setState(() {
        isLoginFailed = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "LOGIN",
                style: TextStyle(color: primaryColor, fontSize: 40),
              ),
              Image.asset(
                "assets/logo.jpg",
                width: 200,
                height: 200,
              ),
              InputField(
                hint: "Enter a valid Email Address",
                icon: Icons.email_rounded,
                controller: userName,
              ),
              InputField(
                hint: "Password",
                icon: Icons.lock,
                controller: password,
                passwordInvisible: true,
              ),
              ListTile(
                horizontalTitleGap: 0.0,
                title: const Text("Remember me"),
                leading: Checkbox(
                  value: isChecked,
                  activeColor: primaryColor,
                  onChanged: (value) {
                    setState(() {
                      isChecked = value ?? false;
                    });
                  },
                ),
              ),
              Button(
                label: "LOGIN",
                press: login,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account?",
                    style: TextStyle(color: Colors.amberAccent),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignupScreen(),
                        ),
                      );
                    },
                    child: const Text("SIGN UP"),
                  ),
                ],
              ),
              isLoginFailed
                  ? Text(
                      "Username or Password is incorrect",
                      style: TextStyle(color: Colors.red.shade100),
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}

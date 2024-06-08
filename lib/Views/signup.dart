// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutterproject/Components/button.dart';
import 'package:flutterproject/Components/colors.dart';
import 'package:flutterproject/Components/textfield.dart';
import 'package:flutterproject/SQLite/database_helper.dart';
import 'package:flutterproject/Views/login.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  // Controllers to take the value from the user and pass it to the database.
  final TextEditingController userName = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();
  bool isChecked = false;
  bool isSignupValid = true;

  final db = DatabaseHelper();

  // SignUp Method
  signup() async {
    if (password.text == confirmPassword.text && isChecked) {
      var res = await db.createUser(Users(
        fullname: userName.text,
        email: email.text,
        usrPassword: password.text,
      ));
      if (res != -1) {
        // Navigate to login screen after successful signup
        if (!mounted) return;
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const LoginScreen()));
      } else {
        setState(() {
          isSignupValid = false;
        });
      }
    } else {
      setState(() {
        isSignupValid = false;
      });
    }
  }

  @override
  void dispose() {
    // Dispose controllers to free up resources
    userName.dispose();
    email.dispose();
    password.dispose();
    confirmPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              const Text(
                "SIGN UP",
                style: TextStyle(
                    color: submitcolor,
                    fontSize: 40,
                    fontWeight: FontWeight.bold),
              ),
              Image.asset(
                "assets/logo.jpg",
                width: 200, // Specify the width of the image
                height: 200, // Specify the height of the image
              ),
              const SizedBox(height: 20),
              InputField(
                hint: "Full Name",
                icon: Icons.account_circle,
                controller: userName,
              ),
              InputField(
                hint: "Email",
                icon: Icons.email,
                controller: email,
              ),
              InputField(
                hint: "Password",
                icon: Icons.lock,
                controller: password,
                passwordInvisible: true,
              ),
              InputField(
                hint: "Confirm Password",
                icon: Icons.lock,
                controller: confirmPassword,
                passwordInvisible: true,
              ),
              ListTile(
                horizontalTitleGap: 0.0,
                title: const Text("I agree to the terms and conditions"),
                leading: Checkbox(
                  value: isChecked,
                  activeColor: textfieldcolor,
                  onChanged: (value) {
                    setState(() {
                      isChecked = value ?? false;
                    });
                  },
                ),
              ),
              Button(label: "SIGN UP", press: signup),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already have an account?",
                    style: TextStyle(color: Colors.black),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()));
                    },
                    child: const Text(
                      "LOGIN",
                      style: TextStyle(color: submitcolor),
                    ),
                  ),
                ],
              ),
              // Show error message if signup is not valid
              isSignupValid
                  ? const SizedBox()
                  : Text(
                      "Please fill all the fields correctly",
                      style: TextStyle(color: Colors.red.shade100),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutterproject/Components/button.dart';
import 'package:flutterproject/Components/colors.dart';
import 'login.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 45.0, horizontal: 25),
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    backgroundColor: textfieldcolor,
                    radius: 75,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Nikita Dhakal",
                    style: TextStyle(fontSize: 28, color: textfieldcolor),
                  ),
                  const Text(
                    "nikitadhakal@gmail.com",
                    style: TextStyle(fontSize: 20, color: Colors.grey),
                  ),
                  Button(
                    label: "SIGN OUT",
                    press: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                      );
                    },
                  ),
                  const ListTile(
                    leading: Icon(Icons.person, size: 30),
                    subtitle: Text("Full Name"),
                    title: Text("Nikita Dhakal"),
                  ),
                  const ListTile(
                    leading: Icon(Icons.email, size: 30),
                    subtitle: Text("Email"),
                    title: Text("nikitadhakal@gmail.com"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

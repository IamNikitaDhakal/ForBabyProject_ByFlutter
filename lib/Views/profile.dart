import 'package:flutter/material.dart';
import 'package:flutterproject/Components/button.dart'; // Import your button widget
import 'package:flutterproject/Components/colors.dart'; // Import your colors

class Profile extends StatelessWidget {
  final String? fullName;
  final String? email;

  const Profile({
    Key? key,
    this.fullName,
    this.email,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 45.0, horizontal: 25),
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundColor: textfieldcolor, // Use your defined color
                    radius: 75,
                    child: Text(
                      fullName?.isNotEmpty == true
                          ? fullName!.substring(0, 2).toUpperCase()
                          : '', // Initials or placeholder
                      style: const TextStyle(fontSize: 40),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    fullName ?? '',
                    style: const TextStyle(fontSize: 28, color: textfieldcolor),
                  ),
                  Text(
                    email ?? '',
                    style: const TextStyle(fontSize: 20, color: Colors.grey),
                  ),
                  const SizedBox(height: 20),
                  Button(
                    label: "SIGN OUT",
                    press: () {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        '/login',
                        (route) =>
                            false, // Removes all routes below the login screen
                      );
                    },
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

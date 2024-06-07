import 'package:flutter/material.dart';
import 'package:flutterproject/Components/colors.dart';
import 'package:flutterproject/Views/profile.dart';
import 'package:flutterproject/Views/form_page.dart'; // Import the form page

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Profile()),
              );
            },
          ),
        ],
      ),
      body: const Center(
        child: Text(
          'Welcome to the Home Page!',
          style: TextStyle(fontSize: 24, color: primaryColor),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    const FormPage()), // Navigate to the form page
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

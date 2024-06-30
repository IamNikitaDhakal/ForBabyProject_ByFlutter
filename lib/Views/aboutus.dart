import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us'),
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'What exactly does ForBaby do?',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                  height:
                      16), // Adding some space between heading and description
              Text(
                'ForBaby is an app made for parents and caregivers of newborn babies.\n\n'
                'Welcoming a baby into your life is a significant milestone, and preparation is key.\n\n'
                'With ForBaby, you can ensure you\'re well-prepared from the beginning, with every small detail accounted for.\n\n'
                'You can mark purchased items and conveniently share lists with relatives and friends, ensuring nothing is overlooked, even when you\'re not available.',
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

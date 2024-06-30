import 'package:flutter/material.dart';

class FAQsPage extends StatelessWidget {
  const FAQsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FAQs'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildFAQItem(
                  context,
                  'How does this app work?',
                  'ForBaby helps parents and caregivers by providing a checklist of items needed for newborns. It allows you to mark purchased items and share lists with others.',
                ),
                const SizedBox(height: 16),
                _buildFAQItem(
                  context,
                  'Do we have to pay for the app?',
                  'ForBaby is free to download and use.',
                ),
                const SizedBox(height: 16),
                _buildFAQItem(
                  context,
                  'How is ForBaby beneficial for us?',
                  'ForBaby ensures you are well-prepared for welcoming a newborn, helping you manage and share your baby essentials checklist with ease.',
                ),
                const SizedBox(height: 16),
                _buildFAQItem(
                  context,
                  'How is ForBaby different from other similar apps?',
                  'ForBaby focuses on simplicity, ease of use, and sharing capabilities, making it convenient for busy parents and caregivers.',
                ),
                const SizedBox(height: 16),
                _buildFAQItem(
                  context,
                  'Who are our users?',
                  'ForBaby is designed for parents and caregivers of newborn babies who want to ensure they have everything they need.',
                ),
                const SizedBox(height: 16),
                _buildFAQItem(
                  context,
                  'Is my data secure on ForBaby?',
                  'ForBaby takes data security seriously. Your information is encrypted and stored securely to protect your privacy.',
                ),
                const SizedBox(height: 16),
                _buildFAQItem(
                  context,
                  'Can I customize the checklist for my specific needs?',
                  'Yes, ForBaby allows you to customize and add items to your checklist based on your preferences and needs.',
                ),
                const SizedBox(height: 16),
                _buildFAQItem(
                  context,
                  'Does ForBaby provide parenting tips and resources?',
                  'ForBaby offers parenting tips and resources to help you navigate the journey of caring for your newborn.',
                ),
                const SizedBox(height: 16),
                _buildFAQItem(
                  context,
                  'Can I use ForBaby offline?',
                  'ForBaby requires an internet connection to sync lists and updates across devices, but you can view your checklist offline once it\'s synced.',
                ),
                const SizedBox(height: 16),
                _buildFAQItem(
                  context,
                  'Is ForBaby available on multiple platforms?',
                  'ForBaby is currently available on Android and iOS platforms, ensuring accessibility for a wide range of users.',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFAQItem(BuildContext context, String question, String answer) {
    return ElevatedButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(question),
              content: Text(answer),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Close'),
                ),
              ],
            );
          },
        );
      },
      child: Text(
        question,
        style: const TextStyle(fontSize: 18),
        textAlign: TextAlign.center,
      ),
    );
  }
}

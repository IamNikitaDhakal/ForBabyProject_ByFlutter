import 'package:flutter/material.dart';

class UpdatesNewsPage extends StatelessWidget {
  const UpdatesNewsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Updates & News'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: const [
          NewsItem(
            title: 'New Feature: Baby Milestone Tracker',
            date: 'June 15, 2024',
            description:
                'Introducing a new feature to track your baby\'s milestones and development progress.',
          ),
          Divider(),
          NewsItem(
            title: 'App Update: Version 2.0 Released',
            date: 'May 20, 2024',
            description:
                'Exciting updates in version 2.0 including improved performance and new UI enhancements.',
          ),
          Divider(),
          NewsItem(
            title: 'Parenting Tips: Sleep Training Techniques',
            date: 'April 10, 2024',
            description:
                'Learn effective sleep training techniques to help your baby develop healthy sleep habits.',
          ),
        ],
      ),
    );
  }
}

class NewsItem extends StatelessWidget {
  final String title;
  final String date;
  final String description;

  const NewsItem({
    super.key,
    required this.title,
    required this.date,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 4),
          Text(date, style: const TextStyle(fontSize: 12, color: Colors.grey)),
          const SizedBox(height: 8),
          Text(description),
        ],
      ),
      onTap: () {
        // Add onTap functionality if needed
      },
    );
  }
}

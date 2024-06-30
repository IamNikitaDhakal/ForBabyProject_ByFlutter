import 'package:flutter/material.dart';
import 'package:flutterproject/Views/profile.dart';
import 'package:flutterproject/Views/updates_and_news.dart';
import 'Views/splash.dart';
import 'Views/homepage.dart';
import 'Views/aboutus.dart';
import 'Views/faqs.dart';
import 'Views/feedback.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'For Baby',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashScreen(), // Initially show SplashScreen
      routes: {
        '/home': (context) => const HomePage(),
        '/about': (context) => const AboutUsPage(),
        '/faqs': (context) => const FAQsPage(),
        '/feedback': (context) => const FeedbackPage(),
        '/updates_and_news': (context) => const UpdatesNewsPage(),
        '/profile': (context) => const Profile(
              fullName: '',
              email: '',
            ),
      },
    );
  }
}

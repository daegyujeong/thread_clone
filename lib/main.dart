import 'package:flutter/material.dart';
import 'package:thread_clone/features/authentication/verification_screen.dart';
import 'package:thread_clone/features/main_navigation/main_navigation.dart';

void main() {
  runApp(const ThreadApp());
}

class ThreadApp extends StatelessWidget {
  const ThreadApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TikTok Clone',
      theme: ThemeData(
        primaryColor: const Color(0xFFE9435A),
      ),
      home: const MainNavigationScreen(),
    );
  }
}

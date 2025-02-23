import 'package:flutter/material.dart';
import 'package:thread_clone/constants/sizes.dart';
import 'package:thread_clone/features/authentication/verification_screen.dart';
import 'package:thread_clone/features/main_navigation/main_navigation.dart';

void main() {
  runApp(const ThreadApp());
}

class ThreadApp extends StatelessWidget {
  const ThreadApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: ref.watch(routerProvider),
      title: 'TikTok Clone',
      themeMode: ThemeMode.system,
      theme: ThemeData(
        useMaterial3: false,
        scaffoldBackgroundColor: Colors.white,
        primaryColor: const Color(0xFF4A98E9),
        appBarTheme: const AppBarTheme(
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          elevation: 0,
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: Sizes.size16 + Sizes.size2,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
        bottomAppBarTheme: BottomAppBarTheme(
          color: Colors.grey.shade900,
        ),
        primaryColor: const Color(0xFFE9435A),
      ),
      // home:
      //     const MainNavigationScreen(), //SignInScreen(), //MainNavigationScreen() VerificationScreen(),
    );
  }
}

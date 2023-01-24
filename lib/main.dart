import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sign_language/consonant.dart';
import 'package:sign_language/profile.dart';
// import 'package:sign_language/video_screen.dart';
import 'package:sign_language/vowel.dart';

import 'home.dart';
import 'login.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sign Language',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/home',
      routes: {
          '/login': (ctx) => const LoginScreen(),
          '/home': (ctx) => const HomeScreen(title: 'Nepali Sign Language',),
          '/vowel': (ctx) => const VowelScreen(title: 'Vowel',),
          '/consonant': (ctx) => const ConsonantScreen(title: 'Consonant',),
          '/profile':(ctx) => const ProfileScreen(),
      },
    );
  }
}

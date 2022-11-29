import 'package:flutter/material.dart';
import 'screens/spalshscreen.dart';
import 'screens/bottomnavbar.dart';
import 'screens/detail.dart';
import 'screens/home.dart';

void main() async {
  runApp(const AnimeApp());
}

class AnimeApp extends StatelessWidget {
  const AnimeApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Char List',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreenPage(),
        '/bottomnavbar': (context) => const Navigation(),
        '/home': (context) => const HomePage(),
        '/detail': (context) => const DetailPage(item: 0, title: ''),
      },
    );
  }
}

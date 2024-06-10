import 'package:flutter/material.dart';
import 'pages/login/LoginPage.dart';
import 'pages/MainPage.dart';
import 'pages/CategoryPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DayWon',
      theme: ThemeData(
        fontFamily: "LaundryGothic",
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF4399FF)),
        useMaterial3: true,
      ),
      home: LoginPage(),
    );
  }
}

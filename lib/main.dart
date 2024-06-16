import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:io';
import 'pages/MainPage.dart';
import 'pages/user/CategoryPage.dart';
import 'package:project/pages/login/LoginPage.dart';
import 'package:flutter/material.dart';
import 'config.dart';

void main() {
  print('API URL: ${Config.apiUrl}');
  runApp(MyApp(apiUrl: Config.apiUrl));
}

class MyApp extends StatelessWidget {
  final String apiUrl;

  const MyApp({Key? key, required this.apiUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(apiUrl: apiUrl),
    );
  }
}

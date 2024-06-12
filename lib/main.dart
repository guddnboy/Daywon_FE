import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'pages/login/LoginPage.dart';
import 'pages/MainPage.dart';
import 'pages/user/CategoryPage.dart';
import 'dart:io';

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
        fontFamily: "KCC-Hanbit",
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF4399FF)),
        useMaterial3: true,
      ),
      home: LoginPage(),
    );
  }
}

// 예시로 환경 변수를 사용하는 함수 추가
String getServerUri() {
  final serverUri = Platform.environment['DAYWONPORT'];
  if (serverUri == null) {
    throw Exception("Server URI is not set");
  }
  print(serverUri);
  return serverUri;
}

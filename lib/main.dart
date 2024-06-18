import 'package:flutter/material.dart';
import 'package:project/pages/login/LoginPage.dart';
import 'config.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
        fontFamily: 'KCC-Hanbit',
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(apiUrl: apiUrl),
    );
  }
}

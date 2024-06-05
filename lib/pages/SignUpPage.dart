// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:project/pages/LoginPage.dart';

void main() {
  runApp(const SignupPage());
}

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: MediaQuery.sizeOf(context).width,
          height: MediaQuery.sizeOf(context).height,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.5,
                height: MediaQuery.of(context).size.height * 0.3,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/DayWon.png"),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.8,
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: '아이디',
                      labelStyle: const TextStyle(
                        fontSize: 13,
                      ),
                      filled: true,
                      fillColor: const Color(0xFFD9D9D9),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.8,
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: '비밀번호',
                      labelStyle: const TextStyle(
                        fontSize: 13,
                      ),
                      filled: true,
                      fillColor: const Color(0xFFD9D9D9),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.8,
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: '비밀번호 확인',
                      labelStyle: const TextStyle(
                        fontSize: 13,
                      ),
                      filled: true,
                      fillColor: const Color(0xFFD9D9D9),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.8,
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: '이메일',
                      labelStyle: const TextStyle(
                        fontSize: 13,
                      ),
                      filled: true,
                      fillColor: const Color(0xFFD9D9D9),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.8,
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: '닉네임',
                      labelStyle: const TextStyle(
                        fontSize: 13,
                      ),
                      filled: true,
                      fillColor: const Color(0xFFD9D9D9),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.8,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginPage(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 20.0),
                      backgroundColor: const Color(0xFF4399FF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ), // Background color
                    ),
                    child: const Text(
                      '회원가입하기',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

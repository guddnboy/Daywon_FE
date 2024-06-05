// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project/pages/MainPage.dart';
import 'package:project/pages/SignUpPage.dart';

void main() {
  runApp(const LoginPage());
}

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Stack(
            children: [
              Container(
                color: Colors.white,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    // 이미지 요소
                    Container(
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: MediaQuery.of(context).size.height * 0.3,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/DayWon.png"),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // const Text(
                    //   '로그인',
                    //   style: TextStyle(
                    //     color: Colors.black,
                    //     fontSize: 18,
                    //     fontFamily: 'Inter',
                    //     fontWeight: FontWeight.w600,
                    //   ),
                    // ),
                    const SizedBox(height: 20),
                    TextField(
                      decoration: InputDecoration(
                        labelText: '아이디',
                        filled: true,
                        fillColor: const Color(0xFFD9D9D9),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'[a-zA-Z0-9]')), // 영문자와 숫자만 허용
                      ],
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      decoration: InputDecoration(
                        labelText: '비밀번호',
                        filled: true,
                        fillColor: const Color(0xFFD9D9D9),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      obscureText: true,
                    ),
                    const SizedBox(height: 20),
                    // 로그인 버튼
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MainPage()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF4399FF),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        child: const Text(
                          '로그인',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton(
                          onPressed: () {
                            // Handle 아이디 찾기 button press
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.white, // 버튼 배경색 설정
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide.none, // 테두리 없애기
                            ),
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20), // 패딩 설정
                          ),
                          child: const Text(
                            '아이디 찾기',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            // Handle 비밀번호 찾기 button press
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.white, // 버튼 배경색 설정
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide.none, // 테두리 없애기
                            ),
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20), // 패딩 설정
                          ),
                          child: const Text(
                            '비밀번호 찾기',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignupPage()),
                            );
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.white, // 버튼 배경색 설정
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide.none, // 테두리 없애기
                            ),
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20), // 패딩 설정
                          ),
                          child: const Text(
                            '회원가입',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),
                    const Text(
                      'Day￦과 금융 학습을 시작하세요!',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:project/pages/user/Mypage/CorrectProblemDetails.dart';
import 'package:project/pages/MainPage.dart';
import 'package:project/pages/user/Mypage/MyPage.dart';
import 'package:project/pages/admin/CompleteCheckProblemDetails.dart';
import 'package:project/pages/admin/NeedToCheckProblemDetails.dart';

void main() {
  runApp(CompleteCheckProblem());
}

// ignore: use_key_in_widget_constructors
class CompleteCheckProblem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          clipBehavior: Clip.antiAlias,
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Color(0x3F000000),
                blurRadius: 4,
                offset: Offset(0, 4),
                spreadRadius: 0,
              )
            ],
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final width = constraints.maxWidth;
              final height = constraints.maxHeight;

              return Stack(
                children: [
                  Positioned(
                    left: width * 0.1,
                    top: height * 0.22,
                    child: Container(
                      width: width * 0.8,
                      height: height * 0.7,
                      decoration: BoxDecoration(
                        color: const Color(0xFF8BC0FF),
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                  ),
                  Positioned(
                    left: width * 0.07,
                    top: height * 0.07,
                    child: Text(
                      '검수 완료 문제',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: width * 0.07,
                        fontWeight: FontWeight.w700,
                        height: 1.2,
                      ),
                    ),
                  ),
                  Positioned(
                    left: width * 0.07,
                    top: height * 0.14,
                    child: Text(
                      '관리자님, 검수가 완료된 문제를 확인하세요!',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: width * 0.035,
                        fontWeight: FontWeight.w400,
                        height: 1.2,
                      ),
                    ),
                  ),
                  Positioned(
                    left: width * 0.35,
                    top: height * 0.238,
                    child: Container(
                      width: width * 0.3,
                      height: width * 0.3,
                      decoration: const BoxDecoration(
                        color: Color(0xFF065ABD),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: '검수 완료 문제\n',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: width * 0.03,
                                  fontWeight: FontWeight.w700,
                                  height: 1.2,
                                ),
                              ),
                              TextSpan(
                                text: '모두 보기',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: width * 0.04,
                                  fontWeight: FontWeight.w700,
                                  height: 1.2,
                                ),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: width * 0.15,
                    top: height * 0.45,
                    child: Container(
                      width: width * 0.7,
                      height: height * 0.45,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 255, 255, 255),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: ListView.builder(
                          itemCount: 20,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Stack(
                                children: [
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      minimumSize:
                                          Size(width * 0.65, height * 0.08),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              CompleteCheckProblemDetails(
                                                  index: index),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      'Button ${index + 1}',
                                      style: TextStyle(
                                        fontSize: width * 0.035,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700,
                                        height: 1.2,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: width * 0.02,
                                    top: height * 0.016,
                                    child: Container(
                                      width: width * 0.08,
                                      height: width * 0.08,
                                      decoration: const BoxDecoration(
                                        color: Color(0xFF065ABD),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Center(
                                        child: Text(
                                          '${index + 1}',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: width * 0.04,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/img/backbtn.png',
              width: 24,
              height: 24,
            ),
            label: 'Back',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/img/homebtn.png',
              width: 28,
              height: 28,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/img/mypagebtn.png',
              width: 24,
              height: 24,
            ),
            label: 'My Page',
          ),
        ],
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pop(context);
              break;
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MainPage()),
              );
              break;
            case 2:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MyPage()),
              );
              break;
          }
        },
      ),
    );
  }
}

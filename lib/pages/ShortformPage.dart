// ignore_for_file: file_names, library_private_types_in_public_api

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:project/pages/MainPage.dart';

void main() {
  runApp(const MaterialApp(
    home: ShortformPage(selectedCategory: ''),
  ));
}

class ShortformPage extends StatefulWidget {
  final String selectedCategory;

  const ShortformPage({super.key, required this.selectedCategory});

  @override
  _ShortformPageState createState() => _ShortformPageState();
}

class _ShortformPageState extends State<ShortformPage> {
  late String selectedCategory; // 선택된 카테고리를 저장할 변수
  String explanation = ''; // 개념 설명을 저장할 변수

  @override
  void initState() {
    super.initState();
    selectedCategory = widget.selectedCategory;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: LayoutBuilder(
          builder: (context, constraints) {
            double containerWidth = constraints.maxWidth * 0.8;
            double containerHeight = constraints.maxHeight * 0.65;

            return Stack(
              children: [
                Center(
                  child: Container(
                    width: constraints.maxWidth,
                    height: constraints.maxHeight,
                    clipBehavior: Clip.antiAlias,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Align(
                      alignment: const Alignment(
                          0, 0.3), // Y축 위치 조정 (-1: top, 0: center, 1: bottom)
                      child: Container(
                        width: containerWidth,
                        height: containerHeight,
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                              width: 2,
                              color: Color(0xFF4399FF),
                            ),
                            borderRadius: BorderRadius.circular(17),
                          ),
                          shadows: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              spreadRadius: 2,
                              blurRadius: 10,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 15),
                              child: Text(
                                selectedCategory.isNotEmpty
                                    ? selectedCategory // 선택된 카테고리 텍스트 표시
                                    : '오늘의 학습', // 기본 텍스트
                                style: const TextStyle(
                                  fontSize: 30,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            // 개념 설명 텍스트 표시
                            Padding(
                              padding: const EdgeInsets.all(20),
                              child: Center(
                                child: Text(
                                  explanation,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 60,
                  right: 50,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Image.asset(
                      'assets/img/backbtn.png',
                      width: 45,
                      height: 45,
                    ),
                  ),
                ),
                Positioned(
                  top: 68,
                  left: 55,
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/img/circle.png',
                        width: 20,
                        height: 20,
                      ),
                      const SizedBox(width: 5),
                      const Text(
                        '오늘의 학습', // 기본 텍스트
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

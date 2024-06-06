import 'package:flutter/material.dart';
import 'package:project/pages/LearningPage.dart';
import 'package:project/pages/MainPage.dart';

void main() {
  runApp(const MaterialApp(
    home: CategoryPage(),
  ));
}

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: LayoutBuilder(
          builder: (context, constraints) {
            double containerWidth = constraints.maxWidth * 0.8;
            double containerHeight = constraints.maxHeight * 0.65;

            String category1 = '세금';
            String category2 = '자산관리';
            String category3 = '금융기초상식';
            String category4 = '기본 상식';

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
                            const Padding(
                              padding: EdgeInsets.only(top: 15),
                              child: Text(
                                '카테고리 선택',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 30,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w600,
                                  height: 1.2,
                                ),
                              ),
                            ),
                            const SizedBox(height: 25), // 간격 조정
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFABD2FF),
                                fixedSize: const Size(190, 55),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LearningPage(
                                              selectedCategory: category1,
                                            )));
                              },
                              child: const Text(
                                '세금',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            const SizedBox(height: 25), // 간격 조정
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF55A3FF),
                                fixedSize: const Size(190, 55),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LearningPage(
                                              selectedCategory: category2,
                                            )));
                              },
                              child: const Text(
                                '자산관리',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            const SizedBox(height: 25), // 간격 조정
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF0075FF),
                                fixedSize: const Size(190, 55),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LearningPage(
                                              selectedCategory: category3,
                                            )));
                              },
                              child: const Text(
                                '금융기초상식',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            const SizedBox(height: 25), // 간격 조정
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF0056BD),
                                fixedSize: const Size(190, 55),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LearningPage(
                                              selectedCategory: category4,
                                            )));
                              },
                              child: const Text(
                                '기본 상식',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w600,
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
                        '오늘의 학습',
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
                MaterialPageRoute(builder: (context) => MainPage()),
              );
              break;
          }
        },
      ),
    );
  }
}

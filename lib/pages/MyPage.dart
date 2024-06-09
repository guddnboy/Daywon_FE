import 'package:flutter/material.dart';
import 'package:project/pages/MainPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyPage(),
    );
  }
}

class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 100), // 상단 공간 추가
                Row(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage('assets/marimo.png'), // 이미지 경로를 수정해주세요.
                    ),
                    SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '닉네임',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              '랭킹',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(width: 4), // 텍스트 사이의 간격 조정
                            Text(
                              '1',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(width: 4),
                            Text(
                              '위',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          '오늘도 출석하셨네요!',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 24),
                Row(
                  children: [
                    Icon(Icons.circle, color: Colors.blue, size: 10),
                    SizedBox(width: 8),
                    Text(
                      '내 기록',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('맞은 문제'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFABD2FF),
                    foregroundColor: Colors.white,
                    textStyle: TextStyle(
                      fontSize: 20,
                    ),
                    minimumSize: Size(double.infinity, 60), // 버튼의 최소 크기
                    padding: EdgeInsets.symmetric(vertical: 20), // 내부 여백
                  ),
                ),
                SizedBox(height: 18),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('틀린 문제'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF55A3FF),
                    foregroundColor: Colors.white,
                    textStyle: TextStyle(
                      fontSize: 20,
                    ),
                    minimumSize: Size(double.infinity, 60), // 버튼의 최소 크기
                    padding: EdgeInsets.symmetric(vertical: 20), // 내부 여백
                  ),
                ),
                SizedBox(height: 18),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('오늘의 랭킹'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0075FF), // 배경색
                    foregroundColor: Colors.white,
                    textStyle: TextStyle(
                      fontSize: 20,
                    ),
                    minimumSize: Size(double.infinity, 60), // 버튼의 최소 크기
                    padding: EdgeInsets.symmetric(vertical: 20), // 내부 여백
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 40, // 원하는 top 위치
            left: 16, // 원하는 left 위치
            child: Text(
              '마이페이지',
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/backbtn.png',
              width: 24,
              height: 24,
            ),
            label: 'Back',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/homebtn.png',
              width: 28,
              height: 28,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/mypagebtn.png',
              width: 24,
              height: 24,
            ),
            label: 'My Page',
          ),
        ],
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          // Handle tap logic here, e.g., navigating to different pages
          print('Tapped index: $index');
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
                MaterialPageRoute(builder: (context) => MyPage()),
              );
              break;
          }
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:project/pages/MainPage.dart';
import 'package:project/pages/CorrectProblem.dart';

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
                SizedBox(height: 80), // 상단 공간 추가
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Color(0xFFF0F0F0),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundImage: AssetImage('assets/img/marimo_1.png'), // 이미지 경로를 수정해주세요.
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
                    ],
                  ),
                ),
                SizedBox(height: 15),
                Row(
                  children: [
                    Icon(Icons.circle, color: Colors.blue, size: 14),
                    SizedBox(width: 8),
                    Text(
                      '내 기록',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () { 
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Correctproblem()),
                            );},
                        child: Text('맞은 문제'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFABD2FF),
                          foregroundColor: Colors.white,
                          textStyle: TextStyle(
                            fontSize: 20,
                          ),
                          minimumSize: Size(60, 60), // 버튼의 최소 크기
                          padding: EdgeInsets.symmetric(vertical: 20), // 내부 여백
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text('틀린 문제'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF55A3FF),
                          foregroundColor: Colors.white,
                          textStyle: TextStyle(
                            fontSize: 20,
                          ),
                          minimumSize: Size(60, 60), // 버튼의 최소 크기
                          padding: EdgeInsets.symmetric(vertical: 20), // 내부 여백
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Icon(Icons.circle, color: Colors.blue, size: 14),
                    SizedBox(width: 8),
                    Text(
                      '오늘의 랭킹',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ListView.separated(
                      padding: EdgeInsets.zero,
                      itemCount: 50,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: index < 3
                              ? Image.asset(
                                  'assets/img/rank${index + 1}.png', // 이미지 경로를 수정해주세요.
                                  width: 40,
                                  height: 40,
                                )
                              : null,
                          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                          title: Text('${index + 1}위'),
                          subtitle: Text('사용자 ${index + 1}'),
                          trailing: Text('Points 점', style: TextStyle(fontSize: 16)),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return Divider(color: const Color.fromARGB(255, 209, 209, 209));
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 35, // 원하는 top 위치
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
                MaterialPageRoute(builder: (context) => MyPage()),
              );
              break;
          }
        },
      ),
    );
  }
}

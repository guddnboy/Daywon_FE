// ignore_for_file: unnecessary_const
import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:project/pages/user/CategoryPage.dart';
import 'package:project/pages/user/Mypage/MyPage.dart';
import 'package:http/http.dart' as http;

class MainPage extends StatefulWidget {
  final String email;
  final String apiUrl;

  MainPage({Key? key, required this.email, required this.apiUrl}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String nickname = '';
  int points = 0;
  int profileImageId = 0;

  @override
  void initState() {
    super.initState();
    fetchUser(widget.email);
  }

  Future<void> fetchUser(String email) async {
    final url = Uri.parse('${widget.apiUrl}/users/readuser?email=$email');
    final response = await http.get(url, headers: {'Accept': 'application/json'});

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      setState(() {
        nickname = responseData['nickname'] ?? 'Unknown';
        points = responseData['user_point'] ?? 0;
        profileImageId = responseData['profile_image'] ?? 0;
      });
    } else {
      // Handle error
      print('Failed to load user data');
    }
  }

  String getProfileImagePath(int profileImageId) {
    // 여기에 정수 값에 따른 이미지 경로를 매핑합니다.
    switch (profileImageId) {
      case 1:
        return 'assets/img/marimo_2.png';
      case 2:
        return 'assets/img/marimo_3.png';
      case 3:
        return 'assets/img/marimo_4.png';
      // 필요한 만큼 case를 추가하세요.
      default:
        return 'assets/img/marimo_1.png';
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              padding: const EdgeInsets.all(20.0),
              color: Colors.white,
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      height: MediaQuery.of(context).size.height * 0.2,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/img/DayWon.png"),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        nickname,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w800
                            // height: 0,
                            ),
                      ),
                      const Text(
                        '님, 오늘의 학습을 시작하세요! ',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          height: 0,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  Stack(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10.0,
                          horizontal: 10.0,
                        ),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.2,
                        decoration: ShapeDecoration(
                          color: const Color(0xFF4399FF),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                          shadows: const [
                            BoxShadow(
                              color: Color(0x3F000000),
                              blurRadius: 4,
                              offset: Offset(0, 4),
                              spreadRadius: 0,
                            )
                          ],
                        ),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          nickname,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                          ),
                                        ),
                                        const Text(
                                          "  자유 입출금 통장",
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  points.toString(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 30,
                                    height: 0,
                                  ),
                                ),
                                const Text(
                                  '원',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 30,
                                    height: 0,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    child: Container(
                      width: MediaQuery.sizeOf(context).width,
                      decoration: const ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            width: 1,
                            color: Color.fromARGB(255, 222, 222, 222),
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              width: 18,
                              height: 18,
                              decoration: const ShapeDecoration(
                                color: Color(0xFF0075FF),
                                shape: OvalBorder(),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10.0),
                          const Text(
                            '오늘의 학습',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              height: 0,
                            ),
                          ),
                        ],
                      ),
                     const SizedBox(height: 50),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundImage: AssetImage(getProfileImagePath(profileImageId)),
                          ),
                          Column(
                            children: [
                              Row(
                                children: [
                                  const Text(
                                    '오늘도 파이팅하세요!',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      height: 0,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              SizedBox(
                                width: MediaQuery.sizeOf(context).width * 0.4,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const CategoryPage()),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12),
                                  ),
                                  child: const Text(
                                    '학습하기',
                                    style: TextStyle(
                                      color: Color(0xFF4399FF),
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
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
                MaterialPageRoute(builder: (context) => MainPage(email: widget.email, apiUrl: widget.apiUrl)),
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

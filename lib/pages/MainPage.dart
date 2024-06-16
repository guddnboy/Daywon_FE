import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:project/pages/user/CategoryPage.dart';
import 'package:project/pages/user/Mypage/MyPage.dart';
import 'package:http/http.dart' as http;

class MainPage extends StatefulWidget {
  final int userId;
  final String apiUrl;
  String profileImagePath; // 이 변수는 이제 final이 아닙니다.

  MainPage({Key? key, required this.userId, required this.apiUrl, required this.profileImagePath}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String nickname = '';
  int points = 0;

  @override
  void initState() {
    super.initState();
    fetchUser(widget.userId);
    fetchProfileImage(widget.userId);
  }

  Future<void> fetchUser(int userId) async {
    final url = Uri.parse('${widget.apiUrl}/users/$userId/readuser');
    final response = await http.get(url, headers: {'Accept': 'application/json'});

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      setState(() {
        nickname = responseData['nickname'] ?? 'Unknown';
        points = responseData['user_point'] ?? 0;
      });
    } else {
      print('사용자 데이터 로드 실패');
    }
  }

  Future<void> fetchProfileImage(int userId) async {
    final url = Uri.parse('${widget.apiUrl}/users/$userId/profile-image');
    final response = await http.get(url, headers: {'Accept': 'application/json'});

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      setState(() {
        widget.profileImagePath = responseData['profile_image_url'];
      });
    } else {
      print('프로필 이미지 로드 실패');
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
                                          "님의, 자유 입출금 통장",
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
                            backgroundImage: NetworkImage(widget.profileImagePath),
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
                                              CategoryPage(userId: widget.userId, apiUrl: widget.apiUrl, profileImagePath: widget.profileImagePath,)),
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
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => MainPage(
                    userId: widget.userId,
                    apiUrl: widget.apiUrl,
                    profileImagePath: widget.profileImagePath, // 업데이트된 프로필 이미지 경로 전달
                  ),
                ),
              ).then((_) {
                fetchUser(widget.userId); // MainPage로 돌아올 때 상태를 새로 고침
                fetchProfileImage(widget.userId); // MainPage로 돌아올 때 상태를 새로 고침
              });
              break;
            case 2:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => MyPage(
                    userId: widget.userId,
                    apiUrl: widget.apiUrl,
                    profileImagePath: widget.profileImagePath, // 업데이트된 프로필 이미지 경로 전달
                  ),
                ),
              ).then((_) {
                fetchUser(widget.userId); // MyPage로 돌아올 때 상태를 새로 고침
                fetchProfileImage(widget.userId); // MyPage로 돌아올 때 상태를 새로 고침
              });
              break;
          }
        },
      ),
    );
  }
}

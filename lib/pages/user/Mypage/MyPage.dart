import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:project/pages/MainPage.dart';
import 'package:project/pages/user/Mypage/CorrectProblem.dart';
import 'package:project/pages/user/Mypage/WrongProblem.dart';
import 'package:http/http.dart' as http;

class MyPage extends StatefulWidget {
  final int userId;
  final String apiUrl;
  final String profileImagePath; // 추가된 프로필 이미지 URL
  


  MyPage({Key? key, required this.userId, required this.apiUrl, required this.profileImagePath}) : super(key: key);

  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  String nickname = '';
  int points = 0;
  String profileImagePath = '';
  int ranking = 0;
  List<Map<String, dynamic>> userRankings = [];
  int selectedProfileImageId = 0;

  @override
  void initState() {
    super.initState();
    profileImagePath = widget.profileImagePath; // 초기화
    fetchUser(widget.userId);
    fetchProfileImage(widget.userId);
    fetchRanking(widget.userId);
    fetchAllRankings();
  }

  Future<void> fetchUser(int userId) async {
    final url = Uri.parse('${widget.apiUrl}/users/$userId/read_user');
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
        profileImagePath = responseData['profile_image_url'];
      });
    } else {
      print('프로필 이미지 로드 실패');
    }
  }

  Future<void> fetchRanking(int userId) async {
    final url = Uri.parse('${widget.apiUrl}/user/$userId/ranking');
    final response = await http.get(url, headers: {'Accept': 'application/json'});

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      setState(() {
        ranking = responseData['ranking_position'] ?? 0;
      });
    } else {
      print('랭킹 데이터 로드 실패');
    }
  }

  Future<void> fetchAllRankings() async {
    final url = Uri.parse('${widget.apiUrl}/get_all_ranking/');
    final response = await http.get(url, headers: {'Accept': 'application/json'});

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body) as List;
      setState(() {
        userRankings = responseData.map((user) => {
          'user_id': user['user_id'],
          'nickname': user['nickname'],
          'points': user['points'],
          'ranking_position': user['ranking_position'],
        }).toList();
      });
    } else {
      print('모든 사용자 랭킹 데이터 로드 실패');
    }
  }

  void showProfileEditPopup(BuildContext context) {
    TextEditingController nicknameController = TextEditingController(text: nickname);
    // int selectedProfileImageId = 0;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('정보 변경'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nicknameController,
                decoration: const InputDecoration(labelText: '닉네임'),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(4, (index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedProfileImageId = index;
                      });
                    },
                    child: CircleAvatar(
                      backgroundImage: AssetImage(getProfileImagePath(index)),
                      radius: selectedProfileImageId == index ? 30 : 20,
                    ),
                  );
                }),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: const Text('취소'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: const Text('변경'),
              onPressed: () {
                setState(() {
                  nickname = nicknameController.text;
                  profileImagePath = getProfileImagePath(selectedProfileImageId);
                });
                updateProfile(widget.userId, nickname, selectedProfileImageId);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

 Future<void> updateProfile(int userId, String newNickname, int newProfileImageId) async {

  print("--------------------------------------");
  print(newProfileImageId);
  print("--------------------------------------");
  
  final url = Uri.parse('${widget.apiUrl}/user/$userId/update');
  final response = await http.put(
    url,
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
    body: json.encode({
      'nickname': newNickname,
      'profile_image': newProfileImageId + 2,
    }),
  );

  if (response.statusCode == 200) {
    print('프로필 업데이트 성공');
    print('Updated Nickname: $newNickname');
    print('Updated Profile Image Path: ${getProfileImagePath(newProfileImageId)}');
  } else {
    print('프로필 업데이트 실패');
    print('Status code: ${response.statusCode}');
    print('Response body: ${response.body}');
  }
}

  String getProfileImagePath(int profileImageId) {
    switch (profileImageId) {
      case 1:
        return 'assets/img/marimo_1.png';
      case 2:
        return 'assets/img/marimo_2.png';
      case 3:
        return 'assets/img/marimo_3.png';
      case 4:
        return 'assets/img/marimo_4.png';
      default:
        return 'assets/img/marimo_4.png';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 80), // 상단 공간 추가
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF0F0F0),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: NetworkImage(profileImagePath),
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            nickname,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            children: [
                              const Text(
                                '랭킹',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(width: 4), // 텍스트 사이의 간격 조정
                              Text(
                                ranking.toString(),
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(width: 4),
                              const Text(
                                '위',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          const Text(
                            '오늘도 출석하셨네요!',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      IconButton(
                        icon: Icon(Icons.edit, color: Colors.blue),
                        onPressed: () {
                          showProfileEditPopup(context);
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                const Row(
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
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Correctproblem()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFABD2FF),
                          foregroundColor: Colors.white,
                          textStyle: const TextStyle(
                            fontSize: 20,
                            fontFamily: 'KCC-Hanbit',
                          ),
                          minimumSize: const Size(60, 60), // 버튼의 최소 크기
                          padding:
                              const EdgeInsets.symmetric(vertical: 20), // 내부 여백
                        ),
                        child: const Text('맞은 문제'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Wrongproblem()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF55A3FF),
                          foregroundColor: Colors.white,
                          textStyle: const TextStyle(
                            fontSize: 20,
                            fontFamily: 'KCC-Hanbit',
                          ),
                          minimumSize: const Size(60, 60), // 버튼의 최소 크기
                          padding:
                              const EdgeInsets.symmetric(vertical: 20), // 내부 여백
                        ),
                        child: const Text('틀린 문제'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Row(
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
                const SizedBox(height: 5),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ListView.separated(
                      padding: EdgeInsets.zero,
                      itemCount: userRankings.length,
                      itemBuilder: (context, index) {
                        final user = userRankings[index];
                        return ListTile(
                          leading: index < 3
                              ? Image.asset(
                                  'assets/img/rank${index + 1}.png', // 이미지 경로를 수정해주세요.
                                  width: 40,
                                  height: 40,
                                )
                              : null,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 4),
                          title: Text('${user['ranking_position']}위'),
                          subtitle: Text('${user['nickname']}'),
                          trailing: Text('${user['points']} 점',
                              style: TextStyle(fontSize: 16)),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const Divider(
                            color: Color.fromARGB(255, 209, 209, 209));
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Positioned(
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
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => MainPage(
                    userId: widget.userId,
                    apiUrl: widget.apiUrl,
                    profileImagePath: profileImagePath, // 업데이트된 프로필 이미지 경로 전달
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
                    profileImagePath: profileImagePath, // 업데이트된 프로필 이미지 경로 전달
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

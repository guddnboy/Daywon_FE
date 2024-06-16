import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project/pages/MainPage.dart';
import 'dart:convert';
import 'package:project/pages/user/learning/ShortformPage.dart';
import 'package:project/pages/user/Mypage/MyPage.dart';

class LearningPage extends StatefulWidget {
  final int categoryId;
  final int level;
  final String selectedCategory;
  final int userId;
  final String apiUrl;

  const LearningPage({
    Key? key,
    required this.categoryId,
    required this.level,
    required this.selectedCategory,
    required this.userId,
    required this.apiUrl,
  }) : super(key: key);

  @override
  _LearningPageState createState() => _LearningPageState();
}

class _LearningPageState extends State<LearningPage> {
  late int categoryId;
  late int level;
  late String selectedCategory;
  String explanation = '';
  int scriptsId = 0; // scripts_id를 저장할 변수 추가
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    categoryId = widget.categoryId;
    level = widget.level;
    selectedCategory = widget.selectedCategory;
    fetchConceptExplanation(categoryId, level);
  }

  Future<void> fetchConceptExplanation(int categoryId, int level) async {
    final url = '${widget.apiUrl}/read/scripts/random?category_label=$categoryId&level=$level';
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        print("Raw response body: ${response.body}");  // 원본 응답 로그 출력
        final data = json.decode(utf8.decode(response.bodyBytes));
        setState(() {
          explanation = data['combined_content'];
          scriptsId = data['scripts_id']; // scripts_id 저장
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load script');
      }
    } catch (e) {
      setState(() {
        explanation = 'Failed to load explanation: $e';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: [
          LearningPageContent(
            selectedCategory: selectedCategory,
            explanation: explanation,
            isLoading: isLoading,
          ),
          ShortformPage(
            selectedCategory: selectedCategory,
            scriptsId: scriptsId, // scripts_id 전달
            userId: widget.userId,
            apiUrl: widget.apiUrl,
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
                MaterialPageRoute(
                  builder: (context) => MainPage(userId: widget.userId, apiUrl: widget.apiUrl),
                ),
              );
              break;
            case 2:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MyPage(userId: widget.userId, apiUrl: widget.apiUrl),
                ),
              );
              break;
          }
        },
      ),
    );
  }
}

class LearningPageContent extends StatelessWidget {
  final String selectedCategory;
  final String explanation;
  final bool isLoading;

  const LearningPageContent({
    Key? key,
    required this.selectedCategory,
    required this.explanation,
    required this.isLoading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double containerWidth = MediaQuery.of(context).size.width * 0.9;
    double containerHeight = MediaQuery.of(context).size.height * 0.7; // 네비게이션 위에 고정 크기 설정

    return Center(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            width: containerWidth,
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Container(
                  width: containerWidth,
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
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: Text(
                          selectedCategory,
                          style: const TextStyle(
                            fontSize: 30,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        height: containerHeight - 100, // 네비게이션 바 위에 위치하도록 고정 크기 설정
                        padding: const EdgeInsets.all(20),
                        child: Center(
                          child: isLoading
                              ? CircularProgressIndicator()
                              : SingleChildScrollView(
                                  child: Text(
                                    explanation,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

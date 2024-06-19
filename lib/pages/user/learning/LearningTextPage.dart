import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project/pages/MainPage.dart';
import 'dart:convert';
import 'package:project/pages/user/learning/ShortformPage.dart';
import 'package:project/pages/user/Mypage/MyPage.dart';

class LearningPage extends StatefulWidget {
  final int categoryId;
  final String level;
  final String selectedCategory;
  final int userId;
  final String apiUrl;
  final String profileImagePath;

  const LearningPage(
      {Key? key,
      required this.categoryId,
      required this.level,
      required this.selectedCategory,
      required this.userId,
      required this.apiUrl,
      required this.profileImagePath})
      : super(key: key);

  @override
  _LearningPageState createState() => _LearningPageState();
}

class _LearningPageState extends State<LearningPage> {
  late int categoryId;
  late String level;
  late String selectedCategory;
  String explanation = '';
  int scriptsId = 0; // scripts_id를 저장할 변수 추가
  bool isLoading = true;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    categoryId = widget.categoryId;
    level = widget.level;
    selectedCategory = widget.selectedCategory;
    fetchConceptExplanation(categoryId, level);
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> fetchConceptExplanation(int categoryId, String level) async {
    final url =
        '${widget.apiUrl}/read/scripts/random?category_label=$categoryId&level=$level';
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        print("Raw response body: ${response.body}"); // 원본 응답 로그 출력
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
        controller: _pageController,
        children: [
          LearningPageContent(
            selectedCategory: selectedCategory,
            explanation: explanation,
            isLoading: isLoading,
            key: ValueKey('LearningPageContent'), // 고유한 키 추가
          ),
          ShortformPage(
            selectedCategory: selectedCategory,
            scriptsId: scriptsId, // scripts_id 전달
            userId: widget.userId,
            apiUrl: widget.apiUrl,
            profileImagePath: widget.profileImagePath,
            key: ValueKey('ShortformPage'), // 고유한 키 추가
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
                  builder: (context) => MainPage(
                      userId: widget.userId,
                      apiUrl: widget.apiUrl,
                      profileImagePath: widget.profileImagePath),
                ),
              );
              break;
            case 2:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MyPage(
                      userId: widget.userId,
                      apiUrl: widget.apiUrl,
                      profileImagePath: widget.profileImagePath),
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
    return Center(
      child: LayoutBuilder(
        builder: (context, constraints) {
          double containerWidth = constraints.maxWidth * 0.8;
          double containerHeight = constraints.maxHeight * 0.65;

          return Container(
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            clipBehavior: Clip.antiAlias,
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Align(
              alignment: const Alignment(0, 0.3),
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
                child: SingleChildScrollView(
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
              ),
            ),
          );
        },
      ),
    );
  }
}

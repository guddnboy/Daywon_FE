import 'package:flutter/material.dart';
import 'package:project/pages/MainPage.dart';
import 'package:project/pages/ShortformPage.dart';

void main() {
  runApp(const MaterialApp(
    home: LearningPage(selectedCategory: ''),
  ));
}

class LearningPage extends StatefulWidget {
  final String selectedCategory;

  const LearningPage({Key? key, required this.selectedCategory})
      : super(key: key);

  @override
  _LearningPageState createState() => _LearningPageState();
}

class _LearningPageState extends State<LearningPage> {
  late String selectedCategory; // 선택된 카테고리를 저장할 변수
  String explanation = ''; // 개념 설명을 저장할 변수

  @override
  void initState() {
    super.initState();
    selectedCategory = widget.selectedCategory;
    fetchConceptExplanation(selectedCategory); // 선택된 카테고리에 대한 개념 설명 가져오기
  }

  // 데이터베이스에서 개념 설명 가져오는 함수 (가상의 함수)
  void fetchConceptExplanation(String category) {
    // 이 부분에서 실제로 데이터베이스에서 텍스트를 가져와야 합니다.
    // 이 예시에서는 가상의 텍스트를 사용합니다.
    // category에 따라 다른 개념 설명을 가져오도록 구현해야 합니다.
    setState(() {
      // 가상의 개념 설명 텍스트 설정
      explanation = '''
        이 부분은 가상의 개념 설명입니다.
        데이터베이스에서 실제 텍스트를 가져와야 합니다.
        ''';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: [
          LearningPageContent(
            selectedCategory: selectedCategory,
            explanation: explanation,
          ),
          ShortformPage(
            selectedCategory: selectedCategory,
          ), // 추가된 ShortformPage
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
          // Handle tap logic here, e.g., navigating to different pages
          print('Tapped index: $index');
          switch (index) {
            case 0:
              Navigator.pop(context);
              break;
            case 1:
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

class LearningPageContent extends StatelessWidget {
  final String selectedCategory;
  final String explanation;

  const LearningPageContent({
    Key? key,
    required this.selectedCategory,
    required this.explanation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
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
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: Text(
                              selectedCategory.isNotEmpty
                                  ? selectedCategory
                                  : '오늘의 학습',
                              style: const TextStyle(
                                fontSize: 30,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
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
    );
  }
}

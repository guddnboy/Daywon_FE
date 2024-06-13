import 'package:flutter/material.dart';
import 'package:project/pages/user/Mypage/CorrectProblemCommentaryPage.dart';
import 'package:project/pages/MainPage.dart';
import 'package:project/pages/user/Mypage/CorrectProblem.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Correctproblemdetails(index: 0),
    );
  }
}

class Problem {
  final String question;
  final List<String> choices;

  Problem({required this.question, required this.choices});
}

Future<Problem> fetchProblem(int index) async {
  // 데이터베이스나 API 호출로 데이터를 가져오는 부분
  await Future.delayed(const Duration(seconds: 1)); // 데이터 가져오는 시간 시뮬레이션
  // 인덱스에 따라 다른 문제 반환
  List<Problem> problems = [
    Problem(
      question: '문제 예시가 무언가 있음 이 상황에서 선택해야하는 상품은?',
      choices: ['보기 1번', '보기 2번', '보기 3번', '보기 4번'],
    ),
    Problem(
      question: '다른 문제 예시가 있음. 무엇을 고르겠습니까?',
      choices: ['선택지 1번', '선택지 2번', '선택지 3번', '선택지 4번'],
    ),
    // 추가 문제를 여기에 추가
  ];
  return problems[index % problems.length];
}

class Correctproblemdetails extends StatelessWidget {
  final int index;

  Correctproblemdetails({Key? key, required this.index}) : super(key: key);

  final List<Color> buttonColors = [
    const Color(0xFF8BC0FF),
    const Color(0xFF55A3FF),
    const Color(0xFF0075FF),
    const Color(0xFF0056BD),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<Problem>(
          future: fetchProblem(index),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData) {
              Problem problem = snapshot.data!;
              return LayoutBuilder(
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
                                children: [
                                  const SizedBox(height: 20), // 간격 조정
                                  SizedBox(
                                    width: 224,
                                    child: Text(
                                      problem.question,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 14, // 텍스트 크기 조정
                                        fontFamily: 'KCC-Hanbit',
                                        fontWeight: FontWeight.w400,
                                        height: 1.5,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  const SizedBox(height: 20), // 간격 조정
                                  for (int i = 0;
                                      i < problem.choices.length;
                                      i++) ...[
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: buttonColors[i],
                                        fixedSize:
                                            const Size(210, 50), // 버튼 크기 조정
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                Correctproblemcommentarypage(
                                                    selectedChoice:
                                                        problem.choices[i]),
                                          ),
                                        ); // 보기 버튼을 누를 때 CommentaryPage로 해당 보기의 텍스트 전달
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              Container(
                                                width: 25,
                                                height: 25,
                                                decoration:
                                                    const ShapeDecoration(
                                                  color: Colors.white,
                                                  shape: OvalBorder(),
                                                ),
                                              ),
                                              Text(
                                                '${i + 1}',
                                                style: const TextStyle(
                                                  color: Color(0xFF0075FF),
                                                  fontSize: 20, // 텍스트 크기 조정
                                                  fontFamily: 'KCC-Hanbit',
                                                  fontWeight: FontWeight.w800,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                              width: 10), // 적절한 간격을 위해 추가
                                          Expanded(
                                            child: Center(
                                              child: Text(
                                                problem.choices[i],
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16, // 텍스트 크기 조정
                                                  fontFamily: 'KCC-Hanbit',
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 20), // 간격 조정
                                  ],
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
                              '맞은 문제',
                              style: TextStyle(
                                fontSize: 18, // 텍스트 크기 조정
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
              );
            } else {
              return const Text('No data');
            }
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
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => MainPage()),
              // );
              break;
            case 2:
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => MainPage()),
              // );
              break;
          }
        },
      ),
    );
  }
}

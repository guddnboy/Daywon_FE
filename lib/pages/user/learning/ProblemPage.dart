import 'package:flutter/material.dart';
import 'package:project/config.dart';
import 'package:project/pages/user/learning/CommentaryPage.dart';
import 'package:project/pages/MainPage.dart';
import 'package:project/pages/user/Mypage/MyPage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Problem {
  final int qId;
  final int scriptsId;
  final String question;
  final List<String> options;
  final int answerOption;
  final int plusPoint;
  final int minusPoint;

  Problem({
    required this.qId,
    required this.scriptsId,
    required this.question,
    required this.options,
    required this.answerOption,
    required this.plusPoint,
    required this.minusPoint,
  });

  factory Problem.fromJson(Map<String, dynamic> json) {
    return Problem(
      qId: json['q_id'],
      scriptsId: json['scripts_id'],
      question: json['question'],
      options: [
        json['option_1'],
        json['option_2'],
        json['option_3'],
        json['option_4']
      ],
      answerOption: json['answer_option'],
      plusPoint: json['plus_point'],
      minusPoint: json['minus_point'],
    );
  }
}

Future<Problem> fetchProblem(int scriptsId) async {
  final response = await http.get(Uri.parse('${Config.apiUrl}/scripts/$scriptsId/questions'));

  if (response.statusCode == 200) {
    final jsonData = json.decode(response.body)[0];
    return Problem.fromJson(jsonData);
  } else {
    throw Exception('Failed to load problem');
  }
}

class ProblemPage extends StatefulWidget {
  final String selectedCategory;
  final int scriptsId;
  final int userId;
  final String apiUrl;

  const ProblemPage({
    Key? key,
    required this.selectedCategory,
    required this.scriptsId,
    required this.userId,
    required this.apiUrl,
  }) : super(key: key);

  @override
  _ProblemPageState createState() => _ProblemPageState();
}

class _ProblemPageState extends State<ProblemPage> {
  late Future<Problem> futureProblem;
  bool isAnswered = false;

  @override
  void initState() {
    super.initState();
    futureProblem = fetchProblem(widget.scriptsId);
  }

  void checkAnswer(int selectedOption, Problem problem) {
    if (!isAnswered) {
      isAnswered = true;
      String resultMessage;
      int points;

      if (selectedOption == problem.answerOption) {
        resultMessage = '맞았습니다! +${problem.plusPoint} 점';
        points = problem.plusPoint;
      } else {
        resultMessage = '틀렸습니다! -${problem.minusPoint} 점';
        points = problem.minusPoint;
      }

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CommentaryPage(
            selectedCategory: widget.selectedCategory,
            scriptsId: widget.scriptsId,
            qId: problem.qId,
            resultMessage: resultMessage,
            points: points,
            selectedChoice: problem.options[selectedOption - 1],
            userId: widget.userId,
            apiUrl: widget.apiUrl,
          ),
        ),
      );
    }
  }

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
          future: futureProblem,
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
                                  const SizedBox(height: 15),
                                  SizedBox(
                                    width: 200,
                                    child: Text(
                                      problem.question,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        height: 1.5,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  for (int i = 0; i < problem.options.length; i++) ...[
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: buttonColors[i],
                                        fixedSize: const Size(210, 50),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                      ),
                                      onPressed: () {
                                        checkAnswer(i + 1, problem);
                                      },
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              Container(
                                                width: 20,
                                                height: 20,
                                                decoration: const ShapeDecoration(
                                                  color: Colors.white,
                                                  shape: OvalBorder(),
                                                ),
                                              ),
                                              Text(
                                                '${i + 1}',
                                                style: const TextStyle(
                                                  color: Color(0xFF0075FF),
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w800,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(width: 10),
                                          Expanded(
                                            child: Center(
                                              child: Text(
                                                problem.options[i],
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 20),
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
                              '오늘의 학습',
                              style: TextStyle(
                                fontSize: 18,
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

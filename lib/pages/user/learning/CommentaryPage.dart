import 'package:flutter/material.dart';
import 'package:project/pages/MainPage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:project/pages/user/learning/ChatBotpage.dart';

class CommentaryPage extends StatelessWidget {
  final String selectedCategory;
  final int scriptsId;
  final int qId;
  final String resultMessage;
  final int points;
  final String selectedChoice;
  final int userId;
  final String apiUrl;
  final String profileImagePath;

  const CommentaryPage({
    Key? key,
    required this.selectedCategory,
    required this.scriptsId,
    required this.qId,
    required this.resultMessage,
    required this.points,
    required this.selectedChoice,
    required this.userId,
    required this.apiUrl,
    required this.profileImagePath
  }) : super(key: key);

  Future<String> fetchProblemExplanation() async {
    final response = await http.get(Uri.parse('$apiUrl/questions/$qId/comments'));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return jsonData['combined_comment'];
    } else {
      throw Exception('Failed to load explanation');
    }
  }

  Future<void> saveUserHistory(bool isCorrect) async {
    final response = await http.post(
      Uri.parse('$apiUrl/user_history/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'user_id': userId,
        'script_id': scriptsId,
        'T_F': isCorrect,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to save user history');
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isCorrect = resultMessage.contains('맞았습니다');

    return Scaffold(
      body: Center(
        child: LayoutBuilder(
          builder: (context, constraints) {
            double containerWidth = constraints.maxWidth * 0.8;
            double containerHeight = constraints.maxHeight * 0.65;

            return FutureBuilder<String>(
              future: fetchProblemExplanation(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.hasData) {
                  String problemExplanation = snapshot.data!;
                  return Stack(
                    children: [
                      Column(
                        children: [
                          Container(
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
                                child: Stack(
                                  children: [
                                    Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 30, vertical: 30),
                                          child: SingleChildScrollView(
                                            child: Container(
                                              width: containerWidth,
                                              height: containerHeight * 0.7,
                                              decoration: ShapeDecoration(
                                                color: const Color.fromARGB(
                                                    223, 234, 230, 230),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                              ),
                                              child: Center(
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      resultMessage,
                                                      style: TextStyle(
                                                        color: isCorrect
                                                            ? Colors.green
                                                            : Colors.red,
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 10),
                                                    Text(
                                                      '획득 포인트: $points',
                                                      style: const TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        height: 1.5,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 10),
                                                    SizedBox(
                                                      width: 186,
                                                      child: Text.rich(
                                                        TextSpan(
                                                          children: [
                                                            TextSpan(
                                                              text:
                                                                  problemExplanation,
                                                              style:
                                                                  const TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 11,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                height: 1.5,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        textAlign:
                                                            TextAlign.justify,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            ElevatedButton(
                                              onPressed: () async {
                                                await saveUserHistory(isCorrect);
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          MainPage(userId: userId, apiUrl: apiUrl, profileImagePath: profileImagePath,)),
                                                );
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(14),
                                                ),
                                                padding: const EdgeInsets.symmetric(
                                                    vertical: 12, horizontal: 20),
                                              ),
                                              child: const Text(
                                                '학습 완료',
                                                style: TextStyle(
                                                  color: Color(0xFF4399FF),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w800,
                                                ),
                                              ),
                                            ),
                                            ElevatedButton(
                                              onPressed: () async {
                                                await saveUserHistory(isCorrect);
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          ChatBotPage(userId: userId, apiUrl: apiUrl, profileImagePath: profileImagePath)), // ChatBotPage로 이동합니다.
                                                );
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(14),
                                                ),
                                                padding: const EdgeInsets.symmetric(
                                                    vertical: 12, horizontal: 20),
                                              ),
                                              child: const Text(
                                                '추가 질문하기',
                                                style: TextStyle(
                                                  color: Color(0xFF4399FF),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w800,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
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
                } else {
                  return const Text('No data');
                }
              },
            );
          },
        ),
      ),
    );
  }
}

// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project/pages/user/Mypage/WrongProblem.dart';
import 'package:project/pages/MainPage.dart';
import 'package:project/pages/user/Mypage/WrongProblemDetails.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Wrongproblemcommentarypage extends StatefulWidget {
  final String selectedChoice;
  final int selectedChoiceNum;
  final int correctOption;
  final int index;
  final int userId;
  final String apiUrl;

  const Wrongproblemcommentarypage({
    Key? key,
    required this.selectedChoice,
    required this.selectedChoiceNum,
    required this.correctOption,
    required this.index,
    required this.userId,
    required this.apiUrl,
  }) : super(key: key);

  @override
  _WrongproblemcommentarypageeState createState() =>
      _WrongproblemcommentarypageeState();
}

class _WrongproblemcommentarypageeState
    extends State<Wrongproblemcommentarypage> {
  late Future<String> _commentaryFuture;
  late bool _isCorrect;

  @override
  void initState() {
    super.initState();
    _commentaryFuture = fetchProblemExplanation();
    _isCorrect = (widget.selectedChoiceNum == widget.correctOption);
    if (_isCorrect) {
      updateUserHistory();
    }
  }

  Future<String> fetchProblemExplanation() async {
    final url =
        Uri.parse('${widget.apiUrl}/questions/${widget.index}/comments');
    final response =
        await http.get(url, headers: {'Accept': 'application/json'});
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final commentary = jsonData['combined_comment'];
      return commentary;
    } else {
      print('Wrongproblemcommentarypage commtary 로드 실패');
      throw Exception('Failed to load commentary');
    }
  }

  Future<void> updateUserHistory() async {
    final url = Uri.parse(
        '${widget.apiUrl}/user_update_history/${widget.userId}/${widget.index}');
    final response = await http.put(url);
    if (response.statusCode == 200) {
      print('히스토리 업데이트 성공');
    } else {
      print('히스토리 업데이트 실패');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: LayoutBuilder(
          builder: (context, constraints) {
            double containerWidth = constraints.maxWidth * 0.8;
            double containerHeight = constraints.maxHeight * 0.65;

            return FutureBuilder<String>(
              future: _commentaryFuture, // 비동기로 문제 해설 내용을 가져옴
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
                                                      widget
                                                          .selectedChoice, // 선택한 보기 내용 표시
                                                      style: const TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        height: 0,
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
                                                                  problemExplanation, // 문제에 대한 해설 표시
                                                              style:
                                                                  const TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 11,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                height: 0,
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
                                        ElevatedButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Wrongproblem(
                                                          userId: widget.userId,
                                                          apiUrl:
                                                              widget.apiUrl)),
                                            );
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(14),
                                            ),
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 16, horizontal: 24),
                                          ),
                                          child: const Text(
                                            '틀린 문제 보기',
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
                              '틀린 문제',
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

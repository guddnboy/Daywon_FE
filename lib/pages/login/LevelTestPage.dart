import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project/config.dart';

class LevelTestPage extends StatefulWidget {
  final void Function(bool) updateTestDone;

  const LevelTestPage({Key? key, required this.updateTestDone}) : super(key: key);

  @override
  _LevelTestPageState createState() => _LevelTestPageState();
}

class _LevelTestPageState extends State<LevelTestPage> {
  List<Map<String, dynamic>> quizzes = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchQuestions();
  }

  Future<void> fetchQuestions() async {
    setState(() {
      isLoading = true;
    });

    try {
      final serverUri = Config.apiUrl;
      final response = await http.get(
        Uri.parse('$serverUri/enroll_quizzes/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(utf8.decode(response.bodyBytes));

        setState(() {
          quizzes = responseData.map((questionData) {
            return {
              'enrollment_quiz_id': questionData['enrollment_quiz_id'] as int,
              'question': questionData['question'] as String,
              'options': [
                questionData['option_1'] as String,
                questionData['option_2'] as String,
                questionData['option_3'] as String,
                questionData['option_4'] as String,
              ],
              'correctAnswerIndex': questionData['correct'] as int,
              'selectedAnswerIndex': -1, // Initialize with -1 for no selection
            };
          }).toList();
          isLoading = false;
        });
      } else {
        if (kDebugMode) {
          print('퀴즈 불러오기 실패 : ${response.statusCode}');
        }
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      if (kDebugMode) {
        print('Quizzes Fetching Error : $e');
      }
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('레벨 테스트'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : quizzes.isEmpty
              ? Center(child: Text('퀴즈를 가져오는 중에 문제가 발생했습니다.'))
              : ListView.builder(
                  itemCount: quizzes.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      margin: const EdgeInsets.all(10),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              quizzes[index]['question'] as String,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Column(
                              children: _buildOptions(index),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _submitAnswersAndShowResult();
        },
        child: const Icon(Icons.check),
      ),
    );
  }

  List<Widget> _buildOptions(int index) {
    List<Widget> optionWidgets = [];
    List<String> options = [
      quizzes[index]['options'][0] as String,
      quizzes[index]['options'][1] as String,
      quizzes[index]['options'][2] as String,
      quizzes[index]['options'][3] as String,
    ];

    for (int i = 0; i < options.length; i++) {
      optionWidgets.add(
        ListTile(
          title: Text(options[i]),
          leading: Radio<int>(
            value: i + 1,
            groupValue: quizzes[index]['selectedAnswerIndex'] as int,
            onChanged: (int? value) {
              setState(() {
                quizzes[index]['selectedAnswerIndex'] = value!;
              });
            },
          ),
        ),
      );
    }

    return optionWidgets;
  }

Future<void> _submitAnswersAndShowResult() async {
  List<Map<String, dynamic>> userAnswers = [];

  for (var question in quizzes) {
    if (question['selectedAnswerIndex'] == -1) {
      _showIncompleteDialog();
      return;
    }

    userAnswers.add({
      'enrollment_quiz_id': question['enrollment_quiz_id'],
      'answer': question['selectedAnswerIndex'],
    });
  }
  try {
    final serverUri = Config.apiUrl;
      final response = await http.post(
        Uri.parse('$serverUri/submit-answers/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({'answers': userAnswers}),
      );
      if (kDebugMode) {
        print(userAnswers);
      }
      if (response.statusCode == 200) {
        String level = response.body;
        if (kDebugMode) {
          print(level);
        }
        _showResultDialog(level);
      } else {
        if (kDebugMode) {
          print('답변 제출 실패 : ${response.statusCode}');
        }
        return;
      }
  } catch (e) {
    if (kDebugMode) {
      print('답변 제출 에러 : $e');
    }
  }
}

  void _showResultDialog(String level ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('테스트 결과'),
          content: Text('당신의 레벨은 ${level}입니다.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
                widget.updateTestDone(true);
              },
              child: const Text('닫기'),
            ),
          ],
        );
      },
    );
  }

  void _showIncompleteDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('테스트 미완료'),
          content: const Text('모든 문제를 풀어주세요.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('확인'),
            ),
          ],
        );
      },
    );
  }
}
